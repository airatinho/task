
from collections import defaultdict

pairs = [
(None, 'a0'),
] + [
(f'a{i}', f'a{i + 1}')
for i in range(1000)
]

from typing import List
def to_tree(inp_list_of_dicts:List[tuple])->dict:
    """Преобразует список кортежей в дерево(словарь)"""

    d= defaultdict(dict)
    for ind, val in enumerate(inp_list_of_dicts):
        v,k=val
        if v==k:
            raise ValueError(f'Значения узла не должны быть одинаковыми!\n{v}=={k}')
        elif k is None:
            raise ValueError('Узел нижнего уровня должен иметь родителя!')
        elif v is not None:
            if v[0]!=k[0]:
                raise ValueError(f'Отсутствует связь!\n{v[0]} не равно {k[0]}') #Пример: у "a"-элемента подразумевается связь только с "а"-элементами
            elif int(v[1:])>=int(k[1:]):
                raise ValueError(f'Узел нижнего уровня не должен \nссылаться на верхние уровни!\n{int(v[1:])} больше, чем {int(k[1:])}')
        elif ind>0:
            if v is None:
                if (inp_list_of_dicts[ind-1][0] is None) and (inp_list_of_dicts[ind-1][1][0]==k[0]):
                    raise  ValueError(f'Нарушен порядок на уровне {ind}!')
                elif inp_list_of_dicts[ind-1][0] is not None:
                    raise  ValueError(f'Нарушен порядок на уровне {ind}!')
            elif (inp_list_of_dicts[ind-1][0] == v ) and (inp_list_of_dicts[ind-1][1] == k ):
                    raise  ValueError(f'Найден дубликат на уровне {ind}!')
            elif (inp_list_of_dicts[ind-1][0] is not None) and (inp_list_of_dicts[ind-1][0][0] == v[0]):
                if int(inp_list_of_dicts[ind-1][0][0][1:]) > int(v[1:]):
                    raise  ValueError(f'Нарушен порядок на уровне {ind}!')
        d[v][k]={}
    d.pop(None)
    keys_d=[] # формируем узлы на удаление
    for i in d.keys():
        for j in d[i].keys():
            if j in d.keys():
                d[i][j].update(d[j])
                keys_d.append(j)

    for i in keys_d:
        d.pop(i)
    return d

to_tree(pairs)