import uvicorn
from fastapi import FastAPI
from fastapi_socketio import SocketManager
from starlette.middleware.cors import CORSMiddleware

import init_global
from api.routers import user, application, file, scheduler, test, image, dashboard
from api.routers.dashboard import push_realinfo

app = FastAPI()
app.add_event_handler("startup", init_global.init)
app.add_event_handler("shutdown", init_global.shutdown)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 设置允许的origins来源
    allow_credentials=True,
    allow_methods=["*"],  # 设置允许跨域的http方法，比如 get、post、put等。
    allow_headers=["*"])  # 允许跨域的headers，可以用来鉴别来源等作用。

app.include_router(user.router)
app.include_router(application.router, tags=['app'])
app.include_router(file.router, tags=['file'])
app.include_router(scheduler.router, tags=['scheduler'])
app.include_router(image.router, tags=['image'])
app.include_router(test.router, tags=['test'])
app.include_router(dashboard.router, tags=['dashboard'])

socket_manager = SocketManager(app=app, mount_location='/ws', socketio_path='socket.io', cors_allowed_origins=[])


@app.sio.event
def connect(sid, namespace):
    from init_global import g
    g.person_online = True
    g.threads_pool.submit(push_realinfo)


@app.sio.event
def disconnect(sid):
    from init_global import g
    g.person_online = False
    pass


@app.get("/", status_code=404)
async def create_item():
    return


if __name__ == "__main__":
    import settings

    uvicorn.run("main:app", host="0.0.0.0", port=settings.fastapi_port, reload=settings.fastapi_deload,
                debug=settings.fastapi_debug)
