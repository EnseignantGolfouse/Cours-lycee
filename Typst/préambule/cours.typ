#import "préambule.typ": setup_commun

#let cours(titre: "", classe: [], titre_en_haut: [], body) = {
  set page(
    margin: (
      top: 2cm,
      bottom: 1cm,
      left: 1.5cm,
      right: 1.5cm,
    ),
    numbering: "1",
    number-align: center,
    header: {
      place(left)[Lycée La Martinière Diderot]
      place(center)[#if classe == [] [
        Mathématiques
      ] else [
        #classe - Mathématiques
      ]]
      place(right)[#if titre_en_haut == [] [
        Cours
      ] else [
        #titre_en_haut
      ]]

      line(start: (0pt, 1.2em), length: 100%, stroke: 0.5pt)
    }
  )

  setup_commun(titre: titre, authors: (), {
    // Title row.
    align(center)[
      #v(4em)
      #block(text(1.75em, titre))
      #v(4em)
    ]

    // Main body.
    set par(justify: false)

    body
  })
}

#let make_theorem(title: "", style: (), body) = {
  let shift_left = if "shift_left" in style {
    style.shift_left
  } else {
    0pt
  }
  let result = {
    let stroke = style.stroke
    let stroke_inner = style.stroke
    if type(stroke_inner) == "dictionary" {
      if "bottom" in stroke_inner {
        stroke_inner.bottom = style.color
      }
    } else if type(stroke_inner) == "color" {
      stroke_inner = (
        bottom: style.color,
        rest: stroke,
      )
    }
    block(
      width: 100% - shift_left,
      radius: if style.curved { 12% } else { 0% },
      stroke: stroke,
      breakable: false,
      {
        block(
          breakable: false,
          spacing: 0pt,
          stroke: stroke_inner,
          width: 100%,
          radius: (top: if style.curved { 56% } else { 0% }),
          height: 2em,
          inset: (left: 1em, top: 0.6em, right: 1em),
          fill: rgb("#dddddd")
        )[
          #text(fill: style.color, weight: "bold")[#style.title #if title != "" [ : #title]]
        ]
        box(width: 100%, inset: (left: 1em, right: 1em, bottom: 1em), body)
      },
    )
  }
  pad(left: shift_left, result)
}

#let definition(title: "", body) = {
  make_theorem(
    title: title,
    style: (
      color: green,
      title: [Définition],
      curved: true,
      stroke: gray,
      shift_left: 1em,
    ),
    body
  )
}

#let remarque(title: "", body) = {
  make_theorem(
    title: title,
    style: (
      color: rgb(0, 0, 100),
      title: [Remarque],
      curved: false,
      stroke: (left: gray.darken(50%)),
      shift_left: 1em,
    ),
    body
  )
}

#let exemple(title: "", body) = {
  make_theorem(
    title: title,
    style: (
      color: rgb(0, 0, 100),
      title: [Exemple],
      curved: false,
      stroke: (left: gray.darken(50%)),
      shift_left: 1em,
    ),
    body
  )
}

#let propriete(title: "", body) = {
  make_theorem(
    title: title,
    style: (
      color: red,
      title: [Propriété],
      curved: true,
      stroke: gray,
    ),
    body
  )
}

#let proof(body) = [
  _Démontration_. #body
]