#import "@preview/cetz:0.3.4"

// ════════════════════════════════
//  PAGE SETUP & SHARED PALETTE
// ════════════════════════════════
#set page(width: auto, height: auto, margin: (x: 0.4cm, y: 0.4cm), fill: white)
#set text(font: "Times New Roman")

// Colour palettes — same as figure1_combined_4panel.typ
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
#let line-color = rgb("#1860a8")

// Decayed blue for PBC boundary copies
#let dblue-spec = rgb("#e8f0f8")
#let dblue-mid  = rgb("#a0c0dc")
#let dblue-drk  = rgb("#6090b0")
#let dblue-rim  = rgb("#5080a0")

// ════════════════════════════════
//  2D LATTICE (top-down view)
// ════════════════════════════════
#cetz.canvas(length: 1.0cm, {
  import cetz.draw: *

  // ── 2D orthogonal projection ──
  let e1x = 1.5    // rightward
  let e1y = 0.0
  let e2x = 0.0
  let e2y = 1.5    // upward

  let ox = 0.0
  let oy = 0.0
  let nv = 5

  let vr = 0.30    // vertex atom radius
  let fr = 0.24    // face-centre atom radius

  // ══════════════════════════════════════════
  //  GRID LINES
  // ══════════════════════════════════════════
  // e1-direction lines (horizontal)
  for i in range(nv) {
    for j in range(nv - 1) {
      let x1 = ox + j * e1x + i * e2x
      let y1 = oy + j * e1y + i * e2y
      let x2 = ox + (j + 1) * e1x + i * e2x
      let y2 = oy + (j + 1) * e1y + i * e2y
      line((x1, y1), (x2, y2), stroke: 1.6pt + line-color)
    }
  }
  // e2-direction lines (vertical)
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
  //  FACE-CENTRE ATOMS  (red / green alternating)
  // ══════════════════════════════════════════
  for i in range(nv - 1) {
    for j in range(nv - 1) {
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

  // ══════════════════════════════════════════
  //  PBC BOUNDARY FACE-CENTRE ATOMS (decayed, top & left edges)
  // ══════════════════════════════════════════
  // Decayed palettes
  let dred-spec  = rgb("#f8e0dc")
  let dred-mid   = rgb("#d09090")
  let dred-drk   = rgb("#a06060")
  let dred-rim   = rgb("#906050")
  let dgreen-spec = rgb("#dcf0dc")
  let dgreen-mid  = rgb("#90c890")
  let dgreen-drk  = rgb("#608860")
  let dgreen-rim  = rgb("#507850")

  // Top edge: face centres at i=nv-1, j=0..nv-2  (wrapping top↔bottom)
  for j in range(nv - 1) {
    let fx = ox + (j + 0.5) * e1x
    let fy = oy + (nv - 1 + 0.5) * e2y
    let is-red = calc.rem((nv - 1) + j, 2) == 0
    circle((fx + 0.03, fy - 0.04), radius: fr + 0.01,
      fill: shadow-c, stroke: none)
    if is-red {
      circle((fx, fy), radius: fr,
        fill: gradient.radial(
          (dred-spec, 0%), (dred-mid, 50%), (dred-drk, 100%),
          center: (28%, 22%), radius: 72%),
        stroke: 1pt + dred-rim)
    } else {
      circle((fx, fy), radius: fr,
        fill: gradient.radial(
          (dgreen-spec, 0%), (dgreen-mid, 50%), (dgreen-drk, 100%),
          center: (28%, 22%), radius: 72%),
        stroke: 1pt + dgreen-rim)
    }
  }

  // Left edge: face centres at j=nv-1 (wrapping), i=0..nv-2
  for i in range(nv - 1) {
    let fx = ox - 0.5 * e1x
    let fy = oy + (i + 0.5) * e2y
    let is-red = calc.rem(i + (nv - 1), 2) == 0
    circle((fx + 0.03, fy - 0.04), radius: fr + 0.01,
      fill: shadow-c, stroke: none)
    if is-red {
      circle((fx, fy), radius: fr,
        fill: gradient.radial(
          (dred-spec, 0%), (dred-mid, 50%), (dred-drk, 100%),
          center: (28%, 22%), radius: 72%),
        stroke: 1pt + dred-rim)
    } else {
      circle((fx, fy), radius: fr,
        fill: gradient.radial(
          (dgreen-spec, 0%), (dgreen-mid, 50%), (dgreen-drk, 100%),
          center: (28%, 22%), radius: 72%),
        stroke: 1pt + dgreen-rim)
    }
  }

  // Top-left corner: dashed decayed green dot (diagonal wrapping)
  {
    let fx = ox - 0.5 * e1x
    let fy = oy + (nv - 1 + 0.5) * e2y
    circle((fx + 0.03, fy - 0.04), radius: fr + 0.01,
      fill: shadow-c, stroke: none)
    circle((fx, fy), radius: fr,
      fill: gradient.radial(
        (dgreen-spec, 0%), (dgreen-mid, 50%), (dgreen-drk, 100%),
        center: (28%, 22%), radius: 72%),
      stroke: (paint: dgreen-rim, thickness: 1pt, dash: (3pt, 2pt)))
  }

  // ══════════════════════════════════════════
  //  VERTEX ATOMS  (blue, decayed on PBC boundary)
  // ══════════════════════════════════════════
  for i in range(nv) {
    for j in range(nv) {
      let vx = ox + j * e1x + i * e2x
      let vy = oy + j * e1y + i * e2y
      let is-pbc-copy = (i == 0) or (j == nv - 1)
      circle((vx + 0.03, vy - 0.04), radius: vr + 0.01,
        fill: shadow-c, stroke: none)
      if is-pbc-copy {
        circle((vx, vy), radius: vr,
          fill: gradient.radial(
            (dblue-spec, 0%), (dblue-mid, 50%), (dblue-drk, 100%),
            center: (28%, 22%), radius: 72%),
          stroke: 1pt + dblue-rim)
      } else {
        circle((vx, vy), radius: vr,
          fill: gradient.radial(
            (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
            center: (28%, 22%), radius: 72%),
          stroke: 1pt + blue-rim)
      }
    }
  }

  // ══════════════════════════════════════════
  //  LABELS
  // ══════════════════════════════════════════
  // Row / column indices
  for j in range(nv) {
    content((ox + j * e1x, oy - 0.7),
      text(size: 9pt, fill: rgb("#555555"))[$#j$])
  }
  for i in range(nv) {
    content((ox - 0.7, oy + i * e2y),
      text(size: 9pt, fill: rgb("#555555"))[$#i$])
  }

  // Axis labels
  content((ox + (nv - 1) * e1x / 2, oy - 1.3),
    text(size: 10pt, weight: "bold")[$j$ (column)])
  content((ox - 1.5, oy + (nv - 1) * e2y / 2), angle: 90deg,
    text(size: 10pt, weight: "bold")[$i$ (row)])

  // Legend
  let lx = ox + (nv - 1) * e1x + 1.5
  let ly = oy + (nv - 1) * e2y

  circle((lx + 0.03, ly - 0.04), radius: vr + 0.01, fill: shadow-c, stroke: none)
  circle((lx, ly), radius: vr,
    fill: gradient.radial(
      (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
      center: (28%, 22%), radius: 72%),
    stroke: 1pt + blue-rim)
  content((lx + 0.55, ly), anchor: "west",
    text(size: 9pt)[Data qubit])

  circle((lx + 0.03, ly - 0.9 - 0.04), radius: fr + 0.01, fill: shadow-c, stroke: none)
  circle((lx, ly - 0.9), radius: fr,
    fill: gradient.radial(
      (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
      center: (28%, 22%), radius: 72%),
    stroke: 1pt + red-rim)
  content((lx + 0.55, ly - 0.9), anchor: "west",
    text(size: 9pt)[X-ancilla])

  circle((lx + 0.03, ly - 1.8 - 0.04), radius: fr + 0.01, fill: shadow-c, stroke: none)
  circle((lx, ly - 1.8), radius: fr,
    fill: gradient.radial(
      (green-spec, 0%), (green-mid, 50%), (green-drk, 100%),
      center: (28%, 22%), radius: 72%),
    stroke: 1pt + green-rim)
  content((lx + 0.55, ly - 1.8), anchor: "west",
    text(size: 9pt)[Z-ancilla])

  circle((lx + 0.03, ly - 2.7 - 0.04), radius: vr + 0.01, fill: shadow-c, stroke: none)
  circle((lx, ly - 2.7), radius: vr,
    fill: gradient.radial(
      (dblue-spec, 0%), (dblue-mid, 50%), (dblue-drk, 100%),
      center: (28%, 22%), radius: 72%),
    stroke: 1pt + dblue-rim)
  content((lx + 0.55, ly - 2.7), anchor: "west",
    text(size: 9pt)[PBC copy])
})
