import asyncio

import docker
from fastapi import APIRouter

from api.utils import response_code
from routers import push
from util import ThreadPool_util

router = APIRouter()
from init_global import g


def transform(b):
    if 1024 <= b < 1024 * 1024:
        b = str(round(b / 1024, 2)) + ' KB'  # 千字节
    elif 1024 * 1024 <= b < 1024 * 1024 * 1024:
        b = str(round(b / 1024 / 1024, 2)) + ' MB'  # 兆字节
    elif 1024 * 1024 * 1024 <= b < 1024 * 1024 * 1024 * 1024:
        b = str(round(b / 1024 / 1024 / 1024, 2)) + ' GB'  # 千兆字节
    return b


@router.get('/image/pull')
def image_pull(image_name: str):
    g.threads_pool.submit(g.dc.images.pull(image_name))
    return response_code.resp_200(data={"res": 1})


@router.get('/image/getlist')
def image_getlist():
    temp1 = g.dc.images.list()
    res = []
    for i in temp1:
        if not i.tags:
            tags = ['无']
        else:
            tags = i.tags
        temp2 = {
            'id': i.short_id.replace('sha256:', ''),
            'tag': tags[0],
            'create_time': i.attrs['Created'].split('.')[0],
            'size': transform(i.attrs['Size'])
        }
        res.append(temp2)
    return response_code.resp_200(data={"res": res})


@router.get('/image/getname')
def image_getname():
    temp1 = g.dc.images.list()
    res = [i.tags[0] for i in temp1]
    return response_code.resp_200(data={"res": res})


@router.get('/image/delete')
def image_delete(name: str):
    g.dc.images.remove(image=name)
    return response_code.resp_200(data={"res": 1})


def dockerfile_loop(response):
    loop = asyncio.new_event_loop()
    loop.run_until_complete(build_push(response))


async def build_push(response):
    from main import socket_manager as sm
    for line in response:
        if line.get('stream'):
            print(line['stream'])
            await sm.emit('dockerfile_log', {'data': line['stream']})
    push.push_success(f'mysql镜像构建成功')


@router.get('/image/build')
def image_build(code: str):
    # file = open('/home/user_code/image_build/mysql/dockerfile', 'w')
    # file.write(code)
    # file.close()
    try:
        response = g.dc.api.build(path="/home/user_code/image_build/mysql",
                                  dockerfile="dockerfile",
                                  tag='mysql-zym', decode=True, nocache=False, rm=True)
    except docker.errors.BuildError as exc:
        for line in exc.build_log:
            print(line.get("stream", line.get("error")))

    g.threads_pool.submit(dockerfile_loop, response).add_done_callback(ThreadPool_util.callback)
    return response_code.resp_200(data={"res": 1})
