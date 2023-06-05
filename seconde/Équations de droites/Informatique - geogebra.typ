#import "../../Typst/préambule/préambule.typ": setup_commun

#show: setup_commun.with(landscape: true, header: {
  let base_header = text(size: 9pt, {
    place(left)[Lycée La Martinière Diderot]
    place(center)[$2^(d e)$ - Mathématiques]
    place(right)[Exercices]
    line(start: (0pt, 1.2em), length: 100%, stroke: 0.5pt)
  })
  let length = 50% - 5mm
  stack(dir: ltr, spacing: 1cm,
    box(width: length, base_header),
    box(width: length, base_header),
  )
})

#let main(correction: false) = [
#set enum(numbering: "1.a)")
#let correction_dots(size: 2cm, body) = {
  if correction {
    text(fill: red, body)
  } else {
    style(styles => {
      let s = measure(body, styles)
      box(width: if size == auto { s.width } else { size }, height: s.height)[#repeat[.]]
    })
  }
}


#{
  show: align.with(center)
  show: text.with(size: 20pt)
  show: underline
  v(1em)
  [Activité : Geogebra]
}

+ Dans le panneau de saisie, entrer l'équation cartésienne $3x + 2y - 1 = 0$. Qu'observe-t'on ?
+ Créer la droite d'équation cartésienne $x - 3y + 2 = 0$, et placer un point à l'intersection des deux droites. Quelles sont ses coordonnées ? $(#correction_dots[-0,09] ; #correction_dots[0,64])$
+ Dans Geogebra, entrer une équation cartésienne donnant une droite qui :
  - a pour pente $4$ ;
  - passe par le point de coordonnées $(-1 ; -2)$.

  $ #correction_dots(size: 3cm)[4x - y - 2] = 0 $ #v(1em)
+ On va maintenant créer une droite dont on peut manipuler les paramètres $a$, $b$ et $c$.
  + Créer trois curseurs $a$, $b$ et $c$. Utiliser les paramètres par défaut.
  + Entrer l'équation cartésienne $a x + b y + c = 0$.
  + Changer la valeur des curseurs pour manipuler la droite. Quel semble être l'effet du paramètre $c$ ?
    
    #correction_dots(size: auto)[Il semble décaler la droite verticalement.]
+ Que se passe-t'il si $a = 0$ et $b = 0$ ? Quelles sont alors les solutions de l'équation cartésiennes ? 
  
  #correction_dots(size: auto)[Il n'y a pas de solutions (sauf si $c = 0$).]
+ Donner deux équations cartésiennes donnant une droite verticale en $x = 2$ :
  $ #correction_dots(size: 3cm)[x - 2] = 0 #h(1em) "et" #h(1em) #correction_dots(size: 3cm)[0,5x - 4] = 0 $
]

#main()
#colbreak(weak: true)
#main()