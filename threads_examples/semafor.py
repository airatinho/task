from threading import Thread, BoundedSemaphore
from time import sleep, time
ticket_office = BoundedSemaphore(value=3)
def ticket_buyer(number):
   start_service = time()
   with ticket_office:
       sleep(1)
       print(f"client {number}, service time: {time() - start_service} \n")
buyer = [Thread(target=ticket_buyer, args=(i,)) for i in range(10)]
for b in buyer:
   b.start()