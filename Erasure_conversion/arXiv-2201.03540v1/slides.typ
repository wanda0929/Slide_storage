// Slide format: blueprint-style, figure-driven, designed for a ~45–60 min talk.
// Source paper: arXiv:2201.03540 (Wu, Kolkowitz, Puri, Thompson)

#set page(
  paper: "presentation-16-9",
  margin: (x: 1.15cm, y: 0.7cm),
)

#set text(font: "Helvetica", size: 25pt, fill: luma(15))
#set par(leading: 0.65em)

#let accent = rgb("#1B6EF3")
#let good = rgb("#1AA64A")
#let warn = rgb("#E67E22")
#let bad = rgb("#D64541")

#let two_col(left_body, right_body, gap: 1.0cm, left_w: 1fr, right_w: 1fr) = [
  #grid(
    columns: (left_w, right_w),
    gutter: gap,
    align: (left, top),
  )[
    #left_body
  ][
    #right_body
  ]
]

#let fig(path, width: 100%, height: none, caption: none) = [
  #block(breakable: false)[
    #align(center)[
      #if height == none {
        image(path, width: width)
      } else {
        image(path, height: height)
      }
      #if caption != none [
        #v(0.25em)
        #text(size: 12pt, fill: luma(120))[#caption]
      ]
    ]
  ]
]

#let callout(label, body, color: accent) = [
  #block(
    inset: (x: 0.6em, y: 0.4em),
    radius: 6pt,
    fill: luma(252),
    stroke: 1pt + color,
  )[
    #text(weight: "bold", fill: color)[#label] #h(0.4em) #body
  ]
]

#let keynum(label, value, note: none, color: accent, value_size: 28pt) = [
  #block(
    inset: (x: 0.6em, y: 0.4em),
    radius: 8pt,
    fill: luma(252),
    stroke: 1pt + luma(220),
  )[
    #text(size: 14pt, fill: luma(110))[#label]
    #v(0.1em)
    #text(size: value_size, weight: "bold", fill: color)[#value]
    #if note != none [
      #v(0.05em)
      #text(size: 13pt, fill: luma(110))[#note]
    ]
  ]
]

#let bg_grid(step: 1cm, minor: 0.5cm) = [
  #place(top + left)[
    // minor grid
    #set line(stroke: 0.25pt + luma(242))
    #for y in range(0, 40) {
      place(top + left, dy: y * minor)[#line(length: 100%)]
    }
    #for x in range(0, 80) {
      place(top + left, dx: x * minor)[
        #rotate(90deg)[#line(length: 100%)]
      ]
    }

    // major grid
    #set line(stroke: 0.5pt + luma(235))
    #for y in range(0, 20) {
      place(top + left, dy: y * step)[#line(length: 100%)]
    }
    #for x in range(0, 40) {
      place(top + left, dx: x * step)[
        #rotate(90deg)[#line(length: 100%)]
      ]
    }
  ]
]

#let frame() = [
  #place(top + left)[
    #rect(width: 100%, height: 100%, stroke: 1pt + luma(215), fill: none)
  ]
]

#let slide(title, tag: none, body) = [
  #pagebreak()
  #counter("slide").step()
  #bg_grid()
  #frame()

  #block(width: 100%)[
    #text(size: 32pt, weight: "bold")[#title]
    #if tag != none [
      #h(0.6em)
      #text(size: 12pt, fill: luma(115))[#tag]
    ]
    #v(-0.35em)
    #line(length: 100%, stroke: 1.2pt + luma(210))
  ]
  #v(0.25em)
  #body
]

#let section(title, subtitle: none, minutes: none) = [
  #pagebreak()
  #counter("slide").step()
  #bg_grid()
  #frame()

  #let tag = if minutes != none {"~" + str(minutes) + " min"} else {none}

  #block(width: 100%, height: 100%)[
    #align(center + horizon)[
      #set align(center)
      #block(width: 100%)[
        #text(size: 44pt, weight: "bold")[#title]
        #if subtitle != none [
          #v(0.5em)
          #text(size: 28pt, fill: luma(60))[#subtitle]
        ]
        #if tag != none [
          #v(0.9em)
          #text(size: 12pt, fill: luma(115))[#tag]
        ]
      ]
    ]
  ]
]

