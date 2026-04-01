#let conf(
  title: none,
  authors: (),
  abstract: [],
  doc,
) = {
  set align(center)
  text(17pt, title)

  let count = authors.len()
  let ncols = calc.min(count, 3)
  // grid(
  //   columns: (1fr,) * ncols,
  //   row-gutter: 24pt,
  //   ..authors.map(author => [
  //     #author.name \
  //     #link("mailto:" + author.email)
  //   ]),
  // )

  set align(left)
  doc
}

#let mine = counter("mycounter")
#let part(title, content) = [
  #mine.step()
  #context mine.display(). #emph(title)

  //#par(content, hanging-indent: 1em, first-line-indent: 1em)
  #grid(columns: 2, h(1em), par(content))
  #v(2em)
]