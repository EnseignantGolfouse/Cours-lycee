#import "../../Typst/préambule/évaluation.typ": *
#import "../../Typst/préambule/diagbox.typ": bdiagbox
#import "../../git submodules/typst-canvas/canvas.typ": *

// ===============================================
// ================= PRÉAMBULE ===================
// ===============================================

#let pgcd(a, b) = {
  if a == 0 or b == 0 {
    return 1
  }
  while a != b {
    if a < b {
      b -= a
    } else {
      a -= b
    }
  }
  a
}
#let content_fraction_sur(nombre, denom) = {
  let num = calc.round(nombre * denom)
  let pgcd = pgcd(num, denom)
  denom =  calc.round(denom / pgcd)
  num = calc.round(num / pgcd)
  if denom == 1 {
    $#num$
  } else {
    $#num/#denom$
  }
}
#let correction_dots(body) = {
  text(fill: red, body)
}
#let PROBAS = (2/6,1/6,3/6)
#let exo2_proba_de_x(probas,x) = {
  // sur 36
  let total = 0
  for a in (1,2,3) {
    for b in (1,2,3) {
      if a + b == x {
        total += probas.at(a - 1) * probas.at(b - 1)
      }
    }
  }
  return content_fraction_sur(total, 36)
}
#let exo2_esperance_x(probas) = {
  // sur 36
  let total = 0
  for a in (1,2,3) {
    for b in (1,2,3) {
      total += (a + b) * probas.at(a - 1) * probas.at(b - 1)
    }
  }
  return content_fraction_sur(total, 36)
}

#let en_correction = true

#show "X": it => $upright(it)$
#show "G": it => $upright(it)$
#show raw: set text(size: 10pt)
#show raw.where(block: true): set block(inset: 0.7em, stroke: 0.5pt + black, breakable: false)
#show math.frac: it => {
  text(size: 1.2em, it)
}
#set footnote.entry(separator: none)

#show: évaluation.with(
  titre: "Évaluation probabilités",
  titre_en_haut: [Évaluation],
  classe: [1$#{}^(e r e)$STI2D],
  correction: en_correction,
)

// ===============================================
// ================= SUJET A =====================
// ===============================================

#titre(date: [30 mai 2023])[Évaluation probabilités (sujet A)]

#exercice(points: [2,5])[
On considère une expérience aléatoire qui consiste à lancer trois pièces équilibrées.

Compléter les phrases suivantes avec les mots : "une issue", "issues", "un évènement", "l'évènement", "la probabilité"
+ Cette expérience comporte 8 #correction_dots[issues]. (pile ; face ; pile) est #correction_dots[une issue].
+ "On a obtenu exactement une face" est #correction_dots[un évènement].
+ $"P"(X >= 2)$ est #correction_dots[la probabilité] de #correction_dots[l'évènement] $X$.
]

#exercice(points: [3,5])[
+ Si $n = 2$, on a:
  - 1 branche donnant $0$ succès.
  - 2 branches donnant $1$ succès.
  - 1 branche donnant $2$ succès.
+ Si $n = 3$, on a:
  - 1 branche donnant $0$ succès.
  - 3 branches donnant $1$ succès.
  - 3 branches donnant $2$ succès.
  - 1 branche donnant $3$ succès.
+ #align(center, table(
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
#{PROBAS = (1/3,1/6,1/2)}
+ #pad(x: 1cm, canvas({
  import "../../git submodules/typst-canvas/draw.typ": *
  let START = (0,0)
  let DICT = ((proba: content_fraction_sur(PROBAS.at(0),6),vert: 1), (proba: content_fraction_sur(PROBAS.at(1),6),vert: 0), (proba: content_fraction_sur(PROBAS.at(2),6),vert: -1))
  let DE1-1 = (3,3)
  let DE1-2 = (3,0)
  let DE1-3 = (3,-3)
  for x in (1,2,3) {
    let point = (3,3*DICT.at(x - 1).vert)
    let proba = DICT.at(x - 1).proba
    line(START, point)
    content(point, " " + repr(x), anchor: "left")
    content((point.first()/2,point.last()/2+0.5), proba)
    for x in (1,2,3) {
      let point2 = (6.7,point.last() + DICT.at(x - 1).vert)
      let proba = DICT.at(x - 1).proba
      line((point.first() + 0.7, point.last()), point2)
      content(point2, " " + repr(x), anchor: "left")
      content(if x == 3 { (point2.first()-1.2,point2.last()) } else { (point2.first()-0.8,point2.last()+0.35) }, proba)
    }
  }
  }))
