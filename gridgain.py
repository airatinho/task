from  pygridgain import Client
cl=Client()
cl.connect('127.0.0.1', 10800)

#создаем кэш
cache=cl.get_or_create_cache('my cache')

#пихаем что нибудь в кэш
cache.put(1,'Инопланятяне, заберите меня отсюда!')
cache.put(2,'Сбербанк, заберите меня отсюда!')
#получаем то что засунули
result=cache.get(2)
# result=cache.get_and_put(2,'Сбербанк, заберите меня отсюда!')
print(result)
# cl.close()