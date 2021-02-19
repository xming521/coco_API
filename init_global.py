import asyncio
from concurrent.futures.thread import ThreadPoolExecutor

import apscheduler
import docker
import pymysql

from dbutils.pooled_db import PooledDB
from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from apscheduler.schedulers.background import BackgroundScheduler

from settings import Config

host = '127.0.0.1'


class GlobalV:
    db_pool: PooledDB
    dc: docker.client.DockerClient
    threads_pool: ThreadPoolExecutor
    background_scheduler: apscheduler.schedulers.background.BackgroundScheduler
    push_loop: asyncio.events.AbstractEventLoop
    person_online: bool


def init():
    g.db_pool = PooledDB(
        creator=pymysql,  # 使用链接数据库的模块
        maxconnections=100,  # 连接池允许的最大连接数，0和None表示不限制连接数
        mincached=5,  # 初始化时，链接池中至少创建的空闲的链接，0表示不创建
        blocking=True,  # 连接池中如果没有可用连接后，是否阻塞等待。True，等待；False，不等待然后报错
        ping=2,
        # ping MySQL服务端，检查是否服务可用。
        # 如：0 = None = never,
        # 1 = default = whenever it is requested,
        # 2 = when a cursor is created,
        # 4 = when a query is executed,
        # 7 = always
        host=host,
        port=3306,
        user='root',
        password=Config.sql_password,
        database='coco',
        charset='utf8',
        autocommit=True
    )
    # g.db = pymysql.connect(host=host, database='coco', autocommit=True, user=Config.sql_user,
    #                        password=Config.sql_password,
    #                        charset="utf8")
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
    # g.db.close()
    g.db_pool.close()
    g.background_scheduler.shutdown(wait=False)
    g.dc.close()


g = GlobalV()
