import time
import traceback

from fastapi import APIRouter, File, UploadFile, Form, Body
from starlette.responses import FileResponse

from api.utils import response_code
from settings import mount_path
from util.file_api import *

router = APIRouter()


@router.get("/file_list")
def file_list(path: str):
    path = mount_path + path
    try:
        Files = sorted(os.listdir(path))
        dir_ = []
        file_ = []
        fileQuantity = len(Files)
        for i in Files:
            try:
                i = os.path.join(path, i)
                if not os.path.isdir(i):
                    if os.path.islink(i):
                        fileLinkPath = os.readlink(i)
                        file_.append({
                            'path': i,
                            'formattedSize': getFileSize(i),
                            'name': os.path.split(i)[1] + '-->' + fileLinkPath,
                            'updateTime': time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(os.stat(i).st_mtime)),
                            'power': oct(os.stat(i).st_mode)[-3:],
                            'fileType': 'file',
                            'dir': False
                        })
                    else:
                        file_.append({
                            'path': i,
                            'formattedSize': getFileSize(i),
                            'name': os.path.split(i)[1],
                            'updateTime': time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(os.stat(i).st_mtime)),
                            'power': oct(os.stat(i).st_mode)[-3:],
                            'fileType': 'file',
                            'dir': False
                        })
                else:
                    dir_.append({
                        'path': i,
                        'name': os.path.split(i)[1],
                        'formattedSize': getFileSize(i),
                        'updateTime': time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(os.stat(i).st_mtime)),
                        'power': oct(os.stat(i).st_mode)[-3:],
                        'fileType': 'dir',
                        'dir': True

                    })
            except Exception as e:
                print(e)
                continue
        returnJson = {
            'path': path,
            'fileQuantity': fileQuantity,
            'files': dir_ + file_
        }
    except Exception as e:
        print(traceback.format_exc())
    # print(returnJson)
    return response_code.resp_200(data={
        'res': returnJson
    })


@router.post("/create_dir")  # 不使用新建一个class
def create_dir(path: str = Body(..., title='path', embed=True),
               dir_name: str = Body(..., title="dir_name", embed=True)):
    path = mount_path + path
    if os.path.exists(os.path.join(path, dir_name)):
        print('创建文件夹重名')
    else:
        os.mkdir(os.path.join(path, dir_name))
        return response_code.resp_200(data={})


@router.post("/file_upload")
async def file_upload(path: str = Form(...), file: UploadFile = File(...)):
    content = await file.read()
    with open(f'{mount_path}{path}/{file.filename}', 'wb+') as f:
        f.write(content)
    return response_code.resp_200(data={})


@router.post("/delete_file")
def delete(paths: list = Body(..., title='paths', embed=True)):
    for fileName in paths:
        fileName = mount_path + fileName.replace('//', '/')
        result = delete_(fileName)
    return response_code.resp_200(data={})


@router.post("/download_file")
def download(path: str = Body(..., title='paths', embed=True)):
    file_name = mount_path + path.replace('//', '/')
    return FileResponse(file_name, filename=file_name.split('/')[-1])
