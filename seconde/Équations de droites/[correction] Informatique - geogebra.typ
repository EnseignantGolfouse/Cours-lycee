#import "./Informatique - geogebra.typ": main
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

#main(correction: true)