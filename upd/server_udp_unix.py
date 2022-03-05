import socket
import os
unix_soc_name='unix.sock'
soc=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

if os.path.exists(unix_soc_name):
    os.remove(unix_soc_name)

soc.bind(unix_soc_name)

while True:
    try:
        result=soc.recv(1024)
    except KeyboardInterrupt:
        soc.close()
        break
    else:
        print('Message',result.decode('utf-8'))