#show raw.where(lang: "example"): it => {  
  let gutter = 3%
  let col_size = (100% - gutter) / 2
  line(start: (0%, 0%), end: (100%, 0%), stroke: 0.5pt + gray)
  text(size: 1.3em)[Example :]
  table(
    columns: (col_size, col_size),
    fill: (gray.lighten(75%), none, none),
    column-gutter: gutter,
    stroke: none,
    align: (auto, horizon),
    { text(size: 1.25em, raw(block: it.block, lang: "typst", it.text)) },
    { eval("[" + it.text + "]") }, 
  )
  line(start: (0%, 0%), end: (100%, 0%), stroke: 0.5pt + gray)
}

```example
#let x = 2
#x #linebreak()
#lorem(10)
```

```example
= Fibonacci sequence
The Fibonacci sequence is defined through the
recurrence relation $F_n = F_(n-1) + F_(n-2)$.
It can also be expressed in _closed form:_

$ F_n = round(1 / sqrt(5) phi.alt^n), quad
  phi.alt = (1 + sqrt(5)) / 2 $

#let count = 8
#let nums = range(1, count + 1)
#let fib(n) = (
  if n <= 2 { 1 }
  else { fib(n - 1) + fib(n - 2) }
)

The first #count numbers of the sequence are:

#align(center, table(
  columns: count,
  ..nums.map(n => $F_#n$),
  ..nums.map(n => str(fib(n))),
))
```