+ La probabilité d'obtenir un 1 au premier lancé et un 3 au deuxième lancé est alors de 
  $ #content_fraction_sur(PROBAS.at(0),6) × #content_fraction_sur(PROBAS.at(2),6) = #content_fraction_sur(PROBAS.at(0)*PROBAS.at(2),36) $
+ Les issues donnant au moins un 2 sont $(1;2)$, $(2;1)$, $(2;2)$, $(2;3)$ et $(3;2)$. La probabilité d'obtenir au moins un 2 est donc de
  $ 
  #content_fraction_sur(PROBAS.at(0),6) × #content_fraction_sur(PROBAS.at(1),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(0),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(1),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(2),6) +
  #content_fraction_sur(PROBAS.at(2),6) × #content_fraction_sur(PROBAS.at(1),6)
  = #{content_fraction_sur(
    PROBAS.at(0)*PROBAS.at(1) +
    PROBAS.at(1)*PROBAS.at(0) +
    PROBAS.at(1)*PROBAS.at(1) +
    PROBAS.at(1)*PROBAS.at(2) +
    PROBAS.at(2)*PROBAS.at(1),
  36)} $
+ #block(breakable: false, table(columns: 6, inset: 0.7em,
  [$a_i$], [2], [3], [4], [5], [6],
  [$P(X = a_i)$], {exo2_proba_de_x(PROBAS,2)}, {exo2_proba_de_x(PROBAS,3)}, {exo2_proba_de_x(PROBAS,4)}, {exo2_proba_de_x(PROBAS,5)}, {exo2_proba_de_x(PROBAS,6)}
  ))
+ L'espérance de $X$ est alors 
  $ 2 × #exo2_proba_de_x(PROBAS,2) + 3 × #exo2_proba_de_x(PROBAS,3) + 4 × #exo2_proba_de_x(PROBAS,4) + 5 × #exo2_proba_de_x(PROBAS,5) + 6 × #exo2_proba_de_x(PROBAS,6) = #{exo2_esperance_x(PROBAS)} $
]

#exercice(points: 8)[
+ On croise 4 clous, avec deux possibilités (droite ou gauche) à chaque fois. Il y a donc au total $2 × 2 × 2 × 2 = 16$ chemins possibles.

  #table(columns: 6,
    [case], [-2], [-1], [0], [1], [2],
    [nombre de chemins], [1], [4], [6], [4], [1]
  )
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-2] est de $1/16$.
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] est de $4/16 = 1/4$.
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] est de $6/16 = 3/8$.
+ La fonction `case` peut renvoyer $-2$, $-1$, $0$, $1$ ou $2$.
+ 
  ```python
  def gain():
      c = case()
      if c == -2 or c == -1:
          return -20
      if c == 0:
          return 0
      if c == 1:
          return 15
      if c == 2:
          return 25
  ```
+ #align(center, table(
    columns: (auto, ..range(4).map(x => 1.7cm)), align: center, stroke: 0.5pt, rows: 2em,
    [$a_i$], [$-20$], [$0$], [$15$], [$25$],
    [$P(G = a_i)$], {correction[$5/16$]}, {correction[$6/16$]}, {correction[$4/16$]}, {correction[$1/16$]},
  ))
+ L'espérance de $G$ est
  $ -20 × 5/16 + 0 × 6/16 + 15 × 4/16 + 25 × 1/16 = -15/16 $ 
]

// ==============================================
// ================= SUJET B ====================
// ==============================================

