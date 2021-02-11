from datetime import datetime, timedelta
from typing import Any, Union, Optional

from fastapi import Header
from jose import jwt, ExpiredSignatureError, JWTError

# 导入配置文件
from settings import Config

ALGORITHM = "HS256"


def create_access_token(subject: Union[str, Any]) -> str:
    """
    # 生成token
    :param subject: 保存到token的值
    :return:
    """
    expire = datetime.utcnow() + timedelta(
        minutes=Config.ACCESS_TOKEN_EXPIRE_MINUTES
    )  # 失效时间
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, Config.SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


def check_jwt_token(token: Optional[str] = Header(None)) -> Union[str, Any]:
    """
    解析验证 headers中为token的值 担任也可以用 Header(None, alias="Authentication") 或者 alias="X-token"
    :param token:
    :return:
    """
    try:
        payload = jwt.decode(
            token,
            Config.SECRET_KEY, algorithms=[ALGORITHM]
        )
        return payload
    except (jwt.JWTError, jwt.ExpiredSignatureError, AttributeError):
        # 抛出自定义异常， 然后捕获统一响应
        return "error"
