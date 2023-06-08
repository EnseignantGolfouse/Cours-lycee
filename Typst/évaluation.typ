#import "préambule/évaluation.typ": *

#let main(en_correction: false) = [
#show: évaluation.with(
  titre: "Interrogation test",
  titre_en_haut: [Interrogation],
  classe: [$2^(d e)$],
  correction: en_correction,
  landscape: true
)

#titre(date: [6 avril 2023])[Interrogation sujet A]


#exercice(points: 4)[
  Un exercice avec les points

  Donner une réponse : #correction()[hello] !!!

  Réponse avec des points : #correction_dots()[world] !!!
]

#exercice()[
  Un exercice sans les points

  Une réponse ou autre : #correction(alternative: [Alternativement, voici ce qu'on écrit])[hola] !!!
]

#exercice(points: 10)[
  Un autre exercice
]

Total des points : #exercices_total_points.display()

#reset_sujet()
#colbreak()

#titre(date: [6 avril 2023])[Interrogation sujet B]

#exercice(points: 6)[
  Vérifions que les exercices et leurs points repartent à 1
]

Total des points : #exercices_total_points.display()

]

#main()