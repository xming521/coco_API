from concurrent.futures.thread import ThreadPoolExecutor
import logging


def func():
    lst = [1, 2]
    # 写一个bug，测试是否或报错
    print(lst[3])


def callback(f):
    exception = f.exception()
    if exception:
        # 如果exception获取到了值，说明有异常.exception就是异常类
        print(exception)
        logging.exception(exception)



if __name__ == '__main__':
    pool = ThreadPoolExecutor(1)
    # 用这种方法不会异常，ThreadPoolExecutor/ProcessPoolExecutor会将异常封装到futures对象中，需要调用.exception()方法获取异常
    pool.submit(func).add_done_callback(callback)

    pool.shutdown()