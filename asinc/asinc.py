import os
import json
import asyncio

path="jsons/"
num_f=len(os.listdir(path))

async def m_funct(num_f:int)->list:
    """Сортирует айдишники из json от трех источников"""
    results=[]
    for i in range(num_f):
        try:
            data =  asyncio.wait_for(
                json.load(
                    open(f"jsons/source_{i+1}.json",encoding="utf-8")
                )
            )#ошибка таймаута 2 секунды, после которых падаем в ошибку asyncio.TimeoutError
            await results.extend(data.get(str(i+1)))
        except Exception:
            continue
    return sorted(results, key=lambda k: k['id'])

async def hello_world():
    result= await m_funct(num_f)
    return print(result)
asyncio.run(hello_world())