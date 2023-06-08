#let setup_commun(titre: "", authors: (), landscape: false, header: none, body) = {
  set document(title: titre)
  set heading(numbering: "1  ")
  show heading: it => {
    it
    v(1em)
  }

  set text(ligatures: false, size: 10pt, font: "DejaVu Sans", lang: "fr")
  set par(justify: false)
  set underline(offset: 2pt)
  show math.equation: it => {
    set text(size: 12pt, style: "normal")
    show regex("[A-Z]"): x => $upright(#x)$
    show regex("[0-9]+"): set text(ligatures: false, size: 10pt, font: "DejaVu Sans", lang: "fr")
    it
  }
  set list(indent: 1em)
  set enum(indent: 1em)

  set page(paper: "a4", header: header, flipped: landscape)
  set page(columns: 2, margin: (rest: 1cm)) if landscape
  set page(columns: 1, margin: (top: 2cm, bottom: 1cm, left: 1.5cm, right: 1.5cm)) if not landscape

  body
}

#let two_columns(relative_width: 50%, spacing: 0pt, col1: [], col2: []) = {
  stack(dir: ltr, spacing: spacing, box(width: relative_width - spacing / 2)[#col1], box(width: 100% - relative_width - spacing / 2)[#col2])
}