// ============================================================================
// Title slide (no slide number)
// ============================================================================

#bg_grid()
#frame()

#set align(left)
#block(breakable: false)[
  #grid(
    columns: (1.05fr, 0.95fr),
    gutter: 1.0cm,
    align: (left, top),
  )[
    #block(
      inset: 0.35em,
      radius: 6pt,
      fill: luma(252),
      stroke: 1pt + luma(220),
    )[
      #image("typst_assets/fig1_v14.pdf.png", width: 92%)
      #v(0.2em)
      #text(size: 12pt, fill: luma(120))[Fig. 1 (Wu et al.): encoding + detection + XZZX patch + circuit]
    ]
  ][
    #text(size: 36pt, weight: "bold")[Erasure conversion]
    #v(-1.08em)
    #text(size: 26pt, weight: "bold")[for Fault-Tolerant Quantum Computing]
    #v(-0.95em)
    #text(size: 16pt, fill: luma(80))[Alkaline-earth(-like) Rydberg atom arrays (#super[171]Yb)]
    #v(-0.75em)

    #block(
      inset: (x: 0.6em, y: 0.5em),
      radius: 8pt,
      fill: luma(252),
      stroke: 1pt + luma(220),
    )[
      #grid(columns: (1fr, 1fr), gutter: 0.6cm)[
        #keynum("Key mechanism", "Detect leakage", note: "fluorescence + autoionization", color: accent)
      ][
        #keynum("Conversion", [$R_e ≈ 0.98$], note: "errors → erasures", color: good)
      ]
      #v(-0.9em)
      #keynum("QEC threshold", [0.94% → 4.15%], note: "surface code (XZZX)", color: accent)
    ]

    #v(0.5em)
    #text(size: 14pt, fill: luma(95))[Based on arXiv:2201.03540 (Wu, Kolkowitz, Puri, Thompson) • Journal Club • 45–60 min]
  ]
]

#counter("slide").update(0)

// Page numbers (start on the first content slide; hide on title slide).
#set page(
  footer: context [
    #align(right)[
      #text(size: 13pt, fill: luma(120))[
        #counter("slide").display() / #numbering("1", ..counter("slide").final())
      ]
    ]
  ],
)

// ============================================================================
// 0) BLUF + Roadmap
// ============================================================================

#slide("hard-to-locate faults --> known-location erasures", tag: "0–3 min")[
  #v(-2.0em)
  #two_col(
    [
      #callout(
        "Bottom line",
        [Encode qubits in a metastable manifold so that dominant Rydberg-decay faults produce *bright* signals that can be flagged as erasures.],
        color: accent,
      )
      #v(.4em)
      #grid(columns: (1fr, 1fr), gutter: 0.7cm)[
        #keynum("Conversion", [$R_e ≈ 0.98$], note: "most faults get flagged", color: good, value_size: 26pt)
      ][
        #keynum("Surface-code threshold", [0.937% → 4.15%], note: "XZZX + Union-Find", color: accent, value_size: 22pt)
      ]
      #v(-0.35em)
      
    ],
    [
      #fig(
        "typst_assets/fig_pl.pdf.png",
        height: 9.9cm,
        caption: "Circuit-level threshold vs erasure conversion (paper Fig. 3).",
      )
    ],
    gap: 1.05cm,
    left_w: 1.05fr,
    right_w: 0.95fr,
  )
  // - *Decoder side-information* (erasure map) is as valuable as raw fidelity.
]

#slide("Overview", tag: "0–3 min")[
  // #v(-1.0em)
  #callout("Thesis", [If most gate faults become *detected erasures*, surface-code decoding becomes much easier.], color: accent)
      // #v(-0.6em)
      - *Motivation:* why “known location” errors are special
      - *Mechanism:* metastable encoding makes the qubit dark + errors bright
      - *Protocol:* post-gate (R/B) monitoring → erasure map
      - *QEC evidence:* XZZX surface-code simulations + Union-Find
      // - *Limitations:* what breaks $R_e$ and what the hardware must do
]

// ============================================================================
// 1) Motivation
// ============================================================================

#section("Motivation: make errors easier", subtitle: "Changing the *effective* noise model", minutes: 10)