#pagebreak(weak: true)
#titre(date: [30 mai 2023])[Évaluation probabilités (sujet B)]

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
+ Le lancé de la pièce est une épreuve de Bernoulli. On peut dire que le succès est "Face", tandis que l'échec est "Pile".
+ La probabilité d'obtenir 3 piles est de $1/8$.
+ #pad(x: 1cm, canvas({
  import "../../git submodules/typst-canvas/draw.typ": *
  let START = (0,0)
    for (p,y) in (("Face",3),("Pile",-3)) {
      line(START, (3,y))
      content((3.5,y), p)
      for (p,y2) in (("Face",y+1.5),("Pile",y - 1.5)) {
        line((4,y),(6,y2))
        content((6.5,y2), p)
        for (p,y3) in (("Face",y2+1),("Pile",y2 - 1)) {
          line((7,y2),(9,y3))
          content((9.5,y3), p)
        }
      }
    }
  }))
  Il y a 3 branches donnant exactement une "Face".

  La probabilité d'obtenir exactement une face sur les trois lancés est alors de $3/8$
]

#exercice(points: 6)[
#{PROBAS = (1/6,1/3,1/2)}
+ #pad(x: 1cm, canvas({
  import "../../git submodules/typst-canvas/draw.typ": *
  let START = (0,0)
  let DICT = ((proba: content_fraction_sur(PROBAS.at(0),6),vert: 1), (proba: content_fraction_sur(PROBAS.at(1),6),vert: 0), (proba: content_fraction_sur(PROBAS.at(2),6),vert: -1))
  let DE1-1 = (3,3)
  let DE1-2 = (3,0)
  let DE1-3 = (3,-3)
  for x in (1,2,3) {
    let point = (3,3*DICT.at(x - 1).vert)
    let proba = DICT.at(x - 1).proba
    line(START, point)
    content(point, " " + repr(x), anchor: "left")
    content((point.first()/2,point.last()/2+0.5), proba)
    for x in (1,2,3) {
      let point2 = (6.7,point.last() + DICT.at(x - 1).vert)
      let proba = DICT.at(x - 1).proba
      line((point.first() + 0.7, point.last()), point2)
      content(point2, " " + repr(x), anchor: "left")
      content(if x == 3 { (point2.first()-1.2,point2.last()) } else { (point2.first()-0.8,point2.last()+0.35) }, proba)
    }
  }
  }))
+ La probabilité d'obtenir un 1 au premier lancé et un 3 au deuxième lancé est alors de 
  $ #content_fraction_sur(PROBAS.at(0),6) × #content_fraction_sur(PROBAS.at(2),6) = #content_fraction_sur(PROBAS.at(0)*PROBAS.at(2),36) $
+ Les issues donnant au moins un 2 sont $(1;2)$, $(2;1)$, $(2;2)$, $(2;3)$ et $(3;2)$. La probabilité d'obtenir au moins un 2 est donc de
  $ 
  #content_fraction_sur(PROBAS.at(0),6) × #content_fraction_sur(PROBAS.at(1),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(0),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(1),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(2),6) +
  #content_fraction_sur(PROBAS.at(2),6) × #content_fraction_sur(PROBAS.at(1),6)
  = #{content_fraction_sur(
    PROBAS.at(0)*PROBAS.at(1) +
    PROBAS.at(1)*PROBAS.at(0) +
    PROBAS.at(1)*PROBAS.at(1) +
    PROBAS.at(1)*PROBAS.at(2) +
    PROBAS.at(2)*PROBAS.at(1),
  36)} $
+ #block(breakable: false, table(columns: 6, inset: 0.7em,
  [$a_i$], [2], [3], [4], [5], [6],
  [$P(X = a_i)$], {exo2_proba_de_x(PROBAS,2)}, {exo2_proba_de_x(PROBAS,3)}, {exo2_proba_de_x(PROBAS,4)}, {exo2_proba_de_x(PROBAS,5)}, {exo2_proba_de_x(PROBAS,6)}
  ))
+ L'espérance de $X$ est alors 
  $ 2 × #exo2_proba_de_x(PROBAS,2) + 3 × #exo2_proba_de_x(PROBAS,3) + 4 × #exo2_proba_de_x(PROBAS,4) + 5 × #exo2_proba_de_x(PROBAS,5) + 6 × #exo2_proba_de_x(PROBAS,6) = #{exo2_esperance_x(PROBAS)} $
]

