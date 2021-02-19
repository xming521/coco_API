from typing import Optional

import bunch
import pymysql
from apscheduler.triggers.cron import CronTrigger
from fastapi import APIRouter
from pydantic.main import BaseModel

from api.utils import response_code
from core.Run import RunApp

router = APIRouter()
from init_global import g


def app_start(app_name):
    db = g.db_pool.connection()
    cursor = db.cursor(cursor=pymysql.cursors.DictCursor)
    cursor.execute(f"select * from app_list where app_name='{app_name}'")
    res: dict = cursor.fetchall()[0]
    db.close()
    res.update({'code': '', 'run_type': 'second'})
    item = bunch.Bunch(res)  # 将字典转化为对象
    app = RunApp(item)
    app.app_run()


class Param(BaseModel):
    hours: Optional[int] = 0
    days: Optional[int] = 0
    minutes: Optional[int] = 0
    seconds: Optional[int] = 0
    crontab_expression: Optional[str] = None


class Job(BaseModel):
    app_name: str
    type: str
    param: Param


# 分为间隔 和corn两种类型
@router.post("/scheduler/create")
def scheduler_create(job: Job):
    if job.type == 'interval':
        temp = job.param.dict()
        temp.pop('crontab_expression')
        g.background_scheduler.add_job(app_start, "interval", **temp, args=[job.app_name], jobstore='default')
    elif job.type == 'cron':
        g.background_scheduler.add_job(app_start, CronTrigger.from_crontab(job.param.crontab_expression),
                                       args=[job.app_name], jobstore='default')

    return response_code.resp_200(data={
        'items': 1
    })


@router.get('/scheduler/get_jobs')
def get_jobs():
    jobs = g.background_scheduler.get_jobs()
    res = []
    for i in jobs:
        temp = {'app_name': i.args[0], 'id': i.id,
                'next_run_time': str(i.next_run_time).split('.')[0],
                'trigger': str(i.trigger)}
        res.append(temp)
    return response_code.resp_200(data={
        'res': res
    })


@router.get('/scheduler/delete_jobs')
def delete_jobs(id: str):
    g.background_scheduler.remove_job(id, jobstore='default')
    return response_code.resp_200(data={
        'res': 1
    })