#slide("Fault tolerance works when the decoder can keep up with physical noise", tag: "~2 min")[
  - Physical operations are noisy → faults accumulate over time.
  - QEC measures *syndromes* to constrain which faults occurred.
  - *Threshold theorem:* below a threshold, increasing code distance suppresses logical error.
  #v(0.6em)
  #callout("Key move", [Don’t only reduce fault rate—*add side information that localizes faults.*], color: accent)
]

#let dot(fill, label: none, r: 8pt, stroke: 1pt + luma(120)) = [
  #stack(
    circle(radius: r, fill: fill, stroke: stroke),
    if label != none [
      #align(center + horizon)[
        #text(size: 11pt, fill: luma(20))[#label]
      ]
    ] else [],
  )
]

#slide("Known-location erasures are far easier to decode than unknown Pauli faults", tag: "~3 min")[
 #image("locationerror.png", width: 76%)
]

// ============================================================================
// 2) Physical layer
// ============================================================================

#section("Physical layer: why #super[171]Yb", subtitle: "Metastable encoding creates *dark* and *bright* manifolds", minutes: 20)

#slide("Alkaline-earth(-like) atoms let us measure leakage via an “in Q?” test (without measuring the logical qubit)", tag: "~2 min")[
  #two_col(
    [
      - What we want is a two-outcome check: “still in $Q$?” vs “not in $Q$?” (a projector test), *without* collapsing the logical state encoded *within* $Q$.
      #v(0.4em)
      - *Why alkaline-earth(-like)/two-electron atoms matter:* they offer a long-lived *metastable clock state* for $Q$ *and* a near-closed *strong cycling transition* in the ground manifold with *huge spectral separation*.
        - In #super[171]Yb, choose $Q =$ 6s6p #super[3]P#sub[0] (τ ≈ 20 s): long-lived storage, and detection light can be far detuned.
        - If leaked to other manifolds, scatter many photons on fast cycles:
          - ground 6s#super[2] #super[1]S#sub[0] → 399 nm fluorescence
          - ion Yb#super[+] → 369 nm fluorescence
      - (Contrast) In alkali hyperfine ground-state qubits, the cycling transition typically *does* distinguish qubit states, so fluorescence tends to be a *qubit* readout, not a clean “in-$Q$?” test.
      #v(0.5em)
      #callout(
        "What is being measured?",
        [We measure the *electronic-manifold projector* Π#sub[Q] (“in $Q$”) vs I − Π#sub[Q] (“leaked”). The cycling light couples strongly to leaked manifolds but is far off-resonant for #super[3]P#sub[0], so “bright vs dark” reveals leakage *without resolving (or collapsing) the nuclear-spin logical basis stored inside $Q$*.],
        color: accent,
      )
    ],
    [
      #block(inset: 0.6em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Selective fluorescence: $Q$ is dark, $R/B$ are bright (large spectral separation)]
        #v(0.35em)
        #set text(size: 13.5pt)
        #grid(columns: (11.32fr, 1.68fr), gutter: 0.45cm)[
          [#text(weight: "bold")[Manifold]] [#text(weight: "bold")[Fluorescence (interpretation)]]

          [$Q$] [Metastable qubit manifold (#super[3]P#sub[0]): cycling light is far detuned (electronic line separation ≫ linewidth) → *no clicks* (“in $Q$”), independent of the logical state within $Q$.]

          [$R$] [Ground manifold (#super[1]S#sub[0]): 399 nm cycling transition → *bright* (“not in $Q$”).]

          [$B$] [Ion manifold (Yb#super[+]): 369 nm cycling transition → *bright* (“not in $Q$”).]
        ]
        #v(0.35em)
        #text(size: 13pt, fill: luma(110))[Operationally: click → flag an erasure at a known location; no click → keep the qubit.]
      ]
    ],
    gap: 1.1cm,
  )
]

#slide("Encoding in a metastable manifold makes valid qubits optically dark", tag: "~3 min")[
  #two_col(
    [
      - Encode qubit in 6s6p #super[3]P#sub[0] (metastable).
      - Nuclear spin states form the qubit:
      - $F = 1/2$, $m_F = ± 1/2$.
      - Metastable lifetime: τ ≈ 20 s.
      #v(0.4em)
      #callout("Design principle", [Choose detection light that strongly scatters from error manifolds but is far-detuned from $Q$.], color: good)
    ],
    [
      #block(inset: 0.6em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Energy-level cartoon]
        #v(0.2em)
        #set line(stroke: 2pt + luma(50))
        #line(length: 80%)
        #text(size: 14pt)[#h(0.2em) #super[3]P#sub[0] (Q)]
        #v(1.2em)
        #set line(stroke: 2pt + luma(70))
        #line(length: 80%)
        #text(size: 14pt)[#h(0.2em) #super[1]S#sub[0] (ground)]
        #v(0.6em)
        #text(size: 13pt, fill: luma(100))[Large optical gap → state-selective fluorescence without addressing $Q$.]
      ]
    ],
    gap: 1.2cm,
  )
]

