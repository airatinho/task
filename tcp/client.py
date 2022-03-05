import socket

soc=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
soc.connect(("localhost",8888))
soc.send(b'Text message')
soc.close()