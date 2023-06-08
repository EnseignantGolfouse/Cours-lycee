#import "préambule.typ": setup_commun

#let en_correction = state("en_correction", false)
#let exercice_counter = counter("exercice")
#let exercices_total_points = state("exercices_total_points", 0)

#let évaluation(titre: "", classe: [], titre_en_haut: [], landscape: false, correction: false, body) = {
  let header = {
    let base_header = text(size: 9pt, {
      place(left)[Lycée La Martinière Diderot]
      place(center)[#if classe == [] [
        Mathématiques
      ] else [
        #classe - Mathématiques
      ]]
      place(right)[#if titre_en_haut == [] [
        Évaluation
      ] else [
        #titre_en_haut
      ]]

      line(start: (0pt, 1.2em), length: 100%, stroke: 0.5pt)
    })
    if landscape {
      let length = 50% - 5mm
      stack(dir: ltr, spacing: 1cm,
        box(width: length, base_header),
        box(width: length, base_header),
      )
    } else {
      base_header
    }
  }

  setup_commun(titre: titre, authors: (), header: header, landscape: landscape, {
    en_correction.update(correction)

    body
  })
}

#let reset_sujet() = {
  exercice_counter.update(0)
  exercices_total_points.update(0)
}

#let exercice(points: none, body) = {
  exercice_counter.step()
  let titre = strong(underline[Exercice #exercice_counter.display()])
  if points != none {
    titre += [ (#points points)] 
    exercices_total_points.update(x => x + points)
  }
  titre += [ : ]
  pad(bottom: 0.6em, titre + body)
}

// hides content by default
#let correction(alternative: none, color: red, body) = {
  locate(loc => {
    if en_correction.at(loc) {
      if color == none {
        body
      } else {
        text(fill: color, body)
      }
    } else {
      if alternative == none {
        hide(body)
      } else {
        alternative
      }
    }
  })
}

#let correction_dots(color: red, body) = {
  locate(loc => {
    if en_correction.at(loc) {
      if color == none {
        body
      } else {
        text(fill: color, body)
      }
    } else {
      style(styles => {
        let size = measure(body, styles)
        box(width: size.width, height: size.height)[#repeat[.]]
      })
    }
  })
}

#let titre(date: none, body) = {
  reset_sujet()
  place(left)[Nom, Prénom : #correction_dots(text(fill: red, [CORRECTION]))]
  if date != none {
    place(right, date)
  }
  linebreak()
  align(center)[
    #v(1em)
    #block(text(1.75em, body))
    #v(2em)
  ]
}