// ============================================================================
// 3) Gate physics + decay
// ============================================================================

#section("Gate physics: where errors come from", subtitle: "Rydberg blockade gates are fast—but decay is fundamental", minutes: 10)

#slide("Rydberg-gate infidelity is fundamentally set by time spent in |r⟩", tag: "~2 min")[
  #two_col(
    [
      - Two-qubit entangling gates excite population to |r⟩.
      - Any time spent in |r⟩ risks decay.
      #v(0.5em)
      #callout("Rule of thumb", [$p_"decay" ≈ ⟨P_r⟩ Γ t_g$ with $⟨P_r⟩ ∼ 1/2$.], color: warn)
      #v(0.3em)
      - Question: can we *detect* most of these decay events, at the time they occur?
    ],
    [
      #block(inset: 0.6em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Cartoon]
        #v(0.4em)
        #set line(stroke: 2pt + luma(60))
        #line(length: 85%)
        #text(size: 14pt)[#h(0.2em) |r⟩ (Rydberg)]
        #v(0.9em)
        #set line(stroke: 2pt + luma(60))
        #line(length: 85%)
        #text(size: 14pt)[#h(0.2em) |1⟩ (in Q)]
        #v(-1.2em)
        #align(center)[
          #text(size: 22pt, weight: "bold", fill: accent)[↑ Ω]
        ]
        #v(0.5em)
        #text(size: 13pt, fill: luma(100))[Decay during the pulse is the dominant intrinsic infidelity.]
      ]
    ],
  )
]

#slide("Atomic branching sends ~95% of Rydberg decays outside Q (making them detectable)", tag: "~3 min")[
  #two_col(
    [
      #callout("Key atomic-physics fact", [For representative $n ∼ 75$ states: ~95% of decay pathways land *outside* the qubit manifold.], color: good)
      #v(0.35em)
      - Blackbody transitions → nearby Rydberg manifold (~61%)
      - Radiative decay → ground state (~34%)
      - Radiative decay → qubit manifold (~5%)
      #v(0.35em)
      #text(size: 13pt, fill: luma(100))[Subtlety: some “back-to-Q” decays occur mid-gate, re-excite, and still get flagged at the end of the gate layer.]
    ],
    [
      #block(inset: 0.35em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 14pt, weight: "bold", fill: luma(60))[Flow diagram]
        #v(0.1em)
        #set line(stroke: 1.2pt + luma(120))
        #stack(spacing: 0.25em)[
          #block(inset: 0.28em, radius: 6pt, fill: rgb("#E9F2FF"), stroke: 1pt + accent)[
            *BBR*\
            #text(size: 11pt, fill: luma(90))[~61%]\
            nearby Rydbergs
          ]
          #block(inset: 0.28em, radius: 6pt, fill: rgb("#FFF1E6"), stroke: 1pt + warn)[
            *Radiative*\
            #text(size: 11pt, fill: luma(90))[~34%]\
            ground
          ]
          #block(inset: 0.28em, radius: 6pt, fill: rgb("#E9F9EF"), stroke: 1pt + good)[
            *Back to Q*\
            #text(size: 11pt, fill: luma(90))[~5%]\
            metastable (Q)
          ]
        ]
      ]
    ],
    gap: 1.0cm,
  )
]

// ============================================================================
// 4) Erasure conversion protocol
// ============================================================================

#section("Protocol: erasure conversion", subtitle: "Measure *outside* Q after each gate layer", minutes: 15)

