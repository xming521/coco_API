from init_global import g


def push_info(text, extra: dict = {}):
    from main import socket_manager as sm
    extra.update({'text': text, 'type': 'info'})
    g.push_loop.run_until_complete(sm.emit('push', {'data': extra}))


def push_success(text, extra: dict = {}):
    from main import socket_manager as sm
    extra.update({'text': text, 'type': 'success'})
    g.push_loop.run_until_complete(sm.emit('push', {'data': extra}))


def push_error(text, extra: dict = {}):
    from main import socket_manager as sm
    extra.update({'text': text, 'type': 'error'})
    g.push_loop.run_until_complete(sm.emit('push', {'data': extra}))
