// Journal-club slide deck generated from: "Analyzing Vision Transformer Paper.md"

#set page(
  paper: "presentation-16-9",
  margin: (x: 1.2cm, y: 0.8cm),
)

#set text(size: 26pt, fill: luma(15))
#set par(leading: 0.65em)

// Center all images (figures) by default.
// #show image: it => align(center)[it]

#let accent = rgb("#1B6EF3")
#let good = rgb("#1AA64A")
#let warn = rgb("#E67E22")
#let bad = rgb("#D64541")

#let hline() = line(length: 100%, stroke: 1.2pt + luma(210))

#let two_col(left_body, right_body, gap: 1.0cm, left_w: 1fr, right_w: 1fr) = [
  #grid(columns: (left_w, right_w), gutter: gap, align: left + top)[
    #left_body
  ][
    #right_body
  ]
]

#let callout(label, body, color: accent) = [
  #block(
    inset: (x: 0.6em, y: 0.45em),
    radius: 8pt,
    fill: luma(252),
    stroke: 1pt + color,
  )[
    #text(weight: "bold", fill: color)[#label] #h(0.5em) #body
  ]
]

#let keynum(label, value, note: none, color: accent) = [
  #block(
    inset: (x: 0.6em, y: 0.45em),
    radius: 10pt,
    fill: luma(252),
    stroke: 1pt + luma(220),
  )[
    #text(size: 14pt, fill: luma(110))[#label]
    #v(0.1em)
    #text(size: 30pt, weight: "bold", fill: color)[#value]
    #if note != none [
      #v(0.1em)
      #text(size: 13pt, fill: luma(110))[#note]
    ]
  ]
]

#let section(title, subtitle: none) = [
  #pagebreak()
  #counter("slide").step()
  #align(center + horizon)[
    #block(width: 100%)[
      #text(size: 48pt, weight: "bold")[#title]
      #if subtitle != none [
        #v(0.6em)
        #text(size: 28pt, fill: luma(70))[#subtitle]
      ]
    ]
  ]
]

#let slide(title, subtitle: none, body) = [
  #pagebreak()
  #counter("slide").step()
  #block(width: 100%)[
    #text(size: 36pt, weight: "bold")[#title]
    #if subtitle != none [
      #v(-0.7em)
      #text(size: 14pt, fill: luma(110))[#subtitle]
    ]
    #v(-0.4em)
    #hline()
  ]
  #v(0.25em)
  #body
]

// ---------------------------------------------------------------------------
// Title slide (no page number)
// ---------------------------------------------------------------------------

#set align(left)
#block(width: 100%)[
  #text(size: 46pt, weight: "bold")[Erasure conversion for quantum fault tolerance]
  #v(-1.3em)
  #text(size: 24pt, fill: luma(75))[Metastable alkaline-earth(-like) atoms convert dominant gate faults into known-location erasures]
  #v(-0.7em)
  #callout(
    "One-line thesis",
    [If hardware can *flag where faults happened*, surface-code decoding becomes much easier and thresholds rise dramatically.],
    color: accent,
  )
  #v(-0.9em)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 0.7cm)[
    #keynum("Erasure fraction", [$R_e ≈ 0.98$], note: "estimated in proposal", color: good)
  ][
    #keynum("Surface-code threshold", [0.937% → 4.15%], note: "proposal summary", color: accent)
  ][
    #keynum("Core mechanism", "bright-vs-dark", note: "fluorescence detects leakage", color: warn)
  ]
  // #v(0.7em)
  // #text(size: 14pt, fill: luma(110))[Journal club • Based only on the provided proposal summary of arXiv:2201.03540]
]

#counter("slide").update(0)

#set page(
  footer: context [
    #align(right)[
      #text(size: 13pt, fill: luma(120))[
        #counter("slide").display() / #numbering("1", ..counter("slide").final())
      ]
    ]
  ],
)

// ---------------------------------------------------------------------------
// 0) Roadmap
// ---------------------------------------------------------------------------

// #slide("Roadmap", subtitle: "What we will analyze")[
//   - Why the surface code threshold is limited under unknown-location Pauli noise
//   - What an *erasure* error is and why it is easier to correct
//   - How metastable encoding + fluorescence turns dominant faults into erasures
//   - What simulations claim: threshold jump and scaling benefits
//   - Practical requirements, failure modes, and open questions
// ]