#slide("Post-gate fluorescence converts leakage into an erasure map", tag: "~3 min")[
  #two_col(
    [
      #callout("After each parallel 2Q-gate layer", [Run a short detection sequence that only clicks if the atom is *not* in $Q$.], color: accent)
      #v(0.6em)
      - *R detection:* illuminate a cycling transition for ground manifold → site-resolved fluorescence.
      - *B detection:* autoionize remaining Rydberg population → detect Yb#super[+] ion fluorescence.
      - Qubit subspace is (ideally) dark → approximately QND.
    ],
    [
      #block(inset: 0.6em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Decision rule]
        #v(0.3em)
        #grid(columns: (1fr, 1fr), gutter: 0.8cm)[
          #callout("No click", [state stays in Q → keep qubit], color: good)
        ][
          #callout("Click", [flag location as *erasure*], color: warn)
        ]
        #v(0.4em)
        #text(size: 13pt, fill: luma(100))[Decoder receives an *erasure map* alongside stabilizer syndromes.]
      ]
    ],
    gap: 1.1cm,
  )
]

#slide("A simple decision rule turns many physical outcomes into one decoder input", tag: "~2 min")[
  - After a gate, each atom is in one of:
    - $Q$ (still a qubit)
    - $R$ (ground fluorescence)
    - $B$ (ion fluorescence)
  #v(0.5em)
  #block(inset: 0.6em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
    #grid(columns: (1fr, 1fr), gutter: 1.0cm)[
      [
        #text(weight: "bold")[Two-atom outcome]\
        QQ, QR, QB, RR, RB, BB, …
      ][
        #text(weight: "bold")[Mapping]\
        QQ → keep\
        otherwise → *erasure on involved qubit(s)*
      ]
    ]
    #v(0.35em)
      #text(size: 13pt, fill: luma(110))[Corner case: BB (two ions) can be hard to resolve—expected to be rare ($p_f \ll p_e$).]
  ]
]

#slide("The single parameter $R_e$ summarizes how often faults become flagged erasures", tag: "~2 min")[
  Define:
  - $p_e$: probability an error is detected (erasure)
  - $p_p$: probability an *undetected* error stays within Q (Pauli-type)
  - $R_e = p_e / (p_e + p_p)$
  #v(0.35em)
  #grid(columns: (1fr, 1fr), gutter: 0.8cm)[
    #keynum("Paper estimate", [$R_e ≈ 0.98$], note: "dominant decay → erasures", color: good, value_size: 26pt)
  ][
    #callout("Interpretation", [Most intrinsic gate faults are *flagged* with known location.], color: accent)
  ]
]

// ============================================================================
// 5) QEC layer
// ============================================================================

#section("QEC layer: what does this buy you?", subtitle: "Surface-code threshold and scaling improve", minutes: 18)

#slide("Circuit-level simulations quantify the value of erasure side-information", tag: "~2 min")[
  - Code: planar *XZZX surface code*.
  - Distance $d$: simulate $d$ rounds of syndrome extraction on a $d × d$ patch.
  - Decoder: *weighted Union-Find* (fast; handles erasures well).
  #v(0.6em)
  #callout("Input to decoder", [syndromes + erasure map (locations)], color: good)
]

#slide("The simulated noise model mixes erasures with residual Pauli errors", tag: "~2 min")[
  Each two-qubit gate:
  - with probability $p_e = p R_e$: *erasure*
    - model: replace involved qubits with maximally mixed state
    - location provided to decoder
  - with probability $p_p = p (1 - R_e)$: *Pauli error*
    - uniform over 15 non-identity two-qubit Paulis
  #v(0.5em)
  #text(size: 14pt, fill: luma(100))[Single-qubit and SPAM errors are discussed in the SI; main threshold story is set by 2Q-gate noise.] 
]

