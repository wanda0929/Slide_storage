// Core figure for easy-ssh: Local AI, Remote Execution
// Standalone — compile with: typst compile figure_core.typ
#set page(width: 34em, height: auto, margin: 1.5em)
#set text(font: "Linux Libertine", size: 10pt)

// === Colors ===
#let laptop-color = rgb("#1f77b4")   // blue
#let server-color = rgb("#e76f51")   // warm red
#let flow-color   = rgb("#2a9d8f")   // teal
#let bg-gray      = rgb("#f7f7f7")

// === Helpers ===
#let node(title, icon, items, color) = rect(
  width: 10em,
  fill: color.lighten(88%),
  stroke: 1.6pt + color,
  radius: 8pt,
  inset: (x: 0.8em, y: 0.6em),
)[
  #set align(left)
  #text(weight: "bold", size: 1.0em, fill: color)[#icon #h(0.25em) #title]
  #v(0.3em)
  #set text(size: 0.85em)
  #for item in items [
    #text(fill: color, weight: "bold")[+] #item \
  ]
]

#let arrow-head-r(color) = {
  let s = 5pt
  box(baseline: 50% - 0.5pt, polygon(fill: color, (0pt, 0pt), (s * 1.2, s), (0pt, s * 2)))
}
#let arrow-head-l(color) = {
  let s = 5pt
  box(baseline: 50% - 0.5pt, polygon(fill: color, (s * 1.2, 0pt), (0pt, s), (s * 1.2, s * 2)))
}

// === Title ===
#{
  set align(center)
  text(size: 1.15em, weight: "bold")[easy-ssh: Local AI, Remote Execution]
  v(0.8em)
}

// === Architecture row ===
#{
  set align(center)

  let arrow-block = {
    set align(center)
    set text(size: 0.78em)
    stack(
      dir: ttb,
      spacing: 0.15em,
      rect(fill: flow-color.lighten(88%), stroke: 0.8pt + flow-color, radius: 4pt, inset: (x: 0.5em, y: 0.25em))[
        #text(weight: "bold", fill: flow-color, size: 0.95em)[SSH + rsync]
      ],
      v(0.25em),
      // right arrow: push code + run
      {
        set align(center)
        text(size: 0.75em, fill: flow-color)[push code, run cmd]
      },
      {
        box(width: 5.5em, {
          set align(horizon)
          box(width: 1fr, line(length: 100%, stroke: 1.4pt + flow-color))
          arrow-head-r(flow-color)
        })
      },
      v(0.15em),
      // left arrow: pull results
      {
        box(width: 5.5em, {
          set align(horizon)
          arrow-head-l(flow-color)
          box(width: 1fr, line(length: 100%, stroke: 1.4pt + flow-color))
        })
      },
      {
        set align(center)
        text(size: 0.75em, fill: flow-color)[pull results]
      },
    )
  }

  grid(
    columns: (auto, 7em, auto),
    align: horizon,
    node("Your Laptop", emoji.laptop, ("Claude Code / Codex", "Edit code locally", "No server setup"), laptop-color),
    arrow-block,
    node("Remote Server", emoji.computer, ("GPU / large RAM", "Run heavy compute", "Data stays put"), server-color),
  )
}

#v(0.8em)

// === Workflow pipeline ===
#{
  set align(center)

  let step(cmd, desc, color) = rect(
    fill: color.lighten(90%),
    stroke: 1.2pt + color,
    radius: 5pt,
    inset: (x: 0.55em, y: 0.3em),
  )[
    #text(weight: "bold", fill: color, size: 0.8em)[#raw(cmd)] \
    #text(size: 0.7em)[#desc]
  ]

  let sep = text(fill: flow-color, weight: "bold", size: 0.9em)[#sym.arrow.r]

  // Pipeline
  stack(
    dir: ltr,
    spacing: 0.3em,
    step("init", [configure once], laptop-color),
    sep,
    step("push", [sync files], flow-color),
    sep,
    step("run", [execute remotely], server-color),
    sep,
    step("pull", [fetch results], flow-color),
  )
}

#v(0.6em)

// === Key properties ===
#{
  set align(center)
  rect(
    width: 90%,
    fill: bg-gray,
    stroke: 0.8pt + luma(180),
    radius: 6pt,
    inset: (x: 1em, y: 0.5em),
  )[
    #set text(size: 0.82em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: center,
      [#text(fill: laptop-color, weight: "bold")[Zero install] \ on the server],
      [#text(fill: flow-color, weight: "bold")[Single script] \ pure Bash + rsync],
      [#text(fill: server-color, weight: "bold")[LLM-native] \ works with any agent],
    )
  ]
}
