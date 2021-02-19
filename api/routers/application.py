import time
from typing import Optional

import bunch
import pymysql
from fastapi import APIRouter, Body
from pydantic import BaseModel
from starlette.responses import FileResponse

from api.utils import response_code
from core.Run import RunApp
from settings import mount_path, filename

router = APIRouter()
from init_global import g
from api.routers import push


class App_item(BaseModel):
    code: str
    app_name: str
    image_name: str
    run_command: str
    timeout: int
    app_type: str
    run_type: str
    network: Optional[str] = None


@router.post("/app_submit")
def submit(item: App_item):
    db = g.db_pool.connection()
    if item.run_type == 'first':
        cursor = db.cursor()
        cursor.execute(f"select * from app_list where app_name='{item.app_name}'")
        if cursor.fetchall():
            push.push_error(f"{item.app_name}已经创建了,请前往修改")
            db.close()
            return response_code.resp_200(data={"status": 0})
    app = RunApp(item)
    app.app_run()  # 使用异步 开启新协程
    db.close()
    return response_code.resp_200(data={"status": 1})


@router.get("/app_list")
def app_list():
    db=g.db_pool.connection()
    cursor = db.cursor(cursor=pymysql.cursors.DictCursor)
    cursor.execute(f"select * from app_list order by start_time desc")
    res: dict = cursor.fetchall()
    db.close()
    return response_code.resp_200(data={
        'items': res
    })


@router.get("/container_list")
def container_list(app_name: str):
    db = g.db_pool.connection()
    cursor = db.cursor(cursor=pymysql.cursors.DictCursor)
    cursor.execute(f"select * from container_list where app_name='{app_name}'order by start_time desc")
    res: dict = cursor.fetchall()
    db.close()
    return response_code.resp_200(data={
        'items': res
    })


@router.get("/app_start")
def app_start(app_name: str):
    db = g.db_pool.connection()
    cursor = db.cursor(cursor=pymysql.cursors.DictCursor)
    cursor.execute(f"select * from app_list where app_name='{app_name}'")
    res: dict = cursor.fetchall()[0]
    res.update({'code': '', 'run_type': 'second'})
    item = bunch.Bunch(res)  # 将字典转化为对象
    app = RunApp(item)
    app.app_run()  # 使用异步 开启新协程
    db.close()
    return response_code.resp_200(data={"status": 1})


@router.get("/app_stop")
def app_stop(app_name: str):
    status = 0
    db = g.db_pool.connection()
    cursor = db.cursor(cursor=pymysql.cursors.DictCursor)
    cursor.execute(f"select status from app_list where app_name='{app_name}' ")
    res = cursor.fetchall()[0]
    if res['status'] == 'stopped' or res['status'] == 'success' or res['status'] == 'error':
        push.push_error(f'{app_name}已经停止了')
        return response_code.resp_200(data={"status": status})
    cursor.execute(f"select * from container_list where app_name='{app_name}' order by start_time desc limit 1")
    res = cursor.fetchall()[0]
    container = g.dc.containers.get(res['container_id'])
    container.kill()
    container.reload()
    for i in range(5):
        if container.status == 'exited':
            status = 1
            break
        else:
            time.sleep(0.3)
            try:
                container.reload()
            except:
                status = 1
                break
    time.sleep(0.5)
    cursor.execute(f"update container_list set status='136' where container_id='{res['container_id']}'")
    db.close()
    return response_code.resp_200(data={"status": status})


@router.get("/app_getinfo")
def app_getinfo(app_name: str):
    db = g.db_pool.connection()
    cursor = db.cursor(cursor=pymysql.cursors.DictCursor)
    cursor.execute(f"select * from app_list where app_name='{app_name}'")
    res: dict = cursor.fetchall()[0]
    code = open(f'{mount_path}/{app_name}/{filename}', 'r').read()
    res.update({'code': code})
    db.close()
    return response_code.resp_200(data={"res": res})


@router.get("/app_getname")
def app_getinfo():
    db = g.db_pool.connection()
    cursor = db.cursor(cursor=pymysql.cursors.DictCursor)
    cursor.execute(f"select app_name from app_list ")
    res = cursor.fetchall()
    res = [i['app_name'] for i in res]
    db.close()
    return response_code.resp_200(data={"res": res})


@router.get("/app_getlog")
def app_getlog(app_name: str, container_id: str):
    log = open(f'{mount_path}/{app_name}/log/{container_id}-log.txt', 'r').read()
    return response_code.resp_200(data={"res": log})


@router.post("/download_log")
def download_log(app_name: str = Body(..., title='app_name', embed=True),
                 container_id: str = Body(..., title='container_id', embed=True)):
    return FileResponse(f'{mount_path}/{app_name}/log/{container_id}-log.txt',
                        filename=f'{app_name}-{container_id}')
