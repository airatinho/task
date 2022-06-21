
import threading
import time
from threading import Condition,Thread
cond = Condition()
def f1():
    while True:
        with cond:
            cond.wait()
            print("Получили событие!\n")

def f2():
    for i in range(20):
        if i%10==0:
            with cond:
                cond.notify()
        else:
            print(f"f1:{i}")
        time.sleep(1)

def func():
    for i in range(5):
        print(f"from child thread: {i}")
        time.sleep(0.5)

if __name__ == '__main__':

    #Condition
    threading.Thread(target=f1).start()
    threading.Thread(target=f2).start()

    #Демоны и ожидание выполнения
    # th = Thread(target=func,daemon=True)
    # th = Thread(target=func)
    # th.start()
    # # th.join()
    # print("App stop")