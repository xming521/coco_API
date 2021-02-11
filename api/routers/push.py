from init_global import g


def push_info(text):
    from main import socket_manager as sm
    g.push_loop.run_until_complete(sm.emit('push', {'data': {'text': text, 'type': 'info'}}))


def push_success(text):
    from main import socket_manager as sm
    g.push_loop.run_until_complete(sm.emit('push', {'data': {'text': text, 'type': 'success'}}))


def push_error(text):
    from main import socket_manager as sm
    g.push_loop.run_until_complete(sm.emit('push', {'data': {'text': text, 'type': 'error'}}))
