#import "../../Typst/préambule/évaluation.typ": *
#import "../../Typst/préambule/diagbox.typ": bdiagbox
#import "../../git submodules/typst-canvas/canvas.typ": *

#let pgcd(a, b) = {
  while a != b {
    if a < b {
      b -= a
    } else {
      a -= b
    }
  }
  a
}

#let en_correction = true

#show "X": it => $upright(it)$
#show "G": it => $upright(it)$
#show raw: set text(size: 10pt)
#show raw.where(block: true): set block(inset: 0.7em, stroke: 0.5pt + black, breakable: false)
#set footnote.entry(separator: none)

#show: évaluation.with(
  titre: "Évaluation probabilités",
  titre_en_haut: [Évaluation],
  classe: [1$#{}^(e r e)$STI2D],
  correction: en_correction,
)

#titre(date: [30 mai 2023])[Évaluation probabilités (sujet A)]
#footnote(numbering: x => " ",box(stroke: .5pt + black, inset: 1mm)[→Suite au dos])

#exercice(points: [2,5])[
#let correction_dots(body) = {
  if en_correction {
    text(fill: red, body)
  } else {
    box(width: 3cm, height: 0.5em)[#repeat[.]]
  }
}
On considère une expérience aléatoire qui consiste à lancer trois pièces équilibrées.

Compléter les phrases suivantes avec les mots : "une issue", "issues", "un évènement", "l'évènement", "la probabilité"
+ Cette expérience comporte 8 #correction_dots[issues]. (pile ; face ; pile) est #correction_dots[une issue].
+ "On a obtenu exactement une face" est #correction_dots[un évènement].
+ $"P"(X >= 2)$ est #correction_dots[la probabilité] de #correction_dots[l'évènement] $X$.
]

#exercice(points: [3,5])[
On considère une expérience aléatoire composée d'un nombre variable $n$ d'épreuves de Bernoulli.

+ Si $n = 2$, on a:
  - 1 branche donnant $0$ succès.
  - 2 branches donnant $1$ succès.
  - 1 branche donnant $2$ succès.
+ Si $n = 3$, on a:
  - 1 branche donnant $0$ succès.
  - 2 branches donnant $1$ succès.
  - 3 branches donnant $2$ succès.
  - 1 branche donnant $3$ succès.
+ Compléter le tableau suivant, donnant le nombre de branches donnant $k$ succès pour la répétition de $n$ épreuves de Bernoulli :
  #align(center, table(
    columns: (auto, ..range(5).map(x => 2cm)), align: center + horizon, stroke: 0.5pt,
    box(width: 2em, height: 2em, {
      line(length: 4.24em, start: (-0.5em,0%), angle: 45deg, stroke: 0.5pt)
      place(dy: -1.2em, $n$)
      place(dx: 1.5em, dy: -2.5em, $k$)
    }), [0], [1], [2], [3], [4],
    [1], correction[1], correction[1], [×], [×], [×],
    [2], correction[1], correction[2], correction[1], [×], [×],
    [3], correction[1], correction[3], correction[3], correction[1], [×],
    [4], correction[1], correction[4], correction[6], correction[4], correction[1],
  ))
+ Pour remplir une cellule, il faut additionner le contenu de la cellule au dessus et celle au dessus à gauche.
]

#exercice(points: 6)[
#let PROBAS = (2/6,1/6,3/6)
#let proba_de_x(x) = {
  // sur 36
  let total = 0
  for a in (1,2,3) {
    for b in (1,2,3) {
      if a + b == x {
        total += PROBAS.at(a - 1) * PROBAS.at(b - 1) * 36
      }
    }
  }
  let pgcd = pgcd(total, 36)
  return $#{total/pgcd}/#{36/pgcd}$
}
#let esperance_x() = {
  // sur 36
  let total = 0
  for a in (1,2,3) {
    for b in (1,2,3) {
      total += (a + b) * PROBAS.at(a - 1) * PROBAS.at(b - 1) * 36
    }
  }
  let pgcd = pgcd(total, 36)
  return $#{total/pgcd}/#{36/pgcd}$
}

