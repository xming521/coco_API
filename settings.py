SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30


class Config():
    ACCESS_TOKEN_EXPIRE_MINUTES = 600
    SECRET_KEY = 'zym233521'
    sql_user = "root"
    sql_password = "38311eb4e582"


mount_path = '/home/user_code/app'  # 修改挂载目录就可以改整套系统的运行目录
filename = 'main.py'