#slide("Erasure conversion boosts the circuit-level threshold by ~4.4×", tag: "~3 min")[
  #two_col(
    [
      #callout("Headline", [With $R_e ≈ 0.98$, the threshold rises from 0.937% to 4.15%.], color: accent)
      #v(0.35em)
      #grid(columns: (1fr, 1fr), gutter: 0.7cm)[
        #keynum("Pauli baseline", [0.937%], note: [p#sub[th] (XZZX)], color: bad, value_size: 26pt)
      ][
        #keynum("With conversion", [4.15%], note: [$R_e ≈ 0.98$], color: good, value_size: 26pt)
      ]
      #v(0.25em)
      - The figure also shows p#sub[th] increases smoothly with $R_e$.
    ],
    [
      #fig(
        "typst_assets/fig_pl.pdf.png",
        height: 7.6cm,
        caption: [Logical failure rate crossing + threshold p#sub[th] vs $R_e$ (paper Fig. 3).],
      )
    ],
    gap: 1.0cm,
  )
]

#slide("Below threshold, erasures increase the effective exponent of logical suppression", tag: "~2 min")[
  #two_col(
    [
      - Below threshold, logical error often fits $p_L ≈ A p^ν$.
      - For Pauli noise: effective exponent is roughly $(d + 1) / 2$.
      - For erasures: exponent approaches $d$.
      #v(0.35em)
      #callout("Meaning", [For fixed qubit count, you get *more* logical suppression—resource savings.], color: good)
    ],
    [
      #fig(
        "typst_assets/fig_distance.pdf.png",
        height: 7.6cm,
        caption: "Exponent increases with $R_e$ (paper figure).",
      )
    ],
    gap: 1.0cm,
  )
]

#slide("Erasure conversion competes with bias-tailored QEC without bias-preserving gates", tag: "~1 min")[
  - Alternative for Rydberg arrays: engineer highly *biased* noise + bias-preserving gates.
  - Paper reports (for XZZX):
    - $p_"th" ≈ 2.27%$ for bias $η = 100$
    - $p_"th" ≈ 3.69%$ for $η → ∞$
  #v(0.5em)
  #callout("Takeaway", [Erasure conversion can be competitive/superior for $R_e ≳ 0.96$, without bias-preserving constraints.], color: accent)
]

#slide("Ablations show the benefit persists unless $R_e$ drops substantially", tag: "~2 min")[
  #two_col(
    [
      - The threshold increases smoothly with $R_e$.
      - At $R_e = 1$, the paper reports $p_"th" ≈ 5.13%$.
      - At $R_e ≈ 0.98$ (estimated for #super[171]Yb), $p_"th" ≈ 4.15%$.
      #v(0.5em)
      #callout("Practical interpretation", [You do not need perfect conversion; you need $R_e$ high enough that residual Pauli noise is a small fraction.], color: good)
    ],
    [
      #fig(
        "typst_assets/fig_pl.pdf.png",
        height: 7.6cm,
        caption: [Same figure; right panel highlights threshold p#sub[th] vs $R_e$.],
      )
    ],
    gap: 1.0cm,
  )
]

// ============================================================================
// 6) Implications + practicalities
// ============================================================================

#section("Practicalities and limitations", subtitle: "What must work—and what could break $R_e$?", minutes: 10)

#slide("Fast, high-fidelity detection is the central experimental requirement", tag: "~2 min")[
  - Need site-resolved detection of:
    - ground-state atoms via a cycling transition (fluorescence)
    - ions after autoionization (ion fluorescence)
  - Paper argues ~10 µs imaging can reach:
    - neutral-atom detection fidelity > 0.999
    - ion detection fidelity > 0.99
  #v(0.5em)
  #callout("Why it matters", [Missed erasures become Pauli-like noise; false positives create unnecessary holes.], color: warn)
]

#slide("Once detected, erasures can be contained instead of propagating across cycles", tag: "~2 min")[
  #two_col(
    [
      - Flag the location(s) for the decoder.
      - Hardware option: replace the atom from a reservoir using a movable tweezer.
      - Modeling option: treat erased sites as maximally mixed and skip gates on them.
      #v(0.6em)
      #callout("Operational benefit", [Leakage becomes *contained* instead of propagating through future cycles.], color: good)
    ],
    [
      #block(inset: 0.6em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Workflow]
        #v(0.2em)
        1. Gate layer\
        2. Detect (R/B) → erasure map\
        3. Decode with erasures\
        4. (Optional) replace / reinitialize\
      ]
    ],
    gap: 1.0cm,
  )
]

