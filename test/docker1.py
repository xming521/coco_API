import docker

dc = docker.from_env()
res=dc.images.list()
for i in res:
    print(i.attrs)
pass
