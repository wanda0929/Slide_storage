#import "@preview/cetz:0.3.4"

// ════════════════════════════════
//  PAGE SETUP
// ════════════════════════════════
#set page(width: 11.3cm, height: auto, margin: (x: 0.2cm, y: 0.2cm), fill: white)
#set text(font: "Times New Roman")

// ════════════════════════════════
//  COLOUR PALETTE  (from figure1_combined)
// ════════════════════════════════
#let blue-spec = rgb("#c8e2fc")
#let blue-mid  = rgb("#4a90d0")
#let blue-drk  = rgb("#1a4878")
#let blue-rim  = rgb("#14365a")

#let red-spec  = rgb("#f4b8b0")
#let red-mid   = rgb("#c45050")
#let red-drk   = rgb("#7a2020")
#let red-rim   = rgb("#5a1515")

#let shadow-c = rgb("#00000028")

#let orange-bg     = rgb("#fdf3e0")
#let orange-border = rgb("#d4a040")
#let teal-bg       = rgb("#e2f2f2")
#let teal-border   = rgb("#6cc0c0")

#let arrow-gray = rgb("#707070")

// Panel (d) specific colours
#let syndrome-bg = rgb("#fffce6")
#let correct-bg  = rgb("#e8f4e8")
#let correct-bdr = rgb("#5a9a5a")
#let darkred     = rgb("#8b2222")
#let darkred-bg  = rgb("#fce8e8")

