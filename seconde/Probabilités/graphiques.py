from matplotlib import pyplot
from random import randint

# Lire et comprendre une fonction Python renvoyant le nombre ou la fréquence de
# succès dans un échantillon de taille n pour une expérience aléatoire à deux issues.

# Loi des grands nombres

# Simuler N échantillons de taille n d’une expérience aléatoire à deux issues. Si p
# est la probabilité d’une issue et f sa fréquence observée dans un échantillon,
# calculer la proportion des cas où l’écart entre p et f est inférieur ou égal à 1/√n

pyplot.show()

resultat_2_des = [0] * 12
nombres = [i + 2 for i in range(12)]

for _ in range(2000):
    for i in range(10):
        de1 = randint(1, 6)
        de2 = randint(1, 6)
        resultat_2_des[de1 + de2 - 2] += 1

    pyplot.cla()
    pyplot.bar(nombres, resultat_2_des)
    pyplot.draw()
    pyplot.pause(0.01)

pyplot.pause(100)