On lance deux dés cubiques équilibrés, dont les faces sont numérotées 1, 1, 2, 3, 3, 3.
+ #pad(x: 1cm, canvas({
  import "../../git submodules/typst-canvas/draw.typ": *
  let START = (0,0)
  let DICT = ((proba: repr(int(6*PROBAS.at(0))) + "/6",vert: 1), (proba: repr(int(6*PROBAS.at(1))) + "/6",vert: 0), (proba: repr(int(6*PROBAS.at(2))) + "/6",vert: -1))
  let DE1-1 = (3,3)
  let DE1-2 = (3,0)
  let DE1-3 = (3,-3)
  for x in (1,2,3) {
    let point = (3,3*DICT.at(x - 1).vert)
    let proba = DICT.at(x - 1).proba
    line(START, point)
    content(point, " " + repr(x), anchor: "left")
    content((point.first()/2,point.last()/2+0.5), proba, anchor: "below")
    for x in (1,2,3) {
      let point2 = (6.7,point.last() + DICT.at(x - 1).vert)
      let proba = DICT.at(x - 1).proba
      line((point.first() + 0.7, point.last()), point2)
      content(point2, " " + repr(x), anchor: "left")
      content((point2.first()-1,point2.last()+0.5), proba, anchor: "left")
    }
  }
  }))
+ La probabilité d'obtenir un 1 au premier lancé et un 3 au deuxième lancé est alors de 
  $ 2/6 × 3/6 = 6/36 = 1/6 $
+ Les issues donnant au moins un 2 sont $(1;2)$, $(2;1)$, $(2;2)$, $(2;3)$ et $(3;2)$. La probabilité d'obtenir au moins un 2 est donc de
  $ 2/6 × 1/6 + 1/6 × 2/6 + 1/6 × 1/6 + 1/6 × 3/6 + 3/6 × 1/6 = 11/36 $
+ #table(columns: 6, inset: 0.7em,
  [$a_i$], [2], [3], [4], [5], [6],
  [$P(X = a_i)$], {proba_de_x(2)}, {proba_de_x(3)}, {proba_de_x(4)}, {proba_de_x(5)}, {proba_de_x(6)}
  )
+ L'espérance de $X$ est alors 
  $ 2 × 1/9 + 3 × 1/9 + 4 × 13/36 + 5 × 1/6 + 6 × 1/4 = #{esperance_x()} $
]

#exercice(points: 8)[
On définit le jeu suivant :

#grid(columns: (auto, auto),
  column-gutter: 3em,
  align(horizon)[On lance une bille du haut d'une planche cloutée. À chaque  clou, la bille a une chance sur deux de tomber à gauche ou à droite.],
  {
    let clou = circle(fill: gray.lighten(20%), stroke: 0.5pt + black, radius: 0.5mm)
    align(center)[
      #circle(fill: gray.darken(30%), stroke: gray.darken(30%), radius: 0.2cm)
      #clou
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou})
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou}, {clou})
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou}, {clou}, {clou})
      #table(columns: (1.07cm,1.07cm,1.07cm,1.07cm,1.07cm), [-2], [-1], [0], [1], [2])
    ]
  })

+ Combien y-a-t'il des chemins possibles pour la bille ? (Par exemple (gauche ; droite ; droite ; gauche), ou (droite ; droite ; gauche ; gauche))

  Pour chaque case, donner le nombre de chemins qui mènent à cette case.
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-2] ?
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] ?
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[0] ?
+ On donne l'algorithme Python suivant :
  ```python
  from random import randint
  def case():
      c = -2
      for i in range(4):
          c = c + randint(0,1)
      return c
  ```

  Quels sont les résultats possible renvoyés par la fonction `case` ?
+ On définit la variable aléatoire $G$, qui vaut :
  #grid(columns: (1fr,1fr),
    rows: 2em,
    [- $-20$€ si le résultat du jeu est -2 ou -1.],
    [- $0$€ si le résultat du jeu est 0.],
    [- $15$€ si le résultat du jeu est 1.],
    [- $25$€ si le résultat du jeu est 2.],
  )


  compléter la fonction Python suivante, qui simule une partie et renvoie le gain $G$ obtenu :
  ```python
  def gain():
      c = case()
      if c == ______ or c == ______:
          return ______
      if c == ______:
          return 0
      if c == 1:
          return 15
      if c == 2:
          return ______
  ```
+ Remplir le tableau suivant avec la loi de probabilités de $G$ :
  #align(center, table(
    columns: (auto, ..range(4).map(x => 1.7cm)), align: center, stroke: 0.5pt, rows: 2em,
    [$a_i$], [$-20$], [$0$], [$15$], [$25$],
    [$P(G = a_i)$], {correction[$5/16$]}, {correction[$6/16$]}, {correction[$4/16$]}, {correction[$1/16$]},
  ))
+ Calculer l'espérance de $G$.
]

// ==============================================
// ================= SUJET B ====================
// ==============================================

