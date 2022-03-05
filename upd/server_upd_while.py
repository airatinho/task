import socket

soc=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
soc.bind(('localhost',8888))

while True:
    try:
        result=soc.recv(1024)
    except KeyboardInterrupt:
        soc.close()
        break
    else:
        print('Message',result.decode('utf-8'))