#exercice(points: 8)[
+ On croise 4 clous, avec deux possibilités (droite ou gauche) à chaque fois. Il y a donc au total $2 × 2 × 2 × 2 = 16$ chemins possibles.

  #table(columns: 6,
    [case], [-2], [-1], [0], [1], [2],
    [nombre de chemins], [1], [4], [6], [4], [1]
  )
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-2] est de $1/16$.
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] est de $4/16 = 1/4$.
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] est de $6/16 = 3/8$.
+ La fonction `case` peut renvoyer $-2$, $-1$, $0$, $1$ ou $2$.
+ 
  ```python
  def gain():
      c = case()
      if c == -2 or c == -1:
          return -10
      if c == 0:
          return 0
      if c == 1:
          return 5
      if c == 2:
          return 15
  ```
+ #align(center, table(
    columns: (auto, ..range(4).map(x => 1.7cm)), align: center, stroke: 0.5pt, rows: 2em,
    [$a_i$], [$-10$], [$0$], [$5$], [$15$],
    [$P(G = a_i)$], {correction[$5/16$]}, {correction[$6/16$]}, {correction[$4/16$]}, {correction[$1/16$]},
  ))
+ L'espérance de $G$ est :
  $ -10 × 5/16 + 0 × 6/16 + 5 × 4/16 + 15 × 1/16 = -15/16 $
]


// ==============================================
// ================= SUJET C ====================
// ==============================================

#pagebreak(weak: true)
#titre(date: [2 juin 2023])[Évaluation probabilités (sujet C)]

#exercice(points: [2,5])[
On considère une expérience aléatoire qui consiste à lancer trois pièces équilibrées.

Compléter les phrases suivantes avec les mots : "une issue", "issues", "un évènement", "l'évènement", "la probabilité"
+ Cette expérience comporte 8 #correction_dots[issues]. (pile ; face ; pile) est #correction_dots[une issue].
+ "On a obtenu exactement une face" est #correction_dots[un évènement].
+ $P(X >= 2)$ est #correction_dots[la probabilité] de #correction_dots[l'évènement] $X$.
]

#exercice(points: [3,5])[
+ Le lancé de la pièce est une épreuve de Bernoulli. On peut dire que le succès est "Face", tandis que l'échec est "Pile".
+ La probabilité d'obtenir 3 piles est de $1/8$.
+ #pad(x: 1cm, canvas({
  import "../../git submodules/typst-canvas/draw.typ": *
  let START = (0,0)
    for (p,y) in (("Face",3),("Pile",-3)) {
      line(START, (3,y))
      content((3.5,y), p)
      for (p,y2) in (("Face",y+1.5),("Pile",y - 1.5)) {
        line((4,y),(6,y2))
        content((6.5,y2), p)
        for (p,y3) in (("Face",y2+1),("Pile",y2 - 1)) {
          line((7,y2),(9,y3))
          content((9.5,y3), p)
        }
      }
    }
  }))
  Il y a 3 branches donnant exactement une "Face".

  La probabilité d'obtenir exactement une face sur les trois lancés est alors de $3/8$
]

#exercice(points: 6)[
#{PROBAS = (1/2,1/6,1/3)}
+ #pad(x: 1cm, canvas({
  import "../../git submodules/typst-canvas/draw.typ": *
  let START = (0,0)
  let DICT = ((proba: content_fraction_sur(PROBAS.at(0),6),vert: 1), (proba: content_fraction_sur(PROBAS.at(1),6),vert: 0), (proba: content_fraction_sur(PROBAS.at(2),6),vert: -1))
  let DE1-1 = (3,3)
  let DE1-2 = (3,0)
  let DE1-3 = (3,-3)
  for x in (1,2,3) {
    let point = (3,3*DICT.at(x - 1).vert)
    let proba = DICT.at(x - 1).proba
    line(START, point)
    content(point, " " + repr(x), anchor: "left")
    content((point.first()/2,point.last()/2+0.5), proba)
    for x in (1,2,3) {
      let point2 = (6.7,point.last() + DICT.at(x - 1).vert)
      let proba = DICT.at(x - 1).proba
      line((point.first() + 0.7, point.last()), point2)
      content(point2, " " + repr(x), anchor: "left")
      content(if x == 3 { (point2.first()-1.2,point2.last()) } else { (point2.first()-0.8,point2.last()+0.35) }, proba)
    }
  }
  }))