#pagebreak(weak: true)
#titre(date: [30 mai 2023])[Évaluation probabilités (sujet B)]
#footnote(numbering: x => " ", box(stroke: .5pt + black, inset: 1mm)[→Suite au dos])

#exercice(points: [2,5])[
#let correction_dots(body) = {
  if en_correction {
    body
  } else {
     box(width: 3cm, height: 0.5em)[#repeat[.]]
  }
}
On considère une expérience aléatoire qui consiste à lancer trois pièces équilibrées.

Compléter les phrases suivantes avec les mots : "une issue", "issues", "un évènement", "l'évènement", "la probabilité"
+ Cette expérience comporte 8 #correction_dots[issues]. (pile ; face ; pile) est #correction_dots[une issue].
+ "On a obtenu exactement une face" est #correction_dots[un évènement].
+ $P(X >= 2)$ est #correction_dots[la probabilité] de #correction_dots[l'évènement] $X$.
]

#exercice(points: [3,5])[
On lance une pièce équilibrée dans les airs.

+ Donner une épreuve de Bernoulli associée avec cette expérience.
+ On répète cette épreuve 3 fois : quelle est la probabilité d'obtenir 3 piles ?
+ À l'aide d'un arbre de probabilités, donner le nombre de branches donnant exactement 1 face. Quelle est alors la probabilité d'obtenir exactement une face sur les trois lancés ?
]

#exercice(points: 6)[
On lance deux dés cubiques équilibrés, dont les faces sont numérotées 1, 2, 2, 3, 3, 3.
+ Faire un arbre qui représente cette situation.
+ Quelle est la probabilité d'obtenir un 1 au premier lancé et un 3 au deuxième lancé ?
+ Quelle est la probabilité d'obtenir *au moins* un 2 sur les deux lancés ?
+ On définit la variable aléatoire $X$, qui est égale à la somme des deux dés.

  Donner la loi de probabilité de $X$ sous forme d'un tableau.
+ Quelle est la valeur de l'espérance de $X$ ?
]

#exercice(points: 8)[
On définit le jeu suivant :

#grid(columns: (auto, auto),
  column-gutter: 3em,
  align(horizon)[On lance une bille du haut d'une planche cloutée. À chaque  clou, la bille a une chance sur deux de tomber à gauche ou à droite.],
  {
    let clou = circle(fill: gray.lighten(20%), stroke: 0.5pt + black, radius: 0.5mm)
    align(center)[
      #circle(fill: gray.darken(30%), stroke: gray.darken(30%), radius: 0.2cm)
      #clou
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou})
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou}, {clou})
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou}, {clou}, {clou})
      #table(columns: (1.07cm,1.07cm,1.07cm,1.07cm,1.07cm), [-2], [-1], [0], [1], [2])
    ]
  })

+ Combien y-a-t'il des chemins possibles pour la bille ? (Par exemple (gauche ; droite ; droite ; gauche), ou (droite ; droite ; gauche ; gauche))

  Pour chaque case, donner le nombre de chemins qui mènent à cette case.
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-2] ?
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] ?
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[0] ?
+ On donne l'algorithme Python suivant :
  ```python
  from random import randint
  def case():
      c = -2
      for i in range(4):
          c = c + randint(0,1)
      return c
  ```

  Quels sont les résultats possible renvoyés par la fonction `case` ?
+ On définit la variable aléatoire $G$, qui vaut :
  #grid(columns: (1fr,1fr),
    rows: 2em,
    [- $-10$€ si le résultat du jeu est -2 ou -1.],
    [- $0$€ si le résultat du jeu est 0.],
    [- $5$€ si le résultat du jeu est 1.],
    [- $15$€ si le résultat du jeu est 2.],
  )


  compléter la fonction Python suivante, qui simule une partie et renvoie le gain $G$ obtenu :
  ```python
  def gain():
      c = case()
      if c == ______ or c == ______:
          return ______
      if c == ______:
          return 0
      if c == 1:
          return 15
      if c == 2:
          return ______
  ```
+ Remplir le tableau suivant avec la loi de probabilités de $G$ :
  #align(center, table(
    columns: (auto, ..range(4).map(x => 1.7cm)), align: center, stroke: 0.5pt, rows: 2em,
    [$a_i$], [$-10$], [$0$], [$5$], [$15$],
    [$P(G = a_i)$], {correction[$5/16$]}, {correction[$6/16$]}, {correction[$4/16$]}, {correction[$1/16$]},
  ))
+ Calculer l'espérance de $G$.
]


// ==============================================
// ================= SUJET C ====================
// ==============================================

