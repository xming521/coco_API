from fastapi import APIRouter

from api.utils import response_code

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
        temp2 = {
            'id': i.short_id.replace('sha256:', ''),
            'name': i.tags[0].split(':')[0],
            'tag': i.tags[0].split(':')[-1],
            'create_time': i.attrs['Created'].split('.')[0],
            'size': transform(i.attrs['Size'])
        }
        res.append(temp2)
    return response_code.resp_200(data={"res": res})


@router.get('/image/delete')
def image_delete(name: str):
    g.dc.images.remove(image=name)
    return response_code.resp_200(data={"res": 1})
