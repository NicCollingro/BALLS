import secrets

randomnumber = [str(secrets.choice([-1, 1])) for _ in range(20)]

with open("zufallszahlen.dat", "w") as datei:
    datei.write("\n".join(randomnumber))
