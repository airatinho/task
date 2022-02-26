def calc_v(height:list)->int:
    """Возвращает заполняемый объем"""

    #убираем максимум одиночку и присваиваем ему значение второго максимума
    if height.count(max(height))==1:
        height[height.index(max(height))]=sorted(height)[-2]

    #производим рассчет объема
    max_height = 0
    ind_max_heigh=0
    vol=0
    for ind,val in enumerate(height):

        if val>=max_height:

            if (ind-ind_max_heigh)>1:
                for i in range(ind_max_heigh,ind):
                    vol+=abs(max_height-height[i])
                # print(ind,
                #       height[ind:].count(max(height[ind:])),
                #       max(height[ind:]),
                #       sorted(height[ind:])[-2])
                if height[ind:].count(max(height[ind:])) == 1:
                    try:
                        max_height = sorted(height[ind:])[-2]
                        print("z nen",height[height[ind:].index(max(height[ind:]))])
                        print(height)
                    except Exception:
                        pass
            else:
                ind_max_heigh=ind
                max_height=val
    return vol
a=[2,0,3,1,0,1]
print(calc_v(a))