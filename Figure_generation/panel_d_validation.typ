// panel_d_validation.typ
// Panel (d): Validation Overview / Scaling
// Extracted from figure1_combined..typ
#import "@preview/cetz:0.3.4"

#set page(width: auto, height: auto, margin: (x: 0.2cm, y: 0.2cm), fill: white)
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

#let green-spec = rgb("#b8eab8")
#let green-mid  = rgb("#48a848")
#let green-drk  = rgb("#1a6a1a")
#let green-rim  = rgb("#104a10")

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
  cetz.canvas(length: 0.645cm, {
    import cetz.draw: *

    // ── Layout constants ──
    let lx   = 3.5
    let rx   = 13.0
    let cy   = 2.3
    let sp   = 1.3
    let ar   = 0.45
    let gs   = 1.2
    let n    = 5
    let half = (n - 1) * gs / 2.0

    // ── Shadow offset ──
    let sh-dx = 0.05
    let sh-dy = -0.06

    // ══════════════════════════════════════════
    //  TITLE
    // ══════════════════════════════════════════
    content((-1.0, 7.0), anchor: "west",
      text(weight: "bold", size: 15pt)[(d)])
    content((0.3, 7.0), anchor: "west",
      text(weight: "bold", size: 15pt)[Validation Overview])

    // ══════════════════════════════════════════
    //  LEFT PANEL  –  Pulse-level (Lindblad)
    // ══════════════════════════════════════════

    content((lx, 6.2), anchor: "center",
      text(weight: "bold", size: 10pt)[Pulse-level])
    content((lx, 5.6), anchor: "center",
      text(weight: "bold", size: 10pt)[\(Lindblad\)])

    // ── Rounded box with shadow ──
    let box-hw = 3.0
    let box-hh = 3.0
    rect((lx - box-hw - 0.02, cy - box-hh - 0.04), (lx + box-hw + 0.04, cy + box-hh - 0.04),
      radius: 0.42, stroke: none, fill: rgb("#00000020"))
    rect((lx - box-hw, cy - box-hh), (lx + box-hw, cy + box-hh),
      radius: 0.4, stroke: 2.5pt + rgb("#2a2a2a"), fill: white)
    rect((lx - box-hw + 0.25, cy - box-hh + 0.25), (lx + box-hw - 0.25, cy + box-hh - 0.25),
      radius: 0.28, stroke: 1pt + rgb("#999"), fill: rgb("#fdfdfd"))

    // ── LEFT PANEL: 5×5 checkerboard atom grid ──
    let grid-sp = 1.0
    let grid-ar = 0.34
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
              stroke: 1.2pt + blue-rim)
            content((px, py), text(fill: white, weight: "bold", size: 7pt)[D])
          } else {
            circle((px, py), radius: grid-ar,
              fill: gradient.radial(
                (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
                center: (30%, 25%), radius: 72%),
              stroke: 1.2pt + red-rim)
            content((px, py), text(fill: white, weight: "bold", size: 7pt)[A])
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

    // ══════════════════════════════════════════
    //  BLOCK ARROW  –  Scalability
    // ══════════════════════════════════════════
    line(
      (7.62, cy + 0.26), (9.32, cy + 0.26),
      (9.32, cy + 0.72), (10.62, cy - 0.04),
      (9.32, cy - 0.82), (9.32, cy - 0.34),
      (7.62, cy - 0.34),
      close: true,
      fill: rgb("#00000018"), stroke: none,
    )
    line(
      (7.6, cy + 0.30), (9.3, cy + 0.30),
      (9.3, cy + 0.78), (10.6, cy),
      (9.3, cy - 0.78), (9.3, cy - 0.30),
      (7.6, cy - 0.30),
      close: true,
      fill: gradient.linear(
        (rgb("#a0b4cc"), 0%), (rgb("#7a94b4"), 40%), (rgb("#566e8a"), 100%),
        angle: 90deg),
      stroke: 1pt + rgb("#3d5268"),
    )
    content((9.1, cy - 1.4), anchor: "center",
      text(weight: "bold", size: 10pt)[Scalability])

    // ══════════════════════════════════════════
    //  RIGHT PANEL  –  MPS Tensor Network
    // ══════════════════════════════════════════

    content((rx, 6.2), anchor: "center",
      text(weight: "bold", size: 10pt)[MPS])
    content((rx, 5.6), anchor: "center",
      text(weight: "bold", size: 10pt)[Tensor Network])
    content((rx, cy - half - 0.8), anchor: "center",
      text(weight: "bold", size: 10pt)[Macro])

    // ── Grid lines ──
    for i in range(n) {
      line(
        (rx - half, cy - half + i * gs),
        (rx + half, cy - half + i * gs),
        stroke: 0.9pt + rgb("#444"),
      )
      line(
        (rx - half + i * gs, cy - half),
        (rx - half + i * gs, cy + half),
        stroke: 0.9pt + rgb("#444"),
      )
    }

    // ── Face-centre atoms (alternating red / green) ──
    let fcr = 0.22
    let fc-border = 1.2pt

    for i in range(n - 1) {
      for j in range(n - 1) {
        let fx = rx - half + j * gs + gs / 2
        let fy = cy - half + i * gs + gs / 2

        circle((fx + sh-dx, fy + sh-dy), radius: fcr + 0.01,
          fill: shadow-c, stroke: none)

        if calc.rem(i + j, 2) == 0 {
          circle((fx, fy), radius: fcr,
            fill: gradient.radial(
              (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
              center: (30%, 25%), radius: 72%),
            stroke: fc-border + red-rim)
        } else {
          circle((fx, fy), radius: fcr,
            fill: gradient.radial(
              (green-spec, 0%), (green-mid, 50%), (green-drk, 100%),
              center: (30%, 25%), radius: 72%),
            stroke: fc-border + green-rim)
        }
      }
    }

    // ── Vertex atoms (blue) ──
    let vr = 0.19
    let v-border = 1.0pt

    for i in range(n) {
      for j in range(n) {
        let vx = rx - half + j * gs
        let vy = cy - half + i * gs

        circle((vx + sh-dx, vy + sh-dy), radius: vr + 0.01,
          fill: shadow-c, stroke: none)

        circle((vx, vy), radius: vr,
          fill: gradient.radial(
            (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
            center: (30%, 25%), radius: 72%),
          stroke: v-border + blue-rim)
      }
    }
  }),
)
