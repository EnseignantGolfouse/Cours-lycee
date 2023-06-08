#import "préambule.typ": setup_commun

#let activité(titre: "", classe: none, titre_en_haut: [], landscape: false, body) = {
  let header = {
    let base_header = text(size: 9pt, {
      place(left)[Lycée La Martinière Diderot]
      place(center)[#if classe == [] [
        Mathématiques
      ] else [
        #classe - Mathématiques
      ]]
      place(right)[#if titre_en_haut == [] [
        Exercices
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
    align(center, text(size: 20pt, underline(titre)))

    body
  })
}