+ La probabilité d'obtenir un 1 au premier lancé et un 3 au deuxième lancé est alors de 
  $ #content_fraction_sur(PROBAS.at(0),6) × #content_fraction_sur(PROBAS.at(2),6) = #content_fraction_sur(PROBAS.at(0)*PROBAS.at(2),36) $
+ Les issues donnant au moins un 2 sont $(1;2)$, $(2;1)$, $(2;2)$, $(2;3)$ et $(3;2)$. La probabilité d'obtenir au moins un 2 est donc de
  $ 
  #content_fraction_sur(PROBAS.at(0),6) × #content_fraction_sur(PROBAS.at(1),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(0),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(1),6) +
  #content_fraction_sur(PROBAS.at(1),6) × #content_fraction_sur(PROBAS.at(2),6) +
  #content_fraction_sur(PROBAS.at(2),6) × #content_fraction_sur(PROBAS.at(1),6)
  = #{content_fraction_sur(
    PROBAS.at(0)*PROBAS.at(1) +
    PROBAS.at(1)*PROBAS.at(0) +
    PROBAS.at(1)*PROBAS.at(1) +
    PROBAS.at(1)*PROBAS.at(2) +
    PROBAS.at(2)*PROBAS.at(1),
  36)} $
+ #block(breakable: false, table(columns: 6, inset: 0.7em,
  [$a_i$], [2], [3], [4], [5], [6],
  [$P(X = a_i)$], {exo2_proba_de_x(PROBAS,2)}, {exo2_proba_de_x(PROBAS,3)}, {exo2_proba_de_x(PROBAS,4)}, {exo2_proba_de_x(PROBAS,5)}, {exo2_proba_de_x(PROBAS,6)}
  ))
+ L'espérance de $X$ est alors 
  $ 2 × #exo2_proba_de_x(PROBAS,2) + 3 × #exo2_proba_de_x(PROBAS,3) + 4 × #exo2_proba_de_x(PROBAS,4) + 5 × #exo2_proba_de_x(PROBAS,5) + 6 × #exo2_proba_de_x(PROBAS,6) = #{exo2_esperance_x(PROBAS)} $
]

#exercice(points: 8)[
+ On croise 4 clous, avec deux possibilités (droite ou gauche) à chaque fois. Il y a donc au total $2 × 2 × 2 × 2 = 16$ chemins possibles.

  #table(columns: 6,
    [case], [-2], [-1], [0], [1], [2],
    [nombre de chemins], [1], [4], [6], [4], [1]
  )
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-2] est de $1/16$.
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] est de $4/16 = 1/4$.
+ La probabilité que la bille tombe dans la case #box(inset: 1mm, stroke: 0.5pt + black)[-1] est de $6/16 = 3/8$.
+ La fonction `case` peut renvoyer $-2$, $-1$, $0$, $1$ ou $2$.
+ 
  ```python
  def gain():
      c = case()
      if c == -2 or c == -1:
          return -30
      if c == 0:
          return 0
      if c == 1:
          return 15
      if c == 2:
          return 40
  ```
+ #align(center, table(
    columns: (auto, ..range(4).map(x => 1.7cm)), align: center, stroke: 0.5pt, rows: 2em,
    [$a_i$], [$-30$], [$0$], [$15$], [$40$],
    [$P(G = a_i)$], {correction[$5/16$]}, {correction[$6/16$]}, {correction[$4/16$]}, {correction[$1/16$]},
  ))
+ L'espérance de $G$ est :
  $ -30 × 5/16 + 0 × 6/16 + 15 × 4/16 + 40 × 1/16 = -50/16 $
]