#pagebreak(weak: true)
#titre(date: [2 juin 2023])[Évaluation probabilités (sujet C)]
#footnote(numbering: x => " ", box(stroke: .5pt + black, inset: 1mm)[→Suite au dos])

#exercice(points: [2,5])[
#let correction_dots(body) = {
  if en_correction {
    body
  } else {
     box(width: 3cm, height: 0.5em)[#repeat[.]]
  }
}
On considère une expérience aléatoire qui consiste à lancer trois pièces équilibrées.

Compléter les phrases suivantes avec les mots : "une issue", "issues", "un évènement", "l'évènement", "la probabilité"
+ Cette expérience comporte 8 #correction_dots[issues]. (pile ; face ; pile) est #correction_dots[une issue].
+ "On a obtenu exactement une face" est #correction_dots[un évènement].
+ $P(X >= 2)$ est #correction_dots[la probabilité] de #correction_dots[l'évènement] $X$.
]

#exercice(points: [3,5])[
On lance une pièce équilibrée dans les airs.

+ Donner une épreuve de Bernoulli associée avec cette expérience.
+ On répète cette épreuve 3 fois : quelle est la probabilité d'obtenir 3 piles ?
+ À l'aide d'un arbre de probabilités, donner le nombre de branches donnant exactement 1 face. Quelle est alors la probabilité d'obtenir exactement une face sur les trois lancés ?
]

#exercice(points: 6)[
On lance deux dés cubiques équilibrés, dont les faces sont numérotées 1, 1, 1, 2, 3, 3.
+ Faire un arbre qui représente cette situation.
+ Quelle est la probabilité d'obtenir un 1 au premier lancé et un 3 au deuxième lancé ?
+ Quelle est la probabilité d'obtenir *au moins* un 2 sur les deux lancés ?
+ On définit la variable aléatoire $X$, qui est égale à la somme des deux dés.

  Donner la loi de probabilité de $X$ sous forme d'un tableau.
+ Quelle est la valeur de l'espérance de $X$ ?
]

#exercice(points: 8)[
On définit le jeu suivant :

#grid(columns: (auto, auto),
  column-gutter: 3em,
  align(horizon)[On lance une bille du haut d'une planche cloutée. À chaque  clou, la bille a une chance sur deux de tomber à gauche ou à droite.],
  {
    let clou = circle(fill: gray.lighten(20%), stroke: 0.5pt + black, radius: 0.5mm)
    align(center)[
      #circle(fill: gray.darken(30%), stroke: gray.darken(30%), radius: 0.2cm)
      #clou
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou})
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou}, {clou})
      #stack(dir: ltr, spacing: 1cm, {clou}, {clou}, {clou}, {clou})
      #table(columns: (1.07cm,1.07cm,1.07cm,1.07cm,1.07cm), [-2], [-1], [0], [1], [2])
    ]
  })

+ Combien y-a-t'il des chemins possibles pour la bille ? (Par exemple (gauche ; droite ; droite ; gauche), ou (droite ; droite ; gauche ; gauche))

  Pour chaque case, donner le nombre de chemins qui mènent à cette case.
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-2] ?
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] ?
+ Quelle est la probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[0] ?
+ On donne l'algorithme Python suivant :
  ```python
  from random import randint
  def case():
      c = -2
      for i in range(4):
          c = c + randint(0,1)
      return c
  ```

  Quels sont les résultats possible renvoyés par la fonction `case` ?
+ On définit la variable aléatoire $G$, qui vaut :
  #grid(columns: (1fr,1fr),
    rows: 2em,
    [- $-30$€ si le résultat du jeu est -2 ou -1.],
    [- $0$€ si le résultat du jeu est 0.],
    [- $15$€ si le résultat du jeu est 1.],
    [- $40$€ si le résultat du jeu est 2.],
  )


  compléter la fonction Python suivante, qui simule une partie et renvoie le gain $G$ obtenu :
  ```python
  def gain():
      c = case()
      if c == ______ or c == ______:
          return ______
      if c == ______:
          return 0
      if c == 1:
          return 15
      if c == 2:
          return ______
  ```
+ Remplir le tableau suivant avec la loi de probabilités de $G$ :
  #align(center, table(
    columns: (auto, ..range(4).map(x => 1.7cm)), align: center, stroke: 0.5pt, rows: 2em,
    [$a_i$], [$-30$], [$0$], [$15$], [$40$],
    [$P(G = a_i)$], {correction[$5/16$]}, {correction[$6/16$]}, {correction[$4/16$]}, {correction[$1/16$]},
  ))
+ Calculer l'espérance de $G$.
]
