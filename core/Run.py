import asyncio
import os
import time
from queue import Queue

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
        self.queue = Queue()
        self.code = item.code
        self.timeout = item.timeout
        self.mount_dict = {
            mount_path: {'bind': '/mnt', 'mode': 'rw'}  # 这是字典 mount_path挂载到/mnt/path
        }
        self.envi_list = ["PYTHONUNBUFFERED=1"]
        if not os.path.exists(f"{mount_path}/{item.app_name}"):
            os.makedirs(f"{mount_path}/{item.app_name}/log")

        if item.run_type == 'first' or item.run_type == 'modified':  # todo  修改过的
            self.write_code()  # 写入文件
        db = g.db_pool.connection()
        self.container = g.dc.containers.create(item.image_name,
                                                f"python /mnt/{self.app_name}/{filename}",
                                                detach=True,
                                                volumes=self.mount_dict,
                                                environment=self.envi_list,
                                                network=item.network
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
        db.close()

    def write_code(self, **kw):
        with open(f'{mount_path}/{self.app_name}/{filename}', 'w') as f:
            f.write(self.code)

    def app_running_loop(self):
        loop = asyncio.new_event_loop()
        loop.run_until_complete(self.app_running())

    def app_run(self, **kw):
        self.container.start()
        self.push.push_success(f"{self.app_name}运行成功")
        self.g.threads_pool.submit(self.app_running_loop)
        self.g.threads_pool.submit(self.app_exit)
        self.g.threads_pool.submit(self.app_timeout)
        # print(len(threads_pool._threads)) 当前线程池使用线程数量

    async def app_running(self):
        with open(f'{mount_path}/{self.app_name}/log/{self.container.short_id}-log.txt', 'w+', buffering=1) as f:
            for i in self.container.logs(stream=True, stderr=True, timestamps=False):
                j = str(i, encoding="utf-8").replace('\b', '').replace('\r', '\n')
                f.write(j)
                await self.sm.emit('print_log', {'data': j})
            await self.sm.emit('print_log', {'data': '运行结束'})

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