// ---------------------------------------------------------------------------
// 1) Background: QEC + noise models
// ---------------------------------------------------------------------------

#section("1. Motivation", subtitle: "Detectability as a resource")

#slide("Fault tolerance is a race between noise and decoding")[
  - QEC spreads logical information across many physical qubits@Khalifa.
  - Syndrome measurements constrain what errors could have happened.
  - A *decoder* must infer a correction consistent with syndromes.
  #v(-1.0em)
  #align(center)[
  #image("QEC.png", width: 84%)
  ]
]

#slide("Baised noise")[
  #v(-1.6em)
  - Standard error model: depolarizing noise (X,Y,Z errors)
  - Biased noise: one type of error (e.g., Z) is much more likely than others.
  #align(center)[
    #figure(
  image("threshold_error_rate.png", width: 38%),
  caption: [Threshold error rate vs bias@PhysRevX.9.041031],
  )
  ]

  - We find that the most biased condition have the highes error rate threshold about 50%.
  - unbased condition: 18% threshold.(all perfect syndrome measurement)
  - experimental condition: (errors+noisy operations) about 1% threshold.(surface code)@Fowler_2012

]

#slide("Baised noise")[
  #v(-1.0em)
  #callout("Reason:", [The biased condition over one possible error reduced the space of possibilities for decoding syndrome measurements], color: accent)

  #align(center)[
  #image("biasedZ.png", width: 91%)
  ]
]

#slide("Erasure errors")[
  #v(-1.0em)
  - An erasure error is a fault that occurs at a *known* location, but with an unknown Pauli type.
  - Erasures are easier to correct: location of the error is avaliable to facilitate decoding.
  #v(0.6em)
  #align(center)[
  #image("erasure.png", width: 68%)
  ]
]

#slide("Erasure errors can correct more errors")[
  #v(-1.0em)
  #callout("Key point", [erasure channel can detect more errors than depolarizing channel and correct *twice* as many errors], color: accent)
  #align(center)[
  #image("3-repitition code.png", width: 65%)
  ]
]




#slide("Pauli errors vs erasures: what changes?", subtitle: "Same physics, different classical information")[
  #v(-1.4em)
  #two_col(
    [
      #callout("Unknown-location Pauli fault", [A qubit suffers $X\/Z\/Y$ (or 2-qubit Pauli) at an unknown site.], color: bad)
      #v(-0.7em)
      - Decoder must solve an inference problem: *which* sites failed?
      - In surface-code decoding, ambiguity creates logical failures when many competing explanations exist.
    ],
    [
      #callout("Known-location erasure", [A fault occurred at a *known* site (location known; Pauli type may be unknown).], color: good)
      #v(-0.4em)
      - Decoder treats erased sites as “missing / unreliable”.
      - Less ambiguity → higher correctable rate at fixed code distance.
    ],
    gap: 1.0cm,
  )
  #align(center)[
  #image("/arXiv-2201.03540v1/locationerror.png", width: 96%)
  ]
]

#slide("Surface code context")[
  - Surface code: 2D local checks; high practical threshold under Pauli noise (proposal: ~1%).
  - But “barely below threshold” is not enough—reasonable overhead needs $p$ well below threshold.
  #v(0.6em)
  #callout("Motivating question", [Can the hardware *reveal* the location of its dominant errors, so the decoder’s job becomes easier?], color: accent)
]

// ---------------------------------------------------------------------------
// 2) Physical idea: metastable encoding
// ---------------------------------------------------------------------------

#section("2. Physical layer", subtitle: "Metastable encoding makes valid qubits dark")

#slide("Error source in neutral atom platform")[
  #v(-1.0em)
  - Ground state atoms: long-lived, low error rates, but hard to entangle.
  - Rydberg states: strong interactions enable fast gates, but short-lived and error-prone.
  - Dominant gate fault: Rydberg decay during the gate.@Horn2011
  #align(center)[
  #image("decay.jpg", width: 69%)
  ]
]

