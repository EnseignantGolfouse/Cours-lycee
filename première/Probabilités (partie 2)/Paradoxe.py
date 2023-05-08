# Paradoxe de "Just one more"

from random import randint


def simulation_n_lances(depart: float, n: int) -> float:
    resultat = depart
    for _ in range(n):
        if randint(0, 1) == 0:
            resultat *= 1.8
        else:
            resultat *= 0.5
    return resultat


def simulation_population(nombre_joueurs: int, depart: float, iterations: int) -> list[float]:
    result = []
    for _ in range(nombre_joueurs):
        result.append(simulation_n_lances(depart, iterations))
    return result


def moyenne(L: list[float]) -> float:
    m = 0
    for x in L:
        m += x
    return m / len(L)


def mediane(L: list[float]) -> float:
    return L[len(L) // 2]


L = simulation_population(10_000, 100, 20)
L.sort()
m = moyenne(L)
print(f"moyenne = {m}")
print(f"médiane = {mediane(L)}")
