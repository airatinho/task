def generate_permutations(n,m=-1,prefix=None):
    m=len(n) if m==-1 else m
    prefix = prefix or []
    if m==0:
        print(prefix)
        return
    for number in n:
        if number in prefix:
            continue
        prefix.append(number)
        generate_permutations(n,m-1,prefix)
        prefix.pop()
generate_permutations(["a","b","c"])