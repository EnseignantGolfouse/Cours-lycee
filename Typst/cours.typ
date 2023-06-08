#import "préambule/cours.typ": *

#show: cours.with(
  titre: "Chapitre 4 : Statistiques descriptives",
  classe: [$2^(d e)$]
)

= Proportions et pourcentages

#definition(title: [Population])[
- Une *population* est un ensemble d’éléments, appelés les *individus*.
- Une *sous-population* est une partie de la population.
- Le nombre total d’individus dans la population est appelé l'*effectif total*.
]

#remarque()[
  Les individus d’une population ne sont pas toujours des personnes. \ 
  Par exemple, on peut parler de la _population_ d’une trousse, dont les _individus_ sont les stylos, et une _sous-population_ est formée par les stylos rouges.
]

#definition(title: [Proportion])[
  On considère une population dont l’effectif total est $N$, et une sous-population dont l’effectif est $n$.

  - La *proportion* d’individus dans la sous-population est $p = n/N$.
  - On peut exprimer cette proportion en pourcentage, en la multipliant par 100 :#linebreak()$( n/N × 100)%$ des individus sont dans la sous-population.
]

#exemple()[
  #let column_length = 1cm
  #align(center)[#grid(
    columns: (column_length, column_length, column_length, column_length, column_length),
    rows: (1cm, auto),
    text(fill: red)[×], text(fill: red)[×], [∙], [∙], [∙],
    text(fill: red)[×], text(fill: red)[×], [∙], [∙], [∙],
  )]
  Dans la population ci-dessus, la proportion de croix est $4/10 = 0,4$ ou $40%$
]

#remarque()[
  Prendre $x%$ d’une valeur revient à la multiplier par $x/100$.
]

#propriete(title: [Proportion de proportion, pourcentage de pourcentage])[
  #let cyan = cmyk(100%, 0%, 0%, 0%)
  #align(center)[
    #stack(dir: ltr, ellipse(stroke: cyan, fill: cyan.lighten(80%))[
      #stack(dir: ltr, ellipse(stroke: red, fill: red.lighten(80%))[
        #stack(dir: ltr, ellipse(stroke: green, fill: green.lighten(80%))
        , text(fill: green)[C])
      ], text(fill: red)[B])
    ], text(fill: cyan)[A])
  ]

  On considère une population $A$, et
  - Une sous-population $B$ de $A$, dont la proportion dans $A$ est $p_B$.
  - Une sous-population $C$ de $B$, dont la proportion dans $B$ est $p_C$.

  Alors la proportion de $C$ dans $A$ est $p = p_B × p_C$
]

#exemple()[
  On considère la population des véhicules possédés par une entreprise.

	- $75\%$ de ces véhicules sont électriques.
	- Parmi les véhicules électriques, $30\%$ sont des deux-roues.

	La proportion $p$ de deux-roues électriques dans la population totale est donc
	$ p = 0,75 × 0,3 = 0,225 $
	Soit $22,5\%$.
]

= Variations et évolutions

#definition(title: [Variations])[
  Lorsqu'on passe d'une valeur $V_1$ à une valeur $V_2$, on dit qu'il s'agit d'une *évolution*. On a alors :
  - $V_2 - V_1$ est la *variation absolue*.
  - $(V_2 - V_1)/(V_1)$ est la *variation relative*, aussi appelée le *taux d'évolution*.
]

#exemple()[
  Une personne ayant 1 000 000 € gagne 1 000 000.
  - la variation absolue est de 1 000 000 €.
  - la variation relative est de $(#text([1 000 000]))/
(#text([100 000 000])) = 0,01$, ou $1%$.
]

#remarque()[
  - Si la variation absolue (ou le taux d’évolution) est positive, c’est que la valeur à augmenté. Sinon, c’est qu’elle a diminué.
  - La variation absolue est dans la même unité que $V_1$ et $V_2$.
  - Le taux d’évolution n’a pas d’unité.
]

#propriete()[
  Si $t$ est le taux d’évolution entre deux valeurs $A$ et $B$, on a
  $ B = A × (1 + t) $
]
#proof()[
  On sait que $t$ est le taux d’évolution, donc $t = (B − A)/A$.
  
  Donc $A × t = B − A$, et donc $B = A × t + A = A × (1 + t)$.
]

