import turtle
from random import random


def question1():
    t = turtle.Turtle()

    t.forward(40)
    t.right(90)
    t.forward(40)
    t.right(90)
    t.forward(40)
    t.right(90)
    t.forward(40)

    turtle.exitonclick()


def question2():
    t = turtle.Turtle()

    for _ in range(4):
        t.forward(200)
        t.right(90)
        t.forward(50)
        t.right(90)
        t.forward(50)
        t.right(90)
        t.forward(50)
        t.right(90)
        t.forward(50)
        t.right(90)

    turtle.exitonclick()


def avance_haut(t, nombre):
    t.setheading(90)
    t.forward(nombre)


def avance_droite(t, nombre):
    t.setheading(0)
    t.forward(nombre)


def avance_gauche(t, nombre):
    t.setheading(180)
    t.forward(nombre)


def avance_bas(t, nombre):
    t.setheading(270)
    t.forward(nombre)


def tortue_aléatoire(t):
    STEP = 20
    for _ in range(30):
        r = random()
        if r < 0.5:
            avance_haut(t, STEP)
        elif r < 0.6:
            avance_bas(t, STEP)
        elif r < 0.85:
            avance_droite(t, STEP)
        else:
            avance_gauche(t, STEP)


def positions_darrivée_moyenne(n):
    t = turtle.Turtle()
    t.speed(0)  # vitesse maximale
    total_x = 0
    total_y = 0
    for i in range(n):
        t.setposition(0, 0)
        tortue_aléatoire(t)
        (x, y) = t.position()
        total_x = total_x + x
        total_y = total_y + y
    moyenne_x = total_x / n
    moyenne_y = total_y / n
    return (moyenne_x, moyenne_y)


def positions_darrivée_moyenne_alt(n):
    def tortue_aléatoire_alt(tortues):
        STEP = 20
        for _ in range(30):
            for t in tortues:
                r = random()
                if r < 0.5:
                    avance_haut(t, STEP)
                elif r < 0.6:
                    avance_bas(t, STEP)
                elif r < 0.85:
                    avance_droite(t, STEP)
                else:
                    avance_gauche(t, STEP)
    tortues = [turtle.Turtle() for _ in range(n)]
    for t in tortues:
        t.speed(0)
    total_x = 0
    total_y = 0
    tortue_aléatoire_alt(tortues)
    for t in tortues:
        (x, y) = t.position()
        total_x = total_x + x
        total_y = total_y + y
    moyenne_x = total_x / n
    moyenne_y = total_y / n
    return (moyenne_x, moyenne_y)


print("10 simulations :", positions_darrivée_moyenne(10))
print("20 simulations :", positions_darrivée_moyenne(20))
print("30 simulations :", positions_darrivée_moyenne_alt(30))

turtle.exitonclick()
