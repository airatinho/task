import socket
soc=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)#udp protocol
soc.bind(('localhost',8888))
result=soc.recv(1024)
print('Message',result.decode('utf-8'))
soc.close()