#set page(paper: "a3", margin: 1cm)

#{
  let max_x = 3
  let max_y = 5
  let size = 8cm
  for i in range(0, max_x+1) {
    place(dx: i*size, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, max_y*size)))
  }
  for j in range(0, max_y+1) {
    place(dx: 0pt, dy: j*size, line(start: (0pt, 0pt), end: (max_x*size, 0pt)))
  }
}