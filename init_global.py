import asyncio
from concurrent.futures.thread import ThreadPoolExecutor

import apscheduler
import docker
import pymysql
from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from apscheduler.schedulers.background import BackgroundScheduler

from settings import Config

host = "47.94.199.65"


class GlobalV:
    db: pymysql.connections.Connection
    dc: docker.client.DockerClient
    threads_pool: ThreadPoolExecutor
    background_scheduler: apscheduler.schedulers.background.BackgroundScheduler
    push_loop: asyncio.events.AbstractEventLoop
    person_online: bool


def init():
    g.db = pymysql.connect(host=host, database='coco', autocommit=True, user=Config.sql_user,
                           password=Config.sql_password,
                           charset="utf8")
    g.dc = docker.from_env()
    g.threads_pool = ThreadPoolExecutor(max_workers=200)
    # 任务队列
    g.background_scheduler = BackgroundScheduler()
    job_stores = {'default': SQLAlchemyJobStore(url='mysql+pymysql://root:38311eb4e582@47.94.199.65:3306/coco',
                                                tablename='scheduler_jobs')}
    g.background_scheduler.configure(jobstores=job_stores)
    g.background_scheduler.start()
    g.background_scheduler.print_jobs(jobstore='default')
    # 推送协程
    g.push_loop = asyncio.new_event_loop()


def shutdown():
    g.person_online = False
    g.threads_pool.shutdown(wait=False)
    g.db.close()
    g.background_scheduler.shutdown(wait=False)
    g.dc.close()


g = GlobalV()
