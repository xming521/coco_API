from fastapi import APIRouter
import psutil

from api.utils import response_code
router = APIRouter()
from init_global import g


@router.get('/dashboard/getinfo')
def getinfo():
    res = {}
    cur = g.db.cursor()
    cur.execute(f'select count(app_name) from app_list')
    res['app_count'] = cur.fetchall()[0][0]
    cur.execute(f'select count(app_name) from app_list where status="running"')
    res['app_run_count'] = cur.fetchall()[0][0]
    res['image_count'] = len(g.dc.images.list())
    res['networks_count'] = len(g.dc.networks.list())

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
    res['mem'] = memoryUsed
    res['disk'] = diskUsed
    # res.append(
    #     {
    #         'ttl': '内存状态',
    #         'subtext': '总内存' + str(memoryTotal) + 'G',
    #         'keys': ['已用', '剩余'],
    #         'json': [{'value': memoryUsed, 'name': '已用'}, {'value': memoryFree, 'name': '剩余'}],
    #         'pieBox': 'echartsMemory',
    #         'suffix': 'G'
    #     })
    # res.append(
    #     {
    #         'ttl': '磁盘状态',
    #         'subtext': str(diskCount) + '个分区.' + '共' + str(diskTotal) + 'G',
    #         'keys': ['已使用', '未使用'],
    #         'json': [{'value': diskUsed, 'name': '已使用'}, {'value': diskFree, 'name': '未使用'}],
    #         'pieBox': 'echartsDisk',
    #         'suffix': 'G'
    #     })

    return response_code.resp_200(data={"res": res})