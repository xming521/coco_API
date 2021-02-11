import traceback

import pymysql

from settings import Config


def sql_getcon():
    host = "47.94.199.65"
    # host="127.0.0.1"
    db = pymysql.connect(host=host, database='coco', autocommit=True,user=Config.sql_user, password=Config.sql_password, charset="utf8",)
    return db


# def sql_modify(db, str):
#     cursor = db.cursor()
#     try:
#         cursor.execute(str)
#         db.commit()
#     except Exception as e:
#         traceback.print_exc()
#         db.rollback()


# def insert_plus()


if __name__ == '__main__':
    sql_getcon()