#slide("Rydberg decay channels for Rb atoms")[

  - Encode qubits in a long-lived ground state of atoms Rb and Cs. Dominant gate fault (Rydberg decay) typically lands in the ground state manifold, becoming undetectable Pauli errors.
  #align(center)[
  #image("biased-z.png", width: 90%)
  ]
  - Dipole selection + optical pumping for biased Z-error@cong2022hardwareefficientfaulttolerantquantumcomputation
  #align(center)[
  #image("decay-rb.png", width: 50%)
  ]
]

#slide("Erasure conversion for Ybs atoms")[
#v(-1.0em)
  - What if we convert decay error all to erasure errors?
  #align(center)[
  #image("decay_yb.png", width: 40%)
  ]
  - Yb atoms, metastable states with long coherence times.
  - Detect the population in the ground state manifold via fluorescence without discturbing the qubit manifold.

  #callout(
    "Condition for erasure conversion",
    [
      Absolute seperation of Computational subspace $Q$ and dominant error subspace $R$ (leakage); *detectable* signals without influencing $Q$.

    ],
  )
]


#slide("Why 171-Yb enables erasure conversion")[
  #v(-1.0em)
  
    // "Core idea",
    // [Store the qubit in a long-lived metastable manifold so that the dominant gate fault (Rydberg decay) leaves the manifold and becomes optically *detectable* as a known-location erasure.],
  - *Metastable qubit storage:* encode in a long-lived metastable manifold $ .^3 P_0$ with a long lifetime (~20 s). 
  - *Errors → erasures:* The dominate error mechanism (Rydberg decay) typically lands in the true ground state $ .^1 S_0$(detectable). 
  - *Non-destructive detection:* $ .^1S_0$ is optically distinct from $ .^3P_0$, so probing a cycling transition (e.g., $ .^1S_0 ↔ .^1P_1$) makes leaked atoms sfluoresce (bright) while qubits in $ .^3P_0$ remain dark.
  #align(center)[
  #image("physics.png", width: 50%)
]
  
  // #callout(
  //   "Decoder consequence",
  //   [A click identifies *where* the fault happened (erasure map). This is different from merely lowering the physical error probability $p$.],
  //   color: good,
  // )
]



#slide("Question: what fraction of error become erasures?")[
  #v(-1.0em)
  #two_col(
    [
      #callout("Branching summary (proposal)", [~98% of relevant gate faults can be converted to erasures.], color: good)
      #v(0.4em)
      // - Dominant decay pathways land in states that are optically distinguishable from $Q$.
      // - A minority of faults remain “in-$Q$” → residual Pauli-like errors.
    ],
    [
      #block(inset: 0.65em, radius: 10pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Parameterizing conversion]
        #v(0.25em)
        Let $p_e$ = detected errors (erasures), 
        
        $p_p$ = undetected errors (Pauli-like in Q-space).
        #v(0.35em)
        #callout("Definition", [$R_e = p_e / (p_e + p_p)$], color: accent)
      ]
    ],
  )
]

#slide("Possible error sources")[
  #v(-1.0em)
  #two_col(
    [
      #align(center)[
      #image("errorsource.png", height: 4.5cm)
      #v(-1.5em)
      #image("errate.png", height: 7.5cm)
      ]
    ],
    [
      #block(inset: 0.65em, radius: 10pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Three outcomes in the proposal]
        #v(-0.3em)
        - $Q$: metastable qubit manifold (dark to detection light)
        - $R$: ground manifold (bright under fluorescence)
        - $B$: Rydberg state (autoionization and convert to $"Yb"^+$ and detect ion via fluorescence)
      ]
    ],
    gap: 1.0cm,
  )
]

// ---------------------------------------------------------------------------
// 3) Where faults come from and why they become erasures
// ---------------------------------------------------------------------------

// #section("3. Error mechanism", subtitle: "Rydberg decay becomes a flagged event")

// #slide("Two-qubit gates: temporary Rydberg excitation is the intrinsic risk")[
//   - Neutral-atom entangling gates excite population to a Rydberg state.
//   - Finite Rydberg lifetime → decay during the gate is unavoidable.
//   #v(0.6em)
//   #callout("Core leverage", [If decay typically leaves $Q$, we can detect it and record an erasure.], color: good)
// ]

// ---------------------------------------------------------------------------
// 4) Protocol: when and how you detect
// ---------------------------------------------------------------------------

