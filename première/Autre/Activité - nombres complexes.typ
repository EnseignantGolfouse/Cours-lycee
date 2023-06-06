#import "../../Typst/préambule/activité.typ": activité
#import "../../git submodules/typst-canvas/canvas.typ": canvas

#show: activité.with(classe: [$1^(e r e)$STI2D], titre: "Activité : pendule")
#let tcolorbox(width: auto, body) = box(width: width, fill: gray.lighten(50%), inset: 0.7em, radius: 5pt, stroke: black, body)

#tcolorbox(width:100%)[
On va étudier le mouvement d'un pendule, sans frottements.

#align(center)[
  #canvas({
    import "../../git submodules/typst-canvas/draw.typ": *
    line((-5,0), (5,0))
    for x in range(-10,11) {
      line((x/2,0),(x/2+0.5,0.5))
    }
    line((0,0),(2,-4))
    circle((2,-4), fill: gray, radius: 0.5cm)
  })
]
]

#tcolorbox[
On admet les formules suivantes :
#[
#show math.frac: it => text(size: 1.4em, it)
- $cos(a + b) = cos(a) × cos(b) - sin(a) × sin(b)$ #v(0.8em)
- $lim_(h→0) cos(h)/h = 0$ #v(1em)
- $lim_(h→0) sin(h)/h = 1$
]]



Si $f(x) = cos(x)$,

$ f'(x) & = lim_(h→0) (cos(x+h) - cos(x))/h #linebreak()

 & = lim_(h→0) (cos(x)cos(h) - sin(x)sin(h) - cos(x))/h
 $