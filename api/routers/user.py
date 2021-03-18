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
    if item.username == "admin" and item.password == "123456":  # todo 密码
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
    elif res1["sub"] == "admin":
        res2 = {
            'roles': ["admin"]
        }
    else:
        res2 = {
            'roles': ["others"]
        }
    return response_code.resp_200(data=res2)


@router.post("/logout", tags=["users"])
async def logout():
    return response_code.resp_200(data='success')


@router.get("/get_roles", tags=["users"])
async def get_roles():
    data = [
        {"key": "admin", "name": "admin", "description": "Super Administrator. Have access to view all pages.", },
        {"key": "editor", "name": "editor",
         "description": "Normal Editor. Can see all pages except permission page", },
        {"key": "visitor", "name": "visitor",
         "description": "Just a visitor. Can only see the home page and the document page", "routes": [
            {"path": "", "redirect": "dashboard", "children": [{"path": "dashboard", "name": "Dashboard",
                                                                "meta": {"title": "dashboard",
                                                                         "icon": "dashboard"}}]}]}]
    return response_code.resp_200(data=data)


# @router.get("/get_routes", tags=["users"])
# async def get_routes():
#     data = [{"path": "/login"}]
#     return response_code.resp_200(data=data)