#section("3. Protocol", subtitle: "Measure leakage after each gate layer")

#slide("XZZX surface code")[
  #v(-1.0em)
  #two_col(
    [
      #align(center)[
        #image("XZZX.png", width: 90%)
        XZZX surface code
        ]
    ],
    [
      #block(inset: 0.65em, radius: 10pt, fill: luma(252), stroke: 1pt + luma(220))[
        #text(size: 16pt, weight: "bold", fill: luma(60))[Parameterizing conversion]
        #v(-0.25em)
        Assume errors only in two-qubit gates:

        Pauli error with probability $p_p$
        Erasure error with probability $p_e$.
        #v(-0.35em)
        #callout("Erasure fraction", [$R_e = p_e / (p_e + p_p)$], color: accent)
      ]
    ],
  )
]

#slide("XZZX Surface code")[

  #callout("Key idea", [XZZX is a robust, simulation-friendly baseline for mixed noise + erasure, and pairs naturally with fast decoders.], color: good)


  #block(inset: 0.65em, radius: 10pt, fill: luma(252), stroke: 1pt + luma(220))[
    1. *Robust across noise types:* a “safe baseline” under mixed/unknown noise.
    2. XZZX integrates cleanly with a fast circuit-level decoder.
    3. XZZX is well-suited when the Pauli type is uncertain (X/Z mixture).
  ]
  #v(0.6em)
  
]

#slide("Circuit-level integration")[
  #v(-1.0em)
  #align(center)[
        #image("circuits.png", width: 68%)
        ]
]
#slide("How is an erasure event represented in the circuit simulation?")[
  Erasure = “location known, Pauli type unknown.”

  #v(0.6em)
  #callout("State model used in the simulator", [The erased qubit(s) are treated as being *replaced by a fresh qubit* in a maximally mixed state
→ equivalently, a *uniformly random Pauli* is applied (type unknown), but the location is known.], color: good)
]


// #slide("Main target")[
//   #block(inset: 0.65em, radius: 10pt, fill: luma(252), stroke: 1pt + luma(220))[
//     If we can convert most gate errors into erasures, how much did threshold improve in surface-code simulations?
//   ]
//   #v(0.6em)
//   #callout("Circuit-level QEC simulation", [
//     - Inject errors into the gate-level syndrome-extraction circuit
//     - Run repeated stabilizer measurement rounds → detection events
//     - Decode using the measured syndrome plus erasure locations (if available)], color: good)
//   #v(0.35em)
  
//   #v(0.15em)
//   #text(size: 12pt, fill: luma(110))[Error outcomes and how they map to erasures vs undetected faults (schematic).]
// #align(center)[
//   #figure(
//   image("threshold.png", width: 47%),
//   caption: [Numerical simulations using union find decoder.],
//   )
// ]
// ]





// #slide("What the decoder gets: a mixed erasure + Pauli noise model")[
//   - With probability $p_e = p R_e$: an erasure at known location.
//   - With probability $p_p = p (1 - R_e)$: an undetected Pauli-type error.
//   #v(0.5em)
//   #callout("Interpretation", [Performance improves as $R_e$ increases because the residual ambiguous component shrinks.], color: accent)

//   #align(center)[
//   #image("errrate.png", width: 90%)
//   ]
// ]


// ---------------------------------------------------------------------------
// 5) QEC results claimed in the proposal
// ---------------------------------------------------------------------------

#section("4. QEC evidence", subtitle: "Threshold and scaling benefits")

#slide("Main quantitative result: threshold jump")[
#v(-1.0em)
  #block(inset: 0.65em, radius: 10pt, fill: luma(252), stroke: 1pt + luma(220))[
    If we can convert most gate errors into erasures, how much did threshold improve in surface-code simulations?
  ]
#v(-0.5em)
  #grid(columns: (1fr, 1fr), gutter: 0.8cm)[
    #keynum("Baseline (Pauli)", [0.937%], note: "surface-code threshold in proposal", color: bad)
  ][
    #keynum("With erasure conversion", [4.15%], note: [$R_e ≈ 0.98$], color: good)
  ]
  #v(-0.6em)
  #callout("Claimed implication", [Gate error rates in the ~0.5–1% range move from “borderline” to “comfortably below threshold”.], color: accent)

  
  #align(center)[
  #figure(
  image("threshold.png", width: 59%),
  caption: [Numerical simulations using union find decoder.],
  )


  #callout("Interpretation", [Performance improves as $R_e$ increases because the residual ambiguous component shrinks.], color: accent)

  #image("threshold2.png", width: 47%)
]


]




