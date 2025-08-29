def lcg(n, seed=1, a=1103515245, c=12345, m=2**31):
    x = seed
    return [(-1 if (x := (a*x+c)%m) % 2 == 0 else 1) for _ in range(n)]

with open("pseudo.dat", "w") as f:
    f.write("\n".join(map(str, lcg(20, seed=7))))

