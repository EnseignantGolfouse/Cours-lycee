#import "../../Typst/préambule/activité.typ": activité
#import "../../git submodules/typst-canvas/canvas.typ": canvas

#show: activité.with(classe: [$1^(e r e)$STI2D], titre: "Activité Python : turtle")
#show raw.where(block: true): it => box(inset: 0.8em, stroke: black, it)

#box(stroke: black, fill: gray.lighten(50%), inset: 0.8em, radius: 8pt)[
  On va utiliser le module `turtle` de Python, qui permet de faire bouger un objet (la "tortue") sur l'écran avec du code.
]

+ #columns(2)[Créer un nouveau fichier Python dans Spyder, et rentrer le code ci-contre.

#v(1em)

Modifier ce programme afin de dessiner un carré avec la tortue.

#colbreak()
```python
import turtle

t = turtle.Turtle()

t.forward(50)
t.right(90)
t.forward(50)

turtle.exitonclick()
```]
+ #columns(2)[
Réaliser le dessin ci-contre en utilisant une boucle `for` :
#colbreak()

#canvas(length: 0.5cm, {
  import "../../git submodules/typst-canvas/draw.typ": *

  line((0,0), (0,4), (4,4), (4,0), (0,0))
  for (x,y) in ((0,0),(3,0),(0,3),(3,3)) {
    line((x,y), (x,y+1), (x+1,y+1), (x+1,y), (x,y))
  }
})
]
+ On veut pouvoir diriger notre tortue dans une direction spécifique, plutôt que d'aller tout droit et d'utiliser des rotations.

    Définir alors des fonctions pour se déplacer dans les directions cardinales :
  #grid(columns: 2, column-gutter: 1em, [
  ```python
def avance_haut(t, nombre):
    t.setheading(METTRE_UN_NOMBRE_ICI)
    t.forward(nombre)

def avance_droite(t, number):
    # REMPLIR
# etc
  ```], [#box(stroke: black, fill: gray.lighten(50%), inset: 0.8em, radius: 8pt)[
  La méthode `setheading` permet de régler l'orientation de la tortue, avec un angle donné en degrés.
  ]])
  
+ Créer une fonction `tortue_aléatoire(t)`, qui simule 30 pas de 20 unités selon les probabilités suivante :
  
  #align(center, table(columns: 5,
    [Direction], [Haut], [Bas], [Droite], [Gauche],
    [Probabilité], [0,5], [0,1], [0,25], [0,15]
  ))

  On pourra utiliser la fonction `random` :
  ```python
  from random import random
  random() # renvoie un nombre décimal entre 0 et 1
  ```
+ Recopier et compléter la fonction suivante qui simule `n` routes de la tortue, et renvoie la moyenne des positions d'arrivées :

  #grid(columns: (auto, 1fr), column-gutter: 1em, [
    ```python
def positions_darrivée_moyenne(n):
    t = turtle.Turtle()
    t.speed(0)  # vitesse maximale
    total_x = 0
    total_y = 0
    for i in range(n):
        t.setposition(0, 0) # Remet la tortue au centre
        tortue_aléatoire(t)
        (x, y) = t.position()
        total_x = total_x + _________
        total_y = total_y + _________
    moyenne_x = _________
    moyenne_y = _________
    return (moyenne_x, moyenne_y)
  ```
  ], [Utiliser cette fonction pour obtenir la position moyenne pour `n = 10`, `20`, et `30` :
  - `n = 10` : (............ , ............)
  - `n = 20` : (............ , ............)
  - `n = 30` : (............ , ............)
])