// ════════════════════════════════
//  PANEL (d): Single-Plaquette Circuit
// ════════════════════════════════
#cetz.canvas(length: 0.55cm, {
  import cetz.draw: *

  // ── Title ──
  content((-1.0, 3.5), anchor: "west",
    text(weight: "bold", size: 15pt)[(d)])
  content((1.2, 3.5), anchor: "west",
    text(weight: "bold", size: 15pt)[Single-Plaquette Circuit])

  // ══════════════════════════════
  //  COORDINATES
  // ══════════════════════════════
  // Wire y-positions (top → bottom)
  let ya = 0       // ancilla a₁
  let yd = -2.5    // data D
  let yb = -5.0    // ancilla a₂

  // Gate x-positions (left → right)
  let xb  = 0.5    // atom ball
  let xh1 = 3.2    // Hadamard set 1
  let xor = 5.8    // OR gate
  let xcc = 8.4    // CCX syndrome
  let xh2 = 11.0   // Hadamard set 2
  let xcr = 14.0   // CCX correction
  let xrs = 16.5   // reset
  let xend = 18.0

  // Gate dimensions
  let hw   = 0.85  // multi-qubit gate half-width
  let gpad = 0.55  // extends beyond outer wires
  let hs   = 0.45  // Hadamard half-size

  // ══════════════════════════════
  //  BACKGROUND REGIONS
  // ══════════════════════════════
  // Syndrome mapping (yellow, dashed orange)
  rect((xh1 - 1.0, yb - 1.0), (xh2 + 1.0, ya + 1.5),
    fill: syndrome-bg,
    stroke: (paint: orange-border, thickness: 1.5pt, dash: "dashed"),
    radius: 0.3)
  content(((xh1 + xh2) / 2, ya + 2.1),
    text(weight: "bold", size: 10pt, fill: rgb("#8a6500"))[Syndrome Mapping])

  // Correction & Reset (green, dashed)
  rect((xcr - 1.2, yb - 1.0), (xrs + 1.1, ya + 1.5),
    fill: correct-bg,
    stroke: (paint: correct-bdr, thickness: 1.5pt, dash: "dashed"),
    radius: 0.3)
  content(((xcr + xrs) / 2, ya + 2.1),
    text(weight: "bold", size: 10pt, fill: rgb("#2a6a2a"))[Correction & Reset])

  // ══════════════════════════════
  //  HORIZONTAL WIRES
  // ══════════════════════════════
  for y in (ya, yd, yb) {
    line((xb + 0.5, y), (xend, y), stroke: 1pt + black)
  }

  // ══════════════════════════════
  //  ATOM BALLS  (wire labels)
  // ══════════════════════════════
  let br = 0.40

  // a₁  (red, top)
  circle((xb + 0.04, ya - 0.04), radius: br + 0.02, fill: shadow-c, stroke: none)
  circle((xb, ya), radius: br,
    fill: gradient.radial(
      (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
      center: (30%, 25%), radius: 72%),
    stroke: 1.2pt + red-rim)
  content((xb, ya),
    text(fill: white, weight: "bold", size: 7.5pt)[$a_1$])

  // D  (blue, middle)
  circle((xb + 0.04, yd - 0.04), radius: br + 0.02, fill: shadow-c, stroke: none)
  circle((xb, yd), radius: br,
    fill: gradient.radial(
      (blue-spec, 0%), (blue-mid, 50%), (blue-drk, 100%),
      center: (30%, 25%), radius: 72%),
    stroke: 1.2pt + blue-rim)
  content((xb, yd),
    text(fill: white, weight: "bold", size: 8.5pt)[$D$])

  // a₂  (red, bottom)
  circle((xb + 0.04, yb - 0.04), radius: br + 0.02, fill: shadow-c, stroke: none)
  circle((xb, yb), radius: br,
    fill: gradient.radial(
      (red-spec, 0%), (red-mid, 50%), (red-drk, 100%),
      center: (30%, 25%), radius: 72%),
    stroke: 1.2pt + red-rim)
  content((xb, yb),
    text(fill: white, weight: "bold", size: 7.5pt)[$a_2$])

  // ══════════════════════════════
  //  HADAMARD GATES  (set 1)
  // ══════════════════════════════
  for y in (ya, yd, yb) {
    rect((xh1 - hs, y - hs), (xh1 + hs, y + hs),
      fill: white, stroke: 1.2pt + black, radius: 0.06)
    content((xh1, y),
      text(weight: "bold", size: 10pt)[H])
  }

  // ══════════════════════════════
  //  OR GATE  (orange box)
  // ══════════════════════════════
  rect((xor - hw, yb - gpad), (xor + hw, ya + gpad),
    fill: orange-bg, stroke: 2pt + orange-border, radius: 0.2)
  content((xor, yd),
    text(weight: "bold", size: 11pt)[OR])

  // ══════════════════════════════
  //  CCX SYNDROME GATE  (teal box)
  // ══════════════════════════════
  rect((xcc - hw, yb - gpad), (xcc + hw, ya + gpad),
    fill: teal-bg, stroke: 2pt + teal-border, radius: 0.2)
  content((xcc, yd),
    text(weight: "bold", size: 10pt)[CCX])

  // ══════════════════════════════
  //  HADAMARD GATES  (set 2)
  // ══════════════════════════════
  for y in (ya, yd, yb) {
    rect((xh2 - hs, y - hs), (xh2 + hs, y + hs),
      fill: white, stroke: 1.2pt + black, radius: 0.06)
    content((xh2, y),
      text(weight: "bold", size: 10pt)[H])
  }

  // ══════════════════════════════
  //  CCX CORRECTION GATE  (dark red)
  // ══════════════════════════════
  rect((xcr - hw, yb - gpad), (xcr + hw, ya + gpad),
    fill: darkred-bg, stroke: 2pt + darkred, radius: 0.2)
  content((xcr, yd),
    text(weight: "bold", size: 10pt, fill: darkred)[CCX])

  // ══════════════════════════════
  //  RESET  |0⟩  BOXES
  // ══════════════════════════════
  for y in (ya, yb) {
    rect((xrs - 0.6, y - hs), (xrs + 0.6, y + hs),
      fill: white, stroke: 1.2pt + black, radius: 0.06)
    content((xrs, y),
      text(size: 9pt)[$|0 angle.r$])
  }

  // ══════════════════════════════
  //  ANNOTATION: OR + CCX = XOR
  // ══════════════════════════════
  let by = yb - 1.5
  // bracket lines
  line((xor - hw, by + 0.4), (xor - hw, by), stroke: 0.8pt + arrow-gray)
  line((xor - hw, by), (xcc + hw, by), stroke: 0.8pt + arrow-gray)
  line((xcc + hw, by + 0.4), (xcc + hw, by), stroke: 0.8pt + arrow-gray)
  // tick at midpoint
  line(((xor + xcc) / 2, by), ((xor + xcc) / 2, by - 0.25),
    stroke: 0.8pt + arrow-gray)
  // label
  content(((xor + xcc) / 2, by - 0.65),
    text(size: 8.5pt, fill: arrow-gray, style: "italic")[OR + CCX = parity (XOR)])
})