#slide("Why scaling improves: effective distance is preserved when locations are known")[
  - For unknown-location Pauli faults, the code corrects up to ~$(d-1)/2$ faults (heuristic).
  - For erasures (known locations), the code can tolerate up to $d-1$ erasures (heuristic).
  #v(0.6em)
  #callout("Practical takeaway", [At fixed device size, conversion can yield lower logical error by steepening the logical-vs-physical scaling.], color: good)

  #image("erasure1.png", width: 99%)
]

#section("Conclusion", subtitle: "Claim, requirements, next steps")

#slide("Take-home messages")[
  - *Claim:* Converting dominant gate faults into *flagged erasures* simplifies decoding and can substantially raise surface-code thresholds (as quoted earlier in the deck).
  - *Requirement:* The benefit depends on *fast, high-fidelity leakage/loss detection* with low back-action and low latency (to keep the erasure fraction high).
  #v(-0.6em)
  #callout(
    "Bottom line",
    [Erasure information acts like a hardware-side channel that can trade detection overhead for much larger fault-tolerance margins.],
    color: good,
  )
]

// #slide("Magic-state distillation: why erasures are especially valuable")[
//   - Distillation overhead dominates many FTQC resource estimates.
//   - With erasure flags, protocols can *reject* flagged bad states early.
//   #v(0.6em)
//   #callout("Proposal claim", [With ~98% conversion, raw magic-state infidelity can improve by > an order of magnitude (by post-selection / rejection of flagged faults).], color: accent)
// ]

// ---------------------------------------------------------------------------
// 6) Strategic implications and critique
// ---------------------------------------------------------------------------

// #section("6. Practicalities & critique", subtitle: "What must be true for $R_e$ to stay high")

// #slide("Central experimental requirement: fast, high-fidelity leakage detection")[
//   - Need reliable classification of “in $Q$” vs “not in $Q$”.
//   - Missed detection: turns an erasure into an unknown error.
//   - False detection: creates unnecessary holes/erasures.
//   #v(0.6em)
//   #callout("Risk", [If technical in-$Q$ noise dominates (laser noise, crosstalk, imperfect blockade), $R_e$ drops and the benefit shrinks.], color: warn)
// ]

// #slide("Failure modes that can reduce the advantage")[
//   - In-subspace dephasing/amplitude errors that do not leak.
//   - Imperfect QND-ness: detection light inadvertently perturbs $Q$.
//   - Latency: erasure information must arrive in time for decoding/control.
//   - Correlations: multi-qubit correlated faults may not look like independent erasures.
// ]

// #slide("What I would want to see in a follow-up (discussion prompts)")[
//   - End-to-end demo: repeated gate layers + interleaved leakage detection + real-time erasure-aware decoding.
//   - Sensitivity curves: threshold vs detection fidelity (miss/false rates) and vs technical-noise fraction.
//   - Trade-off accounting: added detection time/complexity vs reduced overhead.
//   - Decoder comparisons: MWPM vs Union-Find vs modern decoders for mixed noise.
// ]

// // ---------------------------------------------------------------------------
// // 7) Wrap-up
// // ---------------------------------------------------------------------------

// #section("7. Wrap-up", subtitle: "The message to remember")

// #slide("In fault-tolerant error correction protocol")[
//   #callout("Neutral-atom array", [Mainly composed of Rb and Cs atoms], color: accent)
//   #v(0.6em)
//   - Decay error: mainly back to ground state manifold which can be regarded as pauli error 
//   - The atom loss can be detected by fluorescence and regarded as erasure error. 
//   - three dominant leakage types for alkali atoms: loss, leakage to other ground hyperfine states, and leakage to Rydberg states, and notes hyperfine leakage may be off-resonant (loss-like) at large B—but not directly detected by loss detection.
// ]

#slide("References")[
  #set text(size: 18pt)
  #v(-1.4em)
  #bibliography("Erasure_Conversion_refs.bib")
]
