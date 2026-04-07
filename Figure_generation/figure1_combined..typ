#import "@preview/cetz:0.3.4"

// ════════════════════════════════
//  PAGE SETUP & SHARED PALETTE
// ════════════════════════════════
#set page(width: 22.6cm, height: auto, margin: (x: 0.2cm, y: 0.2cm), fill: white)
#set text(font: "Times New Roman")

// Colour palettes — shared across all panels
#let blue-spec = rgb("#c8e2fc")
#let blue-mid  = rgb("#4a90d0")
#let blue-drk  = rgb("#1a4878")
#let blue-rim  = rgb("#14365a")

#let red-spec  = rgb("#f4b8b0")
#let red-mid   = rgb("#c45050")
#let red-drk   = rgb("#7a2020")
#let red-rim   = rgb("#5a1515")

#let faded-spec = rgb("#f0d0cc")
#let faded-mid  = rgb("#c08080")
#let faded-drk  = rgb("#8a4848")
#let faded-rim  = rgb("#6a3535")

#let green-spec = rgb("#b8eab8")
#let green-mid  = rgb("#48a848")
#let green-drk  = rgb("#1a6a1a")
#let green-rim  = rgb("#104a10")

#let shadow-c = rgb("#00000028")

#let line-color    = rgb("#1860a8")
#let arrow-gray    = rgb("#707070")
#let orange-bg     = rgb("#fdf3e0")
#let orange-border = rgb("#d4a040")
#let teal-bg       = rgb("#e2f2f2")
#let teal-border   = rgb("#6cc0c0")
#let vdd-color     = rgb("#c8a030")
#let yellow-arrow  = rgb("#d4a017")

