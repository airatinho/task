import queue
import threading
import time


def func(q, thread_no):
    while True:
        task = q.get()
        print(f'Thread #{thread_no} is doing task #{task} in the queue.')
        print(f"{thread_no ** 2}\n")
        q.task_done()
        print(f'Thread #{thread_no} task #{task}  done.')

q = queue.Queue()

for i in range(4):
    worker = threading.Thread(target=func, args=(q, i,), daemon=True)
    worker.start()

for j in range(5):
    q.put(j)

q.join()
