import time

import psutil
import pymysql
from fastapi import APIRouter

from api.utils import response_code

router = APIRouter()


@router.get('/dashboard/getinfo')
def getinfo():
    from init_global import g
    res = {}
    db = g.db_pool.connection()
    cur = db.cursor()
    cur.execute(f'select count(app_name) from app_list')
    res['app_count'] = cur.fetchall()[0][0]
    cur.execute(f'select count(app_name) from app_list where status="running"')
    res['app_run_count'] = cur.fetchall()[0][0]
    res['image_count'] = len(g.dc.images.list())
    res['networks_count'] = len(g.dc.networks.list())
    cur = db.cursor(cursor=pymysql.cursors.DictCursor)
    cur.execute(f'select * from app_list order by start_time desc limit 10')
    res['recent_event'] = cur.fetchall()
    db.close()
    return response_code.resp_200(data={"res": res})


def get_performance():
    res = {}
    # cpu
    cpuCount = psutil.cpu_count(logical=False)  # CPU核心
    cpuPercent = psutil.cpu_percent(0.5)  # 使用率
    cpufree = round(100 - cpuPercent, 2)  # CPU空余
    # 内存
    m = psutil.virtual_memory()  # 内存信息
    memoryTotal = round(m.total / (1024.0 * 1024.0 * 1024.0), 2)  # 总内存
    memoryUsed = round(m.used / (1024.0 * 1024.0 * 1024.0), 2)  # 已用内存
    memoryFree = round(memoryTotal - memoryUsed, 2)  # 剩余内存
    # 磁盘
    io = psutil.disk_partitions()
    diskCount = len(io)
    diskTotal = 0  # 总储存空间大小
    diskUsed = 0  # 已用
    diskFree = 0  # 剩余
    for i in io:
        try:
            o = psutil.disk_usage(i.mountpoint)
            diskTotal += int(o.total / (1024.0 * 1024.0 * 1024.0))
            diskUsed += int(o.used / (1024.0 * 1024.0 * 1024.0))
            diskFree += int(o.free / (1024.0 * 1024.0 * 1024.0))
        except:
            pass
    res['cpu'] = cpuPercent
    res['mem'] = m.percent
    res['disk'] = o.percent
    res['memoryTotal'] = memoryTotal
    res['memoryUsed'] = memoryUsed
    res['diskTotal'] = diskTotal
    res['diskUsed'] = diskUsed
    return res


def push_realinfo():
    from init_global import g
    from main import socket_manager as sm
    print(g.person_online)
    while g.person_online:
        res = get_performance()
        # print(res)
        g.push_loop.run_until_complete(sm.emit('dashboard', {'data': res}))
        time.sleep(3)
