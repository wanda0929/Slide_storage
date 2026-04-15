// panel_d_validation.typ
// Panel (a): Nine-atom unit cell for pulse-level verification
// Used in Appendix B.2 of main.tex, Fig. 7
#import "@preview/cetz:0.3.4"

#set page(width: auto, height: auto, margin: (x: 0.3cm, y: 0.3cm), fill: white)
#set text(font: "Times New Roman")

// ── Shared palette ──
#let blue-spec = rgb("#c8e2fc")
#let blue-mid  = rgb("#4a90d0")
#let blue-drk  = rgb("#1a4878")
#let blue-rim  = rgb("#14365a")

#let red-spec  = rgb("#f4b8b0")
#let red-mid   = rgb("#c45050")
#let red-drk   = rgb("#7a2020")
#let red-rim   = rgb("#5a1515")

#let shadow-c = rgb("#00000028")

// ── Helper functions ──
#let shorten-end(from-x, from-y, to-x, to-y, dist) = {
  let dx = to-x - from-x
  let dy = to-y - from-y
  let len = calc.sqrt(dx * dx + dy * dy)
  let nx = dx / len
  let ny = dy / len
  ((to-x - nx * dist, to-y - ny * dist))
}

#let shorten-start(from-x, from-y, to-x, to-y, dist) = {
  let dx = to-x - from-x
  let dy = to-y - from-y
  let len = calc.sqrt(dx * dx + dy * dy)
  let nx = dx / len
  let ny = dy / len
  ((from-x + nx * dist, from-y + ny * dist))
}

#figure(
  cetz.canvas(length: 1.7cm, {
    import cetz.draw: *

    // ── Layout constants ──
    let lx   = 3.5
    let cy   = 2.3

    // ── Shadow offset ──
    let sh-dx = 0.05
    let sh-dy = -0.06

    // ══════════════════════════════════════════
    //  TITLE
    // ══════════════════════════════════════════
    // content((-1.0, 7.0), anchor: "west",
    //   text(weight: "bold", size: 15pt)[(e)])
    // content((0.3, 7.0), anchor: "west",
    //   text(weight: "bold", size: 15pt)[Validation Overview])

    // ══════════════════════════════════════════
    //  LEFT PANEL  –  Pulse-level (Lindblad)
    // ══════════════════════════════════════════

    content((lx, 5.8), anchor: "center",
      text(weight: "bold", size: 18pt)[Nine-atom unit cell])

    // ── Atom grid ──
    let grid-sp = 1.1
    let grid-ar = 0.40
    for i in range(5) {
      for j in range(5) {
        let dx = (j - 2) * grid-sp
        let dy = (i - 2) * grid-sp
        let px = lx + dx
        let py = cy + dy
        let use-blue = (i == 1 or i == 3) and calc.rem(i + j, 2) == 0

        let skip = (
          (i == 0 and (j == 1 or j == 2 or j == 3)) or
          (i == 1 and (j == 0 or j == 2 or j == 4)) or
          (i == 2 and (j == 0 or j == 1 or j == 3 or j == 4)) or
          (i == 3 and (j == 0 or j == 2 or j == 4)) or
          (i == 4 and (j == 1 or j == 2 or j == 3))
        )

        if not skip {
          circle((px + sh-dx, py + sh-dy), radius: grid-ar + 0.02,
            fill: shadow-c, stroke: none)

          if use-blue {
            circle((px, py), radius: grid-ar,
              fill: gradient.radial(
                (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
                center: (30%, 25%), radius: 72%),
              stroke: 1.4pt + blue-rim)
            content((px, py), text(fill: white, weight: "bold", size: 10pt)[D])
          } else {
            circle((px, py), radius: grid-ar,
              fill: gradient.radial(
                (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
                center: (30%, 25%), radius: 72%),
              stroke: 1.4pt + red-rim)
            content((px, py), text(fill: white, weight: "bold", size: 10pt)[A])
          }
        }
      }
    }

    // ── Arrows: red → nearest blue ──
    let s = grid-sp
    let r = grid-ar
    line(shorten-start(lx - 2*s, cy - 2*s, lx - 1*s, cy - 1*s, r),
         shorten-end(lx - 2*s, cy - 2*s, lx - 1*s, cy - 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))
    line(shorten-start(lx + 2*s, cy - 2*s, lx + 1*s, cy - 1*s, r),
         shorten-end(lx + 2*s, cy - 2*s, lx + 1*s, cy - 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))
    line(shorten-start(lx - 2*s, cy + 2*s, lx - 1*s, cy + 1*s, r),
         shorten-end(lx - 2*s, cy + 2*s, lx - 1*s, cy + 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))
    line(shorten-start(lx + 2*s, cy + 2*s, lx + 1*s, cy + 1*s, r),
         shorten-end(lx + 2*s, cy + 2*s, lx + 1*s, cy + 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))
    line(shorten-start(lx, cy, lx - 1*s, cy - 1*s, r),
         shorten-end(lx, cy, lx - 1*s, cy - 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))
    line(shorten-start(lx, cy, lx + 1*s, cy - 1*s, r),
         shorten-end(lx, cy, lx + 1*s, cy - 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))
    line(shorten-start(lx, cy, lx - 1*s, cy + 1*s, r),
         shorten-end(lx, cy, lx - 1*s, cy + 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))
    line(shorten-start(lx, cy, lx + 1*s, cy + 1*s, r),
         shorten-end(lx, cy, lx + 1*s, cy + 1*s, r),
      stroke: 1.3pt + black, mark: (end: ">", fill: black, size: 0.18))


  }),
)
