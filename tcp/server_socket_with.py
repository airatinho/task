import socket
port=8888
addres='localhost'
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as soc:
    print(f"{port} is bind")
    soc.bind((addres,port))

    while True:
        result=soc.recv(1024)
        print("Message",result.decode('utf-8'))