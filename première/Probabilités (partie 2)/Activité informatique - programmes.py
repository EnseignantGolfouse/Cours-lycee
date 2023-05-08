from matplotlib import pyplot
from random import randint


def Pluie():
    N = 0
    for _ in range(1, 40):
        x = randint(1, 365)
        if x <= 170:
            N = N + 1
    return N


def echantillons():
    L = []
    for _ in range(400):
        L.append(Pluie())
    return L


L = echantillons()
pyplot.hist(L, bins=[x*0.05 for x in range(21)])
pyplot.show()
