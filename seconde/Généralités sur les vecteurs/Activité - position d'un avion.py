#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: arnaud
"""


class Vecteur:
    def __init__(self, x: float, y: float):
        self.x = x
        self.y = y

    def __add__(self, other):
        return Vecteur(self.x + other.x, self.y + other.y)

    def __sub__(self, other):
        return Vecteur(self.x - other.x, self.y - other.y)

    def __mul__(self, scalaire: float):
        return Vecteur(self.x * scalaire, self.x * scalaire)

    def __repr__(self) -> str:
        return f"({self.x}, {self.y})"


position = Vecteur(0, 0)
vitesse = Vecteur(0, 0)
position = Vecteur(0, 0)


def compute():
    position_x = 0
    position_y = 0
    vitesse_x = 2
    vitesse_y = 1
    acceleration_x = 0
    acceleration_y = -0.5

    for i in range(4):
        position_x += vitesse_x
        position_y += vitesse_y
        vitesse_x += acceleration_x
        vitesse_y += acceleration_y
        print("position = (", position_x, ",", position_y, ")")
        print("vitesse = (", vitesse_x, ",", vitesse_y, ")")
