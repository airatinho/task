import asyncio

import time

async def waiter() -> None:
    await cook1('Паста', 8)
    await cook1('Салат Цезарь', 3)
    await cook1('Отбивные', 16)

async def cook1(order, time_to_prepare):
    print(f'Новый заказ: {order}')
    await asyncio.sleep(time_to_prepare)
    print(order, '- готово')

if __name__ == '__main__':
    asyncio.run(waiter())