// ════════════════════════════════
//  PANEL (c) HELPER FUNCTIONS
// ════════════════════════════════
#let ball(pos, kind, label, label-color: white, size: 0.38, sub: none, sup: none) = {
  import cetz.draw: *

  // Choose palette
  let (spec, mid, dark, rim) = if kind == "blue" {
    (blue-spec, blue-mid, blue-drk, blue-rim)
  } else if kind == "red" {
    (red-spec, red-mid, red-drk, red-rim)
  } else {
    (faded-spec, faded-mid, faded-drk, faded-rim)
  }

  // Drop shadow
  circle((rel: (0.04, -0.05), to: pos), radius: size + 0.02,
    fill: shadow-c, stroke: none)

  // Radial-gradient sphere with offset specular highlight
  circle(pos, radius: size,
    fill: gradient.radial(
      (spec, 0%), (mid, 50%), (dark, 100%),
      center: (30%, 25%), radius: 72%),
    stroke: 1pt + rim)

  // Label
  if sub != none {
    content(pos, text(fill: label-color, weight: "bold", size: 8pt)[#label#text(size: 6pt, baseline: 2pt)[#sub]])
  } else if sup != none {
    content(pos, text(fill: label-color, weight: "bold", size: 8pt)[#label])
    content((rel: (size * 0.72 - 0.2, size * 0.62 - 0.9), to: pos), text(fill: red, weight: "bold", size: 8pt)[state 0])
  } else {
    content(pos, text(fill: label-color, weight: "bold", size: 8pt)[#label])
  }
}

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

// ════════════════════════════════
//  SUBFIGURE STYLE
// ════════════════════════════════
#show figure.where(kind: "subfigure"): set figure(numbering: none)
#show figure.where(kind: "subfigure"): set figure.caption(position: bottom)

#figure(
  grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 1em,

    // ── Panel (a): 3D Rydberg lattice ──
    figure(
      kind: "subfigure",
      caption: [],
      cetz.canvas(length: 0.8175cm, {
    import cetz.draw: *

    // ══════════════════════════════════════════
    //  TITLE
    // ══════════════════════════════════════════
    content((-0.8, 6.3), text(weight: "bold", size: 15pt)[Lattice structure])
    content((-4.0, 6.3), anchor: "west",
      text(weight: "bold", size: 15pt)[(a)])

    // ══════════════════════════════════════════
    //  ISOMETRIC PROJECTION
    // ══════════════════════════════════════════
    let e1x =  1.35
    let e1y =  0.50
    let e2x = -1.00
    let e2y =  0.68

    let ox = 1.2
    let oy = -0.5
    let nv = 5

    let vr = 0.24
    let fr = 0.20

    // ══════════════════════════════════════════
    //  GRID LINES
    // ══════════════════════════════════════════
    for i in range(nv) {
      for j in range(nv - 1) {
        let x1 = ox + j * e1x + i * e2x
        let y1 = oy + j * e1y + i * e2y
        let x2 = ox + (j + 1) * e1x + i * e2x
        let y2 = oy + (j + 1) * e1y + i * e2y
        line((x1, y1), (x2, y2), stroke: 1.6pt + line-color)
      }
    }
    for j in range(nv) {
      for i in range(nv - 1) {
        let x1 = ox + j * e1x + i * e2x
        let y1 = oy + j * e1y + i * e2y
        let x2 = ox + j * e1x + (i + 1) * e2x
        let y2 = oy + j * e1y + (i + 1) * e2y
        line((x1, y1), (x2, y2), stroke: 1.6pt + line-color)
      }
    }

    // ══════════════════════════════════════════
    //  FACE-CENTRE ATOMS  (back → front)
    // ══════════════════════════════════════════
    for depth in range(2 * (nv - 2) + 1, -1, step: -1) {
      for i in range(nv - 1) {
        let j = depth - i
        if j >= 0 and j < nv - 1 {
          let fx = ox + (j + 0.5) * e1x + (i + 0.5) * e2x
          let fy = oy + (j + 0.5) * e1y + (i + 0.5) * e2y
          let is-red = calc.rem(i + j, 2) == 0
          circle((fx + 0.03, fy - 0.04), radius: fr + 0.01,
            fill: shadow-c, stroke: none)
          if is-red {
            circle((fx, fy), radius: fr,
              fill: gradient.radial(
                (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
                center: (28%, 22%), radius: 72%),
              stroke: 1pt + red-rim)
          } else {
            circle((fx, fy), radius: fr,
              fill: gradient.radial(
                (green-spec, 0%), (green-mid, 50%), (green-drk, 100%),
                center: (28%, 22%), radius: 72%),
              stroke: 1pt + green-rim)
          }
        }
      }
    }

    // ══════════════════════════════════════════
    //  VERTEX ATOMS  (back → front)
    // ══════════════════════════════════════════
    for depth in range(2 * (nv - 1) + 1, -1, step: -1) {
      for i in range(nv) {
        let j = depth - i
        if j >= 0 and j < nv {
          let vx = ox + j * e1x + i * e2x
          let vy = oy + j * e1y + i * e2y
          circle((vx + 0.03, vy - 0.04), radius: vr + 0.01,
            fill: shadow-c, stroke: none)
          circle((vx, vy), radius: vr,
            fill: gradient.radial(
              (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
              center: (28%, 22%), radius: 72%),
            stroke: 1pt + blue-rim)
        }
      }
    }

    // ══════════════════════════════════════════
    //  SINUSOIDAL LASER BEAMS
    // ══════════════════════════════════════════
    let make-wave(sx, sy, ex, ey, amp, freq, n) = {
      let dx = ex - sx
      let dy = ey - sy
      let len = calc.sqrt(dx * dx + dy * dy)
      let ux = dx / len
      let uy = dy / len
      let nx = -uy
      let ny = ux
      range(n + 1).map(k => {
        let t = k / n
        let s = amp * calc.sin(2 * calc.pi * freq * t)
        (sx + t * dx + s * nx, sy + t * dy + s * ny)
      })
    }

    // ── Red beam  (ancilla A₁) — upper-left ──
    let r-ex = ox + 1.1 * e1x + 3.2 * e2x
    let r-ey = oy - 0.5 * e1y + 3.2 * e2y + 0.85
    let r-sx = r-ex - 1.2
    let r-sy = r-ey + 3.5

    let r-pts = make-wave(r-sx +2, r-sy - 1.2 , r-ex -0.6, r-ey -0.11, 0.32, 3.0, 80)
    line(..r-pts, stroke: 6pt + rgb("#ff000020"))
    line(..r-pts, stroke: 2.4pt + rgb("#dd2222"))
    {
      let adx = r-ex - r-sx+6
      let ady = r-ey - r-sy 
      let al = calc.sqrt(adx * adx + ady * ady)
      line((r-ex - adx / al * 0.4 -0.32, r-ey - ady / al * 0.4 - 0.2), (r-ex -0.2, r-ey -0.6 ),
        stroke: 2.4pt + rgb("#dd2222"),
        mark: (end: ">", fill: rgb("#dd2222"), size: 0.28))
    }
    content((r-sx + 1.2, r-sy - 2.0), anchor: "south-east",
      angle: 0deg,
      text(fill: rgb("#dd0000"), weight: "bold", size: 10pt)[
        Global pulse for \ ancilla qubit $A_1$
      ])

    // ── Blue beam  (data qubits) — upper-right ──
    // Target: blue vertex atom at grid (j=3, i=2)
    let b-target-x = ox + 3 * e1x + 2 * e2x
    let b-target-y = oy + 3 * e1y + 2 * e2y
    let b-sx = b-target-x + 2.0
    let b-sy = b-target-y + 3.0   // stays below (a) label at y=7.4
    let b-ex = b-target-x + 0.4
    let b-ey = b-target-y + 0.6

    let b-pts = make-wave(b-sx, b-sy, b-ex, b-ey, 0.30, 4.0, 80)
    line(..b-pts, stroke: 6pt + rgb("#0088ff18"))
    line(..b-pts, stroke: 2.4pt + rgb("#1888dd"))
    {
      line((b-ex, b-ey), (b-target-x, b-target-y),
        stroke: 2.4pt + rgb("#1888dd"),
        mark: (end: ">", fill: rgb("#1888dd"), size: 0.28))
    }
    content((b-sx -3, b-sy - 0.7), anchor: "south-west",
      angle: -0deg,
      text(fill: rgb("#00a0e0"), weight: "bold", size: 10pt)[
        Global pulse for \ data qubits
      ])

    // ── Green beam  (ancilla A₂) — lower-right ──
    // Target: green face-centre atom at grid (i=0, j=3), i+j=3 odd → green
    let g-target-x = ox + 3.5 * e1x + 0.5 * e2x
    let g-target-y = oy + 3.5 * e1y + 0.5 * e2y
    let g-sx = g-target-x + 2.0
    let g-sy = g-target-y + 4.0
    let g-ex = g-target-x + 0.4
    let g-ey = g-target-y + 0.6

    let g-pts = make-wave(g-sx, g-sy, g-ex, g-ey, 0.28, 4.0, 80)
    line(..g-pts, stroke: 6pt + rgb("#00aa0018"))
    line(..g-pts, stroke: 2.4pt + rgb("#11aa11"))
    {
      line((g-ex, g-ey), (g-target-x, g-target-y),
        stroke: 2.4pt + rgb("#11aa11"),
        mark: (end: ">", fill: rgb("#11aa11"), size: 0.28))
    }
    content((g-sx - 0.9, g-sy - 3.4), anchor: "south-west",
      angle: 0deg,
      text(fill: rgb("#00aa00"), weight: "bold", size: 9pt)[
        Global pulse for \ ancilla qubit $A_2$
      ])

  }),
    ),

    // ── Panel (b): Gate building blocks ──
    figure(
      kind: "subfigure",
      caption: [],
      cetz.canvas(length: 0.599cm, {
    import cetz.draw: *

    // ══════════════════════════════════════════
    //  LAYOUT
    // ══════════════════════════════════════════
    let pw   = 8.8
    let ph   = 9.0
    let gap  = 0.5
    let lx0  = 0.4
    let rx0  = lx0 + pw + gap
    let py0  = 0.5
    let py1  = py0 + ph 

    let lcx  = lx0 + pw / 2.0
    let rcx  = rx0 + pw / 2.0

    // Atom row
    let atom-y  = py1 - 2.6
    let atom-sp = 1.8
    let atom-r  = 0.40

    // V_dd curves
    let curve-h = 0.75

    // Energy levels
    let lev-w      = 0.6
    let lev-bot    = py0 + 2.6
    let lev-sp     = 1.5
    let lev-stroke = 1.6pt

    // Derived level y-positions
    let cs-0y = lev-bot
    let cs-1y = lev-bot + lev-sp -0.8
    let cs-ry = lev-bot + 2 * lev-sp

    // ══════════════════════════════════════════
    //  TITLE
    // ══════════════════════════════════════════
    content((0.3, 10.5), anchor: "west",
      text(weight: "bold", size: 15pt)[(b)])
    content((1.6, 10.5), anchor: "west",
      text(weight: "bold", size: 15pt)[Gate Building Blocks.])

    // ══════════════════════════════════════════
    //  LEFT PANEL  –  OR Gate
    // ══════════════════════════════════════════
    rect((lx0, py0), (lx0 + pw, py1),
      radius: 0.3, stroke: 2.5pt + orange-border, fill: orange-bg)

    content((lcx, py1 - 0.50), anchor: "center",
      text(weight: "bold", size: 10pt)[OR Gate])

    // ── V_dd curves ──
    // left arc
    bezier(
      (lcx - atom-sp + 0.35, atom-y + atom-r + 0.06),
      (lcx - 0.35,           atom-y + atom-r + 0.06),
      (lcx - atom-sp / 2,    atom-y + atom-r + curve-h),
      stroke: 2pt + vdd-color)
    content((lcx - atom-sp / 2, atom-y + atom-r + curve-h + 0.28), anchor: "center",
      text(size: 9pt)[$V_"dd"$])
    // right arc
    bezier(
      (lcx + 0.35,           atom-y + atom-r + 0.06),
      (lcx + atom-sp - 0.35, atom-y + atom-r + 0.06),
      (lcx + atom-sp / 2,    atom-y + atom-r + curve-h),
      stroke: 2pt + vdd-color)
    content((lcx + atom-sp / 2, atom-y + atom-r + curve-h + 0.28), anchor: "center",
      text(size: 9pt)[$V_"dd"$])

    // ── Atoms  red – blue – red ──
    for (dx, is-blue) in ((-atom-sp, false), (0, true), (atom-sp, false)) {
      let px = lcx + dx
      circle((px + 0.04, atom-y - 0.05), radius: atom-r + 0.02,
        fill: shadow-c, stroke: none)
      if is-blue {
        circle((px, atom-y), radius: atom-r,
          fill: gradient.radial(
            (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
            center: (30%, 25%), radius: 72%),
          stroke: 1.3pt + blue-rim)
      } else {
        circle((px, atom-y), radius: atom-r,
          fill: gradient.radial(
            (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
            center: (30%, 25%), radius: 72%),
          stroke: 1.3pt + red-rim)
      }
    }

    // ────────────────────────────────────────
    //  OR · Cs energy levels  (left of panel)
    // ────────────────────────────────────────
    let cs-x = lx0 + 1.9

    line((cs-x - lev-w, cs-0y), (cs-x + lev-w, cs-0y), stroke: lev-stroke + black)
    line((cs-x - lev-w, cs-1y), (cs-x + lev-w, cs-1y), stroke: lev-stroke + black)
    line((cs-x - lev-w, cs-ry), (cs-x + lev-w, cs-ry), stroke: lev-stroke + black)

    content((cs-x - lev-w - 0.15, cs-0y), anchor: "east",
      text(size: 9pt)[$|0 angle.r$])
    content((cs-x - lev-w - 0.15, cs-1y), anchor: "east",
      text(size: 9pt)[$|1 angle.r$])
    content((cs-x - lev-w - 0.15, cs-ry), anchor: "east",
      text(size: 9pt)[$|r angle.r$])

    // Ω_c :  |1⟩ ↔ |r⟩
    line((cs-x, cs-1y + 0.12), (cs-x, cs-ry - 0.12),
      stroke: 1.3pt + red-mid,
      mark: (start: "straight", end: "straight", fill: none, stroke: red-mid, size: 0.18))
    content((cs-x +0.2, (cs-1y + cs-ry) / 2), anchor: "west",
      text(fill: red-mid, size: 8pt)[$Omega_c$])

    content((cs-x, cs-0y - 0.95), anchor: "center",
      text(weight: "bold", size: 10pt)[Control])

    // ────────────────────────────────────────
    //  OR · Rb energy levels  (right of panel)
    // ────────────────────────────────────────
    let rb-cx = lx0 + pw - 2.2
    let rb-Ax = rb-cx - 1.05
    let rb-Bx = rb-cx + 1.05
    let rb-Ay = lev-bot
    let rb-By = lev-bot + 0.35
    let rb-Py = lev-bot + lev-sp
    let rb-Ry = lev-bot + 2 * lev-sp

    // |A⟩
    line((rb-Ax - 0.5, rb-Ay), (rb-Ax + 0.5, rb-Ay), stroke: lev-stroke + black)
    content((rb-Ax, rb-Ay - 0.35), anchor: "center",
      text(size: 9pt)[$|A angle.r$])
    // |B⟩
    line((rb-Bx - 0.5, rb-By), (rb-Bx + 0.5, rb-By), stroke: lev-stroke + black)
    content((rb-Bx, rb-By - 0.35), anchor: "center",
      text(size: 9pt)[$|B angle.r$])
    // |P⟩
    line((rb-cx - 0.5, rb-Py), (rb-cx + 0.5, rb-Py), stroke: lev-stroke + black)
    content((rb-cx + 0.65, rb-Py), anchor: "west",
      text(size: 9pt)[$|P angle.r$])
    // |R⟩
    line((rb-cx - 0.5, rb-Ry), (rb-cx + 0.5, rb-Ry), stroke: lev-stroke + black)
    content((rb-cx + 0.65, rb-Ry), anchor: "west",
      text(size: 9pt)[$|R angle.r$])

    // "EIT"
    content((rb-cx - 1.3, rb-Py + 0.15), anchor: "east",
      text(weight: "bold", size: 8pt)[EIT])

    // Ω_p : |A⟩ ↔ |P⟩
    line((rb-Ax + 0.15, rb-Ay + 0.12), (rb-cx - 0.15, rb-Py - 0.12),
      stroke: 1.3pt + blue-mid,
      mark: (start: "straight", end: "straight", fill: none, stroke: blue-mid, size: 0.18))
    content((rb-Ax +0.3 , (rb-Ay + rb-Py) / 2 + 0.15), anchor: "east",
      text(fill: blue-mid, size: 8pt)[$Omega_p$])

    // Ω_p : |B⟩ ↔ |P⟩
    line((rb-Bx - 0.15, rb-By + 0.12), (rb-cx + 0.15, rb-Py - 0.12),
      stroke: 1.3pt + blue-mid,
      mark: (start: "straight", end: "straight", fill: none, stroke: blue-mid, size: 0.18))
    content((rb-Bx - 0.2, (rb-Ay + rb-Py) / 2 + 0.15), anchor: "west",
      text(fill: blue-mid, size: 8pt)[$Omega_p$])

    // Ω_R : |P⟩ ↔ |R⟩
    line((rb-cx, rb-Py + 0.12), (rb-cx, rb-Ry - 0.12),
      stroke: 1.3pt + yellow-arrow,
      mark: (start: "straight", end: "straight", fill: none, stroke: yellow-arrow, size: 0.18))
    content((rb-cx - 0.25, (rb-Py + rb-Ry) / 2), anchor: "east",
      text(fill: yellow-arrow, size: 8pt)[$Omega_R$])

    content((rb-cx, rb-Ay - 0.95), anchor: "center",
      text(weight: "bold", size: 10pt)[Target])

    // ── Bottom text ──
    content((lcx, py0 + 0.55), anchor: "center",
      text(size: 9pt)[Target flips if any Control = $|1 angle.r$])

    // ══════════════════════════════════════════
    //  RIGHT PANEL  –  CCX Gate
    // ══════════════════════════════════════════
    rect((rx0, py0), (rx0 + pw, py1),
      radius: 0.3, stroke: 2.5pt + teal-border, fill: teal-bg)

    content((rcx, py1 - 0.50), anchor: "center",
      text(weight: "bold", size: 10pt)[CCX Gate])

    // ── V_dd curves ──
    bezier(
      (rcx - atom-sp + 0.35, atom-y + atom-r + 0.06),
      (rcx - 0.35,           atom-y + atom-r + 0.06),
      (rcx - atom-sp / 2,    atom-y + atom-r + curve-h),
      stroke: 2pt + vdd-color)
    content((rcx - atom-sp / 2, atom-y + atom-r + curve-h + 0.28), anchor: "center",
      text(size: 9pt)[$V_"dd"$])
    bezier(
      (rcx + 0.35,           atom-y + atom-r + 0.06),
      (rcx + atom-sp - 0.35, atom-y + atom-r + 0.06),
      (rcx + atom-sp / 2,    atom-y + atom-r + curve-h),
      stroke: 2pt + vdd-color)
    content((rcx + atom-sp / 2, atom-y + atom-r + curve-h + 0.28), anchor: "center",
      text(size: 9pt)[$V_"dd"$])

    // ── Atoms ──
    for (dx, is-blue) in ((-atom-sp, false), (0, true), (atom-sp, false)) {
      let px = rcx + dx
      circle((px + 0.04, atom-y - 0.05), radius: atom-r + 0.02,
        fill: shadow-c, stroke: none)
      if is-blue {
        circle((px, atom-y), radius: atom-r,
          fill: gradient.radial(
            (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
            center: (30%, 25%), radius: 72%),
          stroke: 1.3pt + blue-rim)
      } else {
        circle((px, atom-y), radius: atom-r,
          fill: gradient.radial(
            (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
            center: (30%, 25%), radius: 72%),
          stroke: 1.3pt + red-rim)
      }
    }

    // "Blockade"
    content((rcx, atom-y - 0.65), anchor: "center",
      text(size: 9pt)[Blockade])

    // ────────────────────────────────────────
    //  CCX · Cs energy levels
    // ────────────────────────────────────────
    let cs2-x = rx0 + 1.9

    line((cs2-x - lev-w, cs-0y), (cs2-x + lev-w, cs-0y), stroke: lev-stroke + black)
    line((cs2-x - lev-w, cs-1y), (cs2-x + lev-w, cs-1y), stroke: lev-stroke + black)
    line((cs2-x - lev-w, cs-ry), (cs2-x + lev-w, cs-ry), stroke: lev-stroke + black)

    content((cs2-x - lev-w - 0.15, cs-0y), anchor: "east",
      text(size: 9pt)[$|0 angle.r$])
    content((cs2-x - lev-w - 0.15, cs-1y), anchor: "east",
      text(size: 9pt)[$|1 angle.r$])
    content((cs2-x - lev-w - 0.15, cs-ry), anchor: "east",
      text(size: 9pt)[$|r angle.r$])

    // Ω_cc :  |0⟩ ↔ |r⟩  (long arrow)
    line((cs2-x, cs-0y + 0.12), (cs2-x, cs-ry - 0.12),
      stroke: 1.3pt + red-mid,
      mark: (start: "straight", end: "straight", fill: none, stroke: red-mid, size: 0.18))
    content((cs2-x + 0.1, (cs-0y + cs-ry) / 2), anchor: "west",
      text(fill: red-mid, size: 8pt)[$Omega_"cc"$])

    content((cs2-x, cs-0y - 0.95), anchor: "center",
      text(weight: "bold", size: 10pt)[Control])

    // ────────────────────────────────────────
    //  CCX · Rb energy levels  (V-shape, no |P⟩)
    // ────────────────────────────────────────
    let rb2-cx = rx0 + pw - 2.2
    let rb2-Ax = rb2-cx - 1.05
    let rb2-Bx = rb2-cx + 1.05

    let rb-Ay = lev-bot
    let rb-By = lev-bot + 0.35
    let rb-Ry = lev-bot + 2 * lev-sp

    // |A⟩
    line((rb2-Ax - 0.5, rb-Ay), (rb2-Ax + 0.5, rb-Ay), stroke: lev-stroke + black)
    content((rb2-Ax, rb-Ay - 0.35), anchor: "center",
      text(size: 9pt)[$|A angle.r$])
    // |B⟩
    line((rb2-Bx - 0.5, rb-By), (rb2-Bx + 0.5, rb-By), stroke: lev-stroke + black)
    content((rb2-Bx, rb-By - 0.35), anchor: "center",
      text(size: 9pt)[$|B angle.r$])
    // |R⟩
    line((rb2-cx - 0.5, rb-Ry), (rb2-cx + 0.5, rb-Ry), stroke: lev-stroke + black)
    content((rb2-cx + 0.65, rb-Ry), anchor: "west",
      text(size: 9pt)[$|R angle.r$])

    // Ω_R : |A⟩ ↔ |R⟩
    line((rb2-Ax + 0.15, rb-Ay + 0.12), (rb2-cx - 0.15, rb-Ry - 0.12),
      stroke: 1.3pt + blue-mid,
      mark: (start: "straight", end: "straight", fill: none, stroke: blue-mid, size: 0.18))
    content((rb2-Ax + 0.4, (rb-Ay + rb-Ry) / 2 + 0.2), anchor: "east",
      text(fill: blue-mid, size: 8pt)[$Omega_"t1"$])

    // Ω_R : |B⟩ ↔ |R⟩
    line((rb2-Bx - 0.15, rb-By + 0.12), (rb2-cx + 0.15, rb-Ry - 0.12),
      stroke: 1.3pt + blue-mid,
      mark: (start: "straight", end: "straight", fill: none, stroke: blue-mid, size: 0.18))
    content((rb2-Bx - 0.3, (rb-Ay + rb-Ry) / 2 + 0.2), anchor: "west",
      text(fill: blue-mid, size: 8pt)[$Omega_"t2"$])

    content((rb2-cx, rb-Ay - 0.95), anchor: "center",
      text(weight: "bold", size: 10pt)[Target])

    // ── Bottom text ──
    content((rcx, py0 + 0.55), anchor: "center",
      text(size: 9pt)[Target flips only if both Controls = $|1 angle.r$])
  }),
    ),

    // ── Panel (c): QEC Cycle  (spans both columns) ──
    grid.cell(colspan: 2,
    figure(
      kind: "subfigure",
      caption: [],
      cetz.canvas(length: 0.90cm, {
    import cetz.draw: *

    let arr = (mark: (end: ">", fill: black, size: 0.18))

    // === Title ===
    content((-7.0, 0.1), text(weight: "bold", size: 15pt)[QEC Cycle])
    content((-9.8, 0.1), text(weight: "bold", size: 15pt)[(c)])

    // === Dashed curved arrows forming the cycle ===
    let cycle-stroke = (paint: arrow-gray, thickness: 2.5pt, dash: (5pt, 4pt))

    // Error -> Syndrome: right from Error, then down to Syndrome top
    line((3.75, -1.8), (11.0, -1.8), stroke: cycle-stroke)
    line((11.0, -1.8), (11.0, -2.5),
      stroke: cycle-stroke,
      mark: (end: ">", fill: arrow-gray, size: 0.22))

    // Syndrome -> Correction: down from Syndrome, then left to Correction right
    line((11.0, -6.1), (11.0, -7.1), stroke: cycle-stroke)
    line((11.0, -7.1), (4.1, -7.1),
      stroke: cycle-stroke,
      mark: (end: ">", fill: arrow-gray, size: 0.22))

    // Correction -> Ancilla Reset: left from Correction, then up to Ancilla Reset bottom
    line((-0.1, -7.1), (-7.0, -7.1), stroke: cycle-stroke)
    line((-7.0, -7.1), (-7.0, -5.7),
      stroke: cycle-stroke,
      mark: (end: ">", fill: arrow-gray, size: 0.22))

    // Ancilla Reset -> Error: up from Ancilla Reset, then right to Error left
    line((-7.0, -2.9), (-7.0, -1.8), stroke: cycle-stroke)
    line((-7.0, -1.8), (0.25, -1.8),
      stroke: cycle-stroke,
      mark: (end: ">", fill: arrow-gray, size: 0.22))

    // ============================================================
    // BOX 1: Error (top center)
    // ============================================================
    let error-pos = (2, -1.8)
    rect(
      (rel: (-1.75, 1.00), to: error-pos),
      (rel: (1.75, -1.00), to: error-pos),
      fill: white, stroke: black + 0.8pt, radius: 4pt,
    )
    content((rel: (0, 0.7), to: error-pos), text(weight: "bold", size: 11pt)[Error])
    ball((rel: (0, -0.2), to: error-pos), "blue", "", size: 0.38)
    content((rel: (0, -0.1), to: error-pos), text(fill: red-drk, size: 18pt, weight: "bold")[⚡])

    // ============================================================
    // BOX 2: Syndrome Extraction (right)
    // ============================================================
    let se-pos = (11.0, -4.3)
    rect(
      (rel: (-2.69, 1.8), to: se-pos),
      (rel: (2.69, -1.8), to: se-pos),
      fill: white, stroke: black + 0.8pt, radius: 4pt,
    )
    content((rel: (0, 1.36), to: se-pos), text(weight: "bold", size: 11pt)[Syndrome Extraction])

    let ac-x = 11.0
    let ac-y = -4.6
    let dsp-x = 1.9
    let dsp-y = 1.0
    let dtl = (ac-x - dsp-x, ac-y + dsp-y)
    let dtr = (ac-x + dsp-x, ac-y + dsp-y)
    let dbl = (ac-x - dsp-x, ac-y - dsp-y)
    let dbr = (ac-x + dsp-x, ac-y - dsp-y)

    let a-r = 0.40
    let d-r = 0.34

    set-style(stroke: (paint: black, thickness: 1.3pt, dash: none))
    line(shorten-start(dtl.at(0), dtl.at(1), ac-x, ac-y, d-r), shorten-end(dtl.at(0), dtl.at(1), ac-x, ac-y, a-r), ..arr)
    line(shorten-start(dtr.at(0), dtr.at(1), ac-x, ac-y, d-r), shorten-end(dtr.at(0), dtr.at(1), ac-x, ac-y, a-r), ..arr)
    line(shorten-start(dbl.at(0), dbl.at(1), ac-x, ac-y, d-r), shorten-end(dbl.at(0), dbl.at(1), ac-x, ac-y, a-r), ..arr)
    line(shorten-start(dbr.at(0), dbr.at(1), ac-x, ac-y, d-r), shorten-end(dbr.at(0), dbr.at(1), ac-x, ac-y, a-r), ..arr)

    ball((ac-x, ac-y), "faded", "A", sup: "1", size: 0.38)
    ball(dtl, "blue", "D", size: 0.32)
    ball(dtr, "blue", "D", size: 0.32)
    ball(dbl, "blue", "D", size: 0.32)
    ball(dbr, "blue", "D", size: 0.32)

    // ============================================================
    // BOX 3: Correction (bottom)
    // ============================================================
    let corr-pos = (2, -7.1)
    rect(
      (rel: (-2.1, 1.15), to: corr-pos),
      (rel: (2.1, -1.15), to: corr-pos),
      fill: white, stroke: black + 0.8pt, radius: 4pt,
    )
    content((rel: (0, 0.78), to: corr-pos), text(weight: "bold", size: 11pt)[Correction])

    let a1x = 0.44
    let a1y = -7.4
    let dcx = 2.0
    let dcy = -7.4
    let a2x = 3.56
    let a2y = -7.4

    let a-corr-r = 0.32
    let d-corr-r = 0.38

    set-style(stroke: (paint: black, thickness: 1.3pt, dash: none))
    line(shorten-start(a1x, a1y, dcx, dcy, a-corr-r), shorten-end(a1x, a1y, dcx, dcy, d-corr-r), ..arr)
    line(shorten-start(a2x, a2y, dcx, dcy, a-corr-r), shorten-end(a2x, a2y, dcx, dcy, d-corr-r), ..arr)

    ball((a1x, a1y), "faded", "A", label-color: white, size: 0.36, sub: "1")
    ball((a2x, a2y), "faded", "A", label-color: white, size: 0.36, sub: "2")
    ball((dcx, dcy), "blue", "D", size: 0.36)

    // ============================================================
    // BOX 4: Ancilla Reset (left)
    // ============================================================
    let ar-pos = (-7.0, -4.3)
    rect(
      (rel: (-1.99, 1.4), to: ar-pos),
      (rel: (1.99, -1.4), to: ar-pos),
      fill: white, stroke: black + 0.8pt, radius: 4pt,
    )
    content((rel: (0, 0.8), to: ar-pos), text(weight: "bold", size: 11pt)[Ancilla Reset])

    let faded-pos = (-8.3, -4.5)
    let bright-pos = (-5.7, -4.5)

    set-style(stroke: (paint: black, thickness: 1.3pt, dash: none))
    line(
      (faded-pos.at(0) + 0.38, faded-pos.at(1)),
      (bright-pos.at(0) - 0.38, bright-pos.at(1)),
      mark: (end: ">", fill: black, size: 0.18),
    )

    ball(faded-pos, "faded", "", size: 0.36)
    ball(bright-pos, "red", "", sup: "0", size: 0.36)

    // ============================================================
    // Bottom text
    // ============================================================
    content((2, -9.1), text(weight: "bold", size: 11pt)[No measurement, No movement, No local addressing])
  }),
    ),
    ),


  ),
  // caption: [Overview of the self-correcting Rydberg quantum error correction protocol.],
) <fig:combined>