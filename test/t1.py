from sqlalchemy import Column, Integer, String, Table, Float, MetaData
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base

# engine = create_engine("mysql+pymysql://root:7ujm8ik,@192.168.4.193:3306/testsql", max_overflow=5)
engine = create_engine('mysql+pymysql://root:38311eb4e582@47.94.199.65:3306/coco')


# 创建单表
metadata = MetaData(engine)
Table('cao', metadata,
      Column('Id', Integer, primary_key=True, nullable=False)
      )
metadata.create_all()