#slide([R#sub[e] degrades when technical noise dominates over detectable decay], tag: "~2 min")[
  - Technical noise that creates *in-subspace* errors without leakage:
    - laser phase/amplitude noise
    - Doppler / motion, imperfect blockade
    - crosstalk from detection beams
  - Imperfect detection:
    - missed clicks (erasure → hidden error)
    - false clicks (unnecessary erasure)
  #v(0.5em)
  #callout("Practical message", [The scheme is strongest when *intrinsic* decay dominates the gate error budget.], color: accent)
]

#slide("Undetectable channels exist but are engineered to be rare", tag: "~2 min")[
  #two_col(
    [
      - Most decay channels land in $R$ (ground) or $B$ (ion), which are detectable.
      - Two main “bad” cases:
        - *Return to $Q$* without later being flagged → residual Pauli faults ($p_p$).
        - *BB* (two ions) can be hard to resolve → undetected leakage ($p_f$).
      #v(0.5em)
      #callout("Paper claim", [$p_f$ is strongly suppressed by blockade; $p_p$ is ~50× smaller than $p_e$ in gate simulations.], color: good)
    ],
    [
      #fig(
        "typst_assets/fig_gatesim.pdf.png",
        height: 7.8cm,
        caption: "Gate infidelity decomposes into detectable vs undetectable channels (paper Fig. 2).",
      )
    ],
    gap: 1.0cm,
  )
]

#slide("Erasures can reduce distillation overhead by enabling rejection of flagged faults", tag: "~2 min")[
  #two_col(
    [
      - Many distillation routines can *discard* states when a fault is flagged.
      - With erasures, you can reject bad inputs instead of “purifying through” unknown faults.
      #v(0.6em)
      #callout("Result (qualitative)", [Higher acceptance of reliable states + improved output scaling at fixed hardware error.], color: good)
    ],
    [
      #block(inset: 0.6em, radius: 8pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Scaling cartoon]
        #v(0.4em)
        #text(size: 14pt, fill: luma(90))[Unknown (Pauli) faults propagate → higher-order suppression only after many rounds.]
        #v(0.4em)
        #text(size: 14pt, fill: luma(90))[Flagged erasures can be *post-selected away* early.]
      ]
    ],
  )
]

// ============================================================================
// Wrap-up
// ============================================================================

#section("Wrap-up", subtitle: "Key numbers + what to remember", minutes: 5)

#slide("Erasure conversion makes detectability a first-class resource", tag: "~1 min")[
  #grid(columns: (1fr, 1fr, 1fr), gutter: 0.55cm)[
    #keynum("Physical trick", "Metastable Q", note: "Q is dark; errors go bright", color: accent, value_size: 24pt)
  ][
    #keynum("Conversion", "R_e ≈ 0.98", note: "dominant decay → flagged", color: good, value_size: 24pt)
  ][
    #keynum("QEC outcome", [$p_"th" ≈ 4.15%$], note: "baseline 0.937%", color: accent, value_size: 24pt)
  ]
  #v(0.35em)
  #text(size: 16pt, fill: luma(70))[Message: detectability can be as valuable as fidelity.]
]

#slide("Discussion prompts", tag: "~3–5 min")[
  - What are the hardest experimental pieces? (ion detection? crosstalk? QND-ness?)
  - How robust is $R_e$ to technical noise and imperfect blockade?
  - What if erasure flags are imperfect (missed / false positives)?
  - Could we tailor codes/decoders further to mixed erasure+Pauli noise?
]

// ============================================================================
// Backup figures
// ============================================================================

#slide("Backup: CZ pulse sequence + populations (SI)")[
  #fig(
    "typst_assets/fig_gate_si.pdf.png",
    height: 9.2cm,
    caption: "Levine–Pichler CZ sequence and per-channel probabilities (SI figure).",
  )
]

#slide("Backup: transition flow during gate (SI)")[
  #fig(
    "typst_assets/fig_transitions.pdf.png",
    height: 9.2cm,
    caption: "Channel flow for |10⟩ and |11⟩ initial states (SI figure).",
  )
]

#slide("Backup: branching calculation (SI)")[
  #fig(
    "typst_assets/fig_branching.pdf.png",
    height: 9.2cm,
    caption: "Partial rates and branching into manifolds (SI figure).",
  )
]
