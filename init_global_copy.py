import time
from concurrent.futures.thread import ThreadPoolExecutor

import docker
import pymysql

from settings import Config

def init():





class GlobalV:
    db: pymysql.connections.Connection
    dc: docker.client.DockerClient
    threads_pool: ThreadPoolExecutor


g = GlobalV()


def __init__(self):
    host = "47.94.199.65"
    self.db = pymysql.connect(host=host, database='coco', autocommit=True, user=Config.sql_user,
                              password=Config.sql_password,
                              charset="utf8", )


dc = docker.from_env()
threads_pool = ThreadPoolExecutor(max_workers=35)


async def job():
    time.sleep(5)
    print('hi')

# loop=asyncio.new_event_loop()
# asyncIO_scheduler = AsyncIOScheduler(event_loop=loop)
# asyncIO_scheduler.start()
# loop.run_forever()

# asyncIO_scheduler = AsyncIOScheduler()
# # scheduler.add_job(job, "interval", seconds=3)
# asyncIO_scheduler.start()
# asyncio.get_event_loop().run_forever()