#remarque()[
  Si $t$ est _supérieur_ à 0, c'est une augmentation. Sinon, c'est une diminution.
]

#propriete(title: [Évolutions successives et coefficient global])[
  Lorsqu'on applique plusieurs évolutions successives, on obtient le *coefficient global* en multipliant les coefficients.
]

#exemple()[
  Si on applique une augmentation de 20%, suivie d’une diminution de 20%, l’évolution a pour coefficient global

  $ (1 + 20/100) × (1 - 20/100) = 1,2 × 0,8 = 0,96 $

  On a donc globalement une diminution.
]

#exemple()[
  Si on passe de $150$€ à $240$€, on doit multiplier par $1,6$.

  Donc pour passer de $240$€ à $150$€, on doit multiplier par $1/(1,6) = 0,625$.
]

= Séries statistiques

#definition(title: [Moyenne, moyenne pondérée])[
  Si on dispose d'une série de valeurs $x_1, ..., x_n$,
  - on peut calculer leur *moyenne* : $ M = (x_1 + ... + x_n)/n $
  - La moyenne peut être *pondérée*, c'est à dire que chaque valeur est multipliée par un coefficient $c_i$ : $ M = (c_1 × x_1 + ... + c_n × x_n)/(c_1 + ... + c_n) $
]

#exemple()[
  La moyenne de la série de notes $8;11;12;17$ est
  $ M = (8 + 11 + 12 + 17)/4 = 48/4 = 12 $
  Si la quatrième note (le $17$) a pour coefficient $2$, et que toutes les autres notes ont pour coefficient $1$, la moyenne devient 
  $ M = (8 + 11 + 12 + 2 × 17)/(1 + 1 + 1 + 2) = 65/5 = 13 $
]

#propriete(title: [Linéarité de la moyenne])[
  - Si on ajoute le même nombre $a$ à chaque valeur, la moyenne augmente de $a$.
  - Si on multiplie chaque valeur par un nombre $b$, la moyenne est multipliée par $b$.
]

#definition(title: [Variance, écart-type])[
  Si on dispose d’une série de valeurs $x_1, ..., x_n$, et qu’on dispose de la moyenne $M$, on définit
  - La *variance* de cette série
  $ V = ((x_1 - M)^2 + ... + (x_n - M)^2)/n $
  - L’*écart-type* de cette série
  $ σ = sqrt(V) $
]

#exemple()[
  Prenons la série de notes $1;4;9;15;18;13$.\ 
  La moyenne de cette série est $10$. Donc on a
  - $
  V & = ((1 - 10)^2 + (4 - 10)^2 + (9 - 10)^2 + (15 - 10)^2 + (18 - 10)^2 + (13 - 10)^2)/6 \
    & = ((-9)^2 + (-6)^2 + (-1)^2 + 5^2 + 8^2 + 3^2)/6 \
    & = (81 + 36 + 1 + 25 + 64 + 9)/6 \
    & = 216/6 = 36 \
  $
  - $σ = sqrt(V) = sqrt(36) = 6$
]

#definition(title: [Médiane, quartiles])[
  Si on a une série de valeurs $x_1, ..., x_n$ rangées dans l’ordre croissant, alors
  - La *médiane* est la valeur telle que $50$% des valeurs lui sont supérieures ou égales, et $50$% des valeurs lui sont inférieures ou égales.
  - Le *$1^(e r)$ quartile* $Q_1$ est la plus petite valeur de la série telle qu’au moins $25$% des valeurs lui sont inférieures ou égales.
  - Le *$3^e$ quartile* $Q_3$ est la plus petite valeur de la série telle qu’au moins $75$% des valeurs lui sont inférieures ou égales.
]

#definition(title: [Écart interquartile])[
  L'*écart interquartile* est la valeur $Q_3 - Q_1$.
]

#exemple()[
  Si on a la série $5 ; 12 ; 12 ; 14 ; 16 ; 21 ; 22 ; 23$, alors
  - La médiane est entre $14$ et $16$ : traditionnellement, on dira qu’elle vaut $15$.
  - Le premier quartile est $12$, le troisième quartile est $21$.
  - L’écart interquartile est $21 - 12 = 9$.
]