import socket

soc=socket.socket(socket.AF_INET,socket.SOCK_STREAM)# tcp protocol
soc.bind(('localhost',8888))
soc.listen(5)#сколько соединений ждать до момента обработки
while True:
    try:
        client,addr=soc.accept()#принимает клиента, если его нет, то ожидает его
    except KeyboardInterrupt:
        soc.close()
        break
    else:
        result=client.recv(1024)
        response=b'Рот твой ебал'
        client.send(response)
        client.close()
        print('Message',result.decode('utf-8'))