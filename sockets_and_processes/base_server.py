import time
from multiprocessing.managers import BaseManager

def get_time():
    return "пошел на хуй"

BaseManager.register("get", callable=get_time)
manager=BaseManager(address=('127.0.0.1',4444),authkey=b'123')
server=manager.get_server()
print("Server started")
server.serve_forever()#навсегда запускает сервер