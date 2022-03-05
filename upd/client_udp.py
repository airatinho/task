import socket
soc=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
soc.sendto(b'Test message',('localhost',8888))