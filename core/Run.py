import asyncio
import os
import time

from settings import mount_path, filename


class RunApp:
    def __init__(self, item):
        from init_global import g
        from main import socket_manager as sm
        from api.routers import push
        self.sm = sm
        self.g = g
        self.push = push
        self.app_name = item.app_name
        self.code = item.code
        self.timeout = item.timeout
        self.mount_dict = {
            mount_path: {'bind': '/mnt', 'mode': 'rw'},  # 这是字典 mount_path挂载到/mnt/path
            '/home/user_code/app/tensorflow_train/dataset': {'bind': '/root/.keras/datasets/', 'mode': 'rw'}
        }
        self.envi_list = ["PYTHONUNBUFFERED=1", f"APPNAME={self.app_name}"]
        if not os.path.exists(f"{mount_path}/{item.app_name}"):
            os.makedirs(f"{mount_path}/{item.app_name}/log")

        if item.run_type == 'first' or item.run_type == 'modified':  # todo  修改过的
            self.write_code()  # 写入文件
        db = g.db_pool.connection()
        if self.app_name == 'FlaskApp':
            ports = {
                '5000/tcp': 5000
            }
        else:
            ports = {}
        if self.app_name == 'COVID_19_spider':
            shell = f"/mnt/{self.app_name}/{filename}"
        else:
            shell = f"python /mnt/{self.app_name}/{filename}"
        self.container = g.dc.containers.create(item.image_name,
                                                shell,
                                                detach=True,
                                                volumes=self.mount_dict,
                                                environment=self.envi_list,
                                                network=item.network,
                                                ports=ports
                                                )
        start_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        if item.run_type == 'first':
            sql_str = f"insert into app_list(app_name,image_name,run_command,timeout,status,start_time,app_type,network) " \
                      f"values ('{self.app_name}','{item.image_name}','{item.run_command}',{item.timeout},'running','{start_time}','{item.app_type}','{item.network}') "
        elif item.run_type == 'second' or item.run_type == 'modified':
            sql_str = f"update app_list set image_name='{item.image_name}' ,run_command='{item.run_command}',timeout='{item.timeout}'" \
                      f",status='running',start_time='{start_time}',network='{item.network}'where app_name='{self.app_name}'"
        cur = db.cursor()
        cur.execute(sql_str)
        sql_str = f"insert into container_list(container_id,app_name,image_name,run_command,start_time) " \
                  f"values ('{self.container.short_id}','{self.app_name}','{item.image_name}','{item.run_command}','{start_time}') "
        cur.execute(sql_str)
        cur.execute(f'delete from app_performance where app_name="{self.app_name}"')
        db.close()

    def write_code(self, **kw):
        with open(f'{mount_path}/{self.app_name}/{filename}', 'w') as f:
            f.write(self.code)

    def app_running_loop(self):
        loop = asyncio.new_event_loop()
        loop.run_until_complete(self.app_running())

    def app_run(self, **kw):
        from util import ThreadPool_util
        self.g.threads_pool.submit(self.app_monitor).add_done_callback(ThreadPool_util.callback)
        self.container.start()
        self.push.push_success(f"{self.app_name}启动成功", {'refresh': True})
        self.g.threads_pool.submit(self.app_running_loop)
        self.g.threads_pool.submit(self.app_exit)
        self.g.threads_pool.submit(self.app_timeout)
        # todo 下面线程池捕获异常
        # print(len(threads_pool._threads)) 当前线程池使用线程数量

    def app_monitor(self):
        db = self.g.db_pool.connection()
        from util import dictToObj
        cur = db.cursor()
        for stat in self.container.stats(decode=True, stream=True):
            if stat['precpu_stats'].get('system_cpu_usage') is None:
                stat['precpu_stats']['system_cpu_usage'] = 0
            memory_stats = dictToObj.dictToobj(stat['memory_stats'])
            cpu_stats = dictToObj.dictToobj(stat['cpu_stats'])
            precpu_stats = dictToObj.dictToobj(stat['precpu_stats'])
            used_memory = memory_stats.usage - memory_stats.stats.cache
            available_memory = memory_stats.limit
            Memor_yusage = (used_memory / available_memory) * 100.0
            cpu_delta = cpu_stats.cpu_usage.total_usage - precpu_stats.cpu_usage.total_usage
            system_cpu_delta = cpu_stats.system_cpu_usage - precpu_stats.system_cpu_usage
            number_cpus = cpu_stats.online_cpus
            CPU_usage = (cpu_delta / system_cpu_delta) * number_cpus * 100.0
            # print(Memor_yusage, CPU_usage)
            cur_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
            sql_str = f"insert into app_performance(app_name,time,Cpu,Memory) " \
                      f"values ('{self.app_name}','{cur_time}',{round(CPU_usage, 2)},{round(Memor_yusage, 2)}) "
            cur.execute(sql_str)
        db.close()

    async def app_running(self):
        with open(f'{mount_path}/{self.app_name}/log/{self.container.short_id}-log.txt', 'w+', buffering=1) as f:
            for i in self.container.logs(stream=True, stderr=True, timestamps=False):
                j = str(i, encoding="utf-8").replace('\b', '').replace('\r', '\n')
                f.write(j)
                await self.sm.emit('print_log', {'data': j, 'app_name': self.app_name})
            await self.sm.emit('print_log', {'data': '运行结束', 'app_name': self.app_name})

    def app_exit(self):  # 退出
        res = self.container.wait()
        db = self.g.db_pool.connection()
        db.cursor().execute(
            f"update container_list "
            f"set over_time ='{time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())}',"
            f" status='{res['StatusCode']}'"
            f"where container_id='{self.container.short_id}'")
        self.container.remove(v=True)  # todo 删除
        if res['StatusCode'] == 0:
            db.cursor().execute(f"update app_list set status ='success' where app_name='{self.app_name}'")
            self.push.push_success(f'{self.app_name}运行完成', {'refresh': True})
        elif res['StatusCode'] == 1:
            db.cursor().execute(f"update app_list set status ='error' where app_name='{self.app_name}'")
            self.push.push_error(f'{self.app_name}运行出现错误', {'refresh': True})
        elif res['StatusCode'] == 2:
            db.cursor().execute(f"update app_list set status ='error' where app_name='{self.app_name}'")
            self.push.push_error(f'{self.app_name}运行可能出现路径错误', {'refresh': True})
        elif res['StatusCode'] == 137:
            db.cursor().execute(f"update app_list set status ='stopped' where app_name='{self.app_name}'")
            self.push.push_error(f'{self.app_name}运行超时或被手动停止', {'refresh': True})
        else:
            db.cursor().execute(f"update app_list set status ='error' where app_name='{self.app_name}'")
            self.push.push_error(f'{self.app_name}运行出现未知问题', {'refresh': True})
        db.close()

    def app_timeout(self):  # 超时退出
        self.container.stop(timeout=self.timeout)
