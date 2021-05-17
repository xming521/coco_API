from fastapi import APIRouter
from pydantic import BaseModel

from api.utils import response_code
from api.utils.security import create_access_token, check_jwt_token

router = APIRouter()


class Item(BaseModel):
    username: str
    password: str


@router.post("/login", tags=["users"])
async def check_users(item: Item):
    if (
            item.username == "admin" or item.username == "tester" or item.username == "developer") and item.password == "123456":  # todo 密码
        print(item.username)
        return response_code.resp_200(data={
            "token": create_access_token(item.username),
        })
    else:
        return response_code.resp_501(message='用户名或密码错误')


@router.get("/info", tags=["users"])
async def get_info(token: str):
    res1 = check_jwt_token(token)
    if res1 == 'error':  # token错误 或者过期
        return response_code.resp_50008()
    else:
        res2 = {
            'roles': [res1["sub"]],
            'name': res1["sub"],
            'avatar': ''
        }
    return response_code.resp_200(data=res2)


@router.post("/logout", tags=["users"])
async def logout():
    return response_code.resp_200(data='success')


@router.get("/get_roles", tags=["users"])
async def get_roles():
    data = [
        {"key": "admin", "name": "管理员", "description": "超级管理员，可以所有页面", },
        {"key": "tester", "name": "测试员", "description": "只能查看部分页面", },
        {"key": "developer", "name": "开发者", "description": "应用修改、应用添加和管理", "routes": [
            {"path": "", "redirect": "dashboard", "children": [{"path": "dashboard", "name": "Dashboard",
                                                                "meta": {"title": "dashboard",
                                                                         "icon": "dashboard"}}]}]}]
    return response_code.resp_200(data=data)

# @router.get("/get_routes", tags=["users"])
# async def get_routes():
#     data = [{"path": "/login"}]
#     return response_code.resp_200(data=data)
