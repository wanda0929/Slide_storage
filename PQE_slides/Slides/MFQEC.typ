
#import "@preview/touying:0.6.1": *
#import "lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/unequivocal-ams:0.1.2": ams-article, theorem, proof
#import "@preview/cetz:0.3.2": canvas, draw

#set text(black, font: "New Computer Modern")
#let colors = (maroon, olive, eastern)
// 定义字体颜色
#let primary-color = rgb("#1f77b4")  // 蓝色
#let error-color = rgb("#d62728")  // 红色
// 定义颜色辅助函数
#let blue-text(content) = text(fill: primary-color, content)
#let red-text(content) = text(fill: error-color, content)
#let dark-blue = rgb("#1a365d")
#let accent-gold = rgb("#b8860b")
#let data-blue = rgb("#3b82f6")

#let dark-blue = rgb("#1a365d")
#let accent-blue = rgb("#2563eb")
#let accent-gold = rgb("#ac7c01")
#let light-gold = rgb("#d4a84b")
#let bg-color = rgb("#f5f5f0")
#let data-blue = rgb("#3b82f6")
#let ancilla-green = rgb("#22c55e")
#let ancilla-red = rgb("#ef4444")
#let gate-green = rgb("#4ade80")
#let gate-blue = rgb("#60a5fa")
#let gate-yellow = rgb("#d9d02e")
#let gate-orange = rgb("#fb923c")
#let gate-red = rgb("#f87171")
#let gate-purple = rgb("#a78bfa")
#let gate-gray = rgb("#9ca3af")
#let gate-black = rgb("#030304")


// Specify `lang` and `font` for the theme if needed.
#show: hkustgz-theme.with(
  // lang: "zh",
  // font: (
  //   (
  //     name: "Linux Libertine",
  //     covers: "latin-in-cjk",
  //   ),
  //   "Source Han Sans SC",
  //   "Source Han Sans",
  // ),
  config-info(
    title: [Optical Control of Rydberg Atom Array],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)




#page[
  #v(0.3in)
  #align(center)[
    #text(size: 41pt, weight: "bold", fill: primary-color)[
      Optical Control of Rydberg Atom Array
    ]
    #v(0.1in)
    #text(size: 30pt, weight: "bold", fill: accent-gold)[
      A Measurement-Free and Movement-Free \ Error Correction Protocol \
      Using Multi-Species Atoms and Global Control
    ]
    #v(0.1in)
    #text(size: 16pt)[
      Han Wang
    ]
    #v(0.1in)
    #text(size: 16pt)[
      HKUST(GZ)
    ]
    #v(0.1in)
    #text(size: 16pt)[
      #datetime.today().display()
    ]
    #v(-0.4in)
  ]
]

#outline-slide()

// Extract methods
= Summary of Works
== Main works
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Large-scale Atom Array Generation]
    
    -- Using Spatial Light Modulator (SLM) with automatic differentiation-based method (AD) @6hs1-4gkw for flexible adjustment.
    
    #text(weight: "bold", fill: primary-color)[Measurement-free and Movement-free QEC Protocol]
    
    -- #text(fill:error-color)[Movement & measurement-free] quantum error correction protocol in Rydberg atom platform with #text(fill:error-color)[global pulse sequence].
  ],
  [
    
    #figure(
      image("3D_model.pdf", width: 90%),
      )
  ],
)
#show strong: alert

= Hardware: Neutral atom platform
// == Platforms for quantum computing and simulation
// #figure(
//   image("platform.png", width: 100%),
// )
// - Atoms in optical lattice and cavity
// - Array of trapped ions
// - Superconducting qubits
// - Neutral atoms in optical tweezer arrays
// - Quantum dots
// 

== What is neutral atoms
#text(weight: "bold")[Core concepts:  ]Using individual atoms (typically Rubidium or Cesium) as qubits.
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    // #text(weight: "bold", fill: primary-color)[Mechanism: ]


    #text(weight: "bold")[Trapping: ]"Optical tweezers" (highly focused laser beams) hold atoms in place.

    #text(weight: "bold")[ Isolation:]vacuum chamber, isolated from environmental noise.
    #figure(
      image("SLM.pdf", width: 64%),
      caption: [The optical setup for hologram generation. @6hs1-4gkw]
      )
      
     
  ],
  [
    #text(weight: "bold")[Generating spot arrays ] #text( size:18pt)[Using spatial light modulator (SLM) to create configurable arrays of optical tweezers.]

   #figure(
      image("Array_generation_figure.pdf", width: 94%),
      caption: [Optical tweezer array generation using SLM. @Ma2025Scaling@Labuhn2016Direct]
      ) <fig-pdf>
    // #text(weight: "bold", size:18pt)[Main tools:] #text( size:18pt)[The Spatial Light Modulator (SLM), a programmable diffractive element, imprints a phase profile $phi(x,y)$ onto the laser beam.]
  ],
)
#show strong: alert

== How it works: the Rydberg state
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold")[The Qubit States:]
    Information is stored in the atom's internal energy levels ($|0 angle.r$ , $|1 angle.r$).
    #v(0.8in)
    #text(weight: "bold")[The Interaction:] To make qubits "talk" to each other, we excite them to a Rydberg State because of the Rydberg blockade effect.
    

    
      
     
  ],
  [

    #figure(
      image("blockade.png", width: 99%),
      caption: [Rydberg blockade effect between two atoms @cocchiarella2022multi]
      )
  ],
)
#show strong: alert
// - #text(weight: "bold")[Main tools:] The Spatial Light Modulator (SLM), a programmable diffractive element, imprints a phase profile $phi(x,y)$ onto the laser beam.

== Why neutral atoms?
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
     #text(weight: "bold", fill: primary-color)[ 1. Strong, Tunable Interactions@RevModPhys.82.2313]

 #text(weight: "bold", fill: primary-color)[ 2. Long Coherence Times:] #text(weight: "bold", size: 18pt)[ Neutral atom platform:] #text(size: 18pt)[12.6 s @Scholl2024]
    
    #text(weight: "bold", size: 18pt)[Superconducting qubits:] #text(size: 18pt)[  1.68 ms @Princeton2025]
  
#figure(
  text(size: 16pt)[
    #table(
      columns: (auto, auto),
      align: (left, right),
      stroke: none,
      inset: (x: 1em, y: 0.4em),
      table.hline(stroke: 1pt),
      [Imaging survival\*], [0.9998952(1)],
      table.hline(stroke: 0.5pt),
      [Imaging fidelity\*], [0.9999374(8)],
      table.hline(stroke: 0.5pt),
      [Vacuum lifetime], [22.9(1) min],
      table.hline(stroke: 0.5pt),
      table.cell(fill: gate-yellow.lighten(70%))[Coherence time ($T_2$)], table.cell(fill: gate-yellow.lighten(70%))[12.6(1) s],
      table.hline(stroke: 0.5pt),
      [Global single-qubit \ gate fidelity], [0.999834(2)],
      table.hline(stroke: 1pt),
    )
  ],
  caption: [Data source of 6100-atom array @Scholl2024],
)
],
  [
    #text(weight: "bold", fill: primary-color)[3. High Gate Fidelity: ]
 #figure(
  text(size: 15pt)[
      #table(
        columns: (auto, auto, auto),
        align: (left, center, left),
        stroke: none,
        inset: (x: 0.9em, y: 0.5em),
        table.hline(stroke: 1pt),
       [Platform], [Fidelity], [Ref],
        table.hline(stroke: 0.5pt),
        table.cell(fill: gate-yellow.lighten(70%))[Neutral atoms], table.cell(fill: gate-yellow.lighten(70%))[99.5%], table.cell(fill: gate-yellow.lighten(70%))[60 atoms parallel gate@Evered2023_Fidelity],
        table.hline(stroke: 0.5pt),
        table.cell(fill: gate-yellow.lighten(70%))[Neutral atoms], table.cell(fill: gate-yellow.lighten(70%))[99.9%], table.cell(fill: gate-yellow.lighten(70%))[single-pair gate @Tsai2025_Neutral],
        table.hline(stroke: 0.5pt),
        [Superconducting], [99.93%], [@Marxer2025_SC],
        table.hline(stroke: 0.5pt),
        [Trapped ions], [99.99%], [@IonQ_FourNines_2025],
        table.hline(stroke: 1pt),
      )
  ],
  caption: [Gate fidelity comparison across platforms]
    )
-- #text( size: 16pt)[Surpassed #text(weight: "bold", size: 16pt)[99% threshold], the critical requirement for surface code error correction @PhysRevA.86.032324.]

-- #text(weight: "bold", size: 16pt)[Exponential Improvement:] #text( size: 16pt)[from ~90% in 2018 @PhysRevLett.121.123603 to >99.5% in 2024 @Evered2023HighFidelity@Bluvstein2024Logical.]
  ],)
#show strong: alert

== Why neutral atoms?

#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [

    #text(weight: "bold", fill: primary-color)[4. Exceptional Scalability:]#text(weight: "bold", size: 18pt)[Neutral atom platform:]#text(size: 18pt,weight: "bold", fill: gate-red)[ 6,100]-Qubit Milestone of Cesium atoms@Scholl2024 with 99.98% imaging survival.

    #text(weight: "bold", size: 18pt)[Superconducting qubits:] #text(size: 18pt,weight: "bold", fill: gate-red)[ 1121] physical qubits @IBM_Condor_2024

    #text(weight: "bold", size: 18pt)[Trapped ions:] #text(size: 18pt,weight: "bold", fill: gate-red)[ $~$32 - 56] physical qubits @IonQ_EQC_2025
    
    // -- Qubit coherence can surpass one second, significantly longer than many competing platforms.@f8xg-w57m@semião2025resonatorassistedquantumtransductionsuperconducting
    //   image("large_array.png", width: 50%),
// )
     
  ],
  [
    #figure(
      image("large_array.png", width: 100%),
      caption: [Representative single-shot and rearranged image of single cesium atoms across a 11,998-site tweezer array. Inset: magnified view of a subsection of the stochastically loaded array @Scholl2024]
      )
  ],
)
#show strong: alert

// == Advantage of neutral-atom array platform
// #text(weight: "bold", fill: primary-color)[3. High Gate Fidelity: ]
//  #figure(
//       table(
//         columns: (auto, auto, auto),
//         align: (left, center, left),
//         stroke: none,
//         inset: (x: 0.9em, y: 0.5em),
//         table.hline(stroke: 1pt),
//        [Platform], [Fidelity], [Ref],
//         table.hline(stroke: 0.5pt),
//         table.cell(fill: gate-yellow.lighten(70%))[Neutral atoms], table.cell(fill: gate-yellow.lighten(70%))[99.5%], table.cell(fill: gate-yellow.lighten(70%))[60 atoms parallel gate@Evered2023_Fidelity],
//         table.hline(stroke: 0.5pt),
//         table.cell(fill: gate-yellow.lighten(70%))[Neutral atoms], table.cell(fill: gate-yellow.lighten(70%))[99.9%], table.cell(fill: gate-yellow.lighten(70%))[single-pair gate @Tsai2025_Neutral],
//         table.hline(stroke: 0.5pt),
//         [Superconducting], [99.93%], [@Marxer2025_SC],
//         table.hline(stroke: 0.5pt),
//         [Trapped ions], [99.99%], [@IonQ_FourNines_2025],
//         table.hline(stroke: 1pt),
//       ),
//     )
// -- Surpassed #text(weight: "bold", size: 18pt)[99% threshold], the critical requirement for surface code error correction @PhysRevA.86.032324.

// -- #text(weight: "bold", size: 18pt)[Exponential Improvement:] from ~90% in 2018 @PhysRevLett.121.123603 to >99.5% in 2024 @Evered2023HighFidelity@Bluvstein2024Logical.
//     == Advantage of neutral-atom array platform
// #grid(
//   columns: (1fr, 1fr),
//   gutter: 1em,
//   [
    
    
//     #text(weight: "bold", fill: primary-color)[4. Strong, Tunable Interactions@RevModPhys.82.2313]

//     #text(weight: "bold", size: 18pt)[Neutral atoms:] #text(size: 18pt)[Long-range ($R~10mu$m) with Van der Vaals and Dipole-dipole interactions@Evered2023]

//     $ V_"dd" = C_3 \/ R^3 $ 
//      $ V_"vdW" = C_6 \/ R^6 $

//     #text(weight: "bold", size: 18pt)[Superconducting qubits:] #text(size: 18pt)[Nearest-neighbor only@Stehlik2021]

//     #text(weight: "bold", size: 18pt)[Trapped ions:] #text(size: 18pt)[Coulomb Interaction, hard to adjust@Bruzewicz2019]
//   ],
//   [
   
    

//     #figure(
//       image("interaction.png", width: 110%),
//       caption: [Two-body interaction strength for
// ground-state Rb atoms, Rb atoms excited to the 100s level,
// and ions. @Saffman2010Quantum]
//     )
//   ],
// )


== Quantum error correction
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Code space, redundancy, syndrome, error correction.: ]
#align(center, canvas(length:0.82cm, {
  import draw: *
  let s(it) = text(it, 16pt)
  content((3.5, 4.5), s[Physical space])
  circle((0, 0), radius: (3, 5))
  circle((0, 3), radius: 0.1, fill: black, stroke: none, name: "A")
  circle((0, -3), radius: 0.1, fill: black, stroke: none, name: "B")
  content((rel: (0, -1), to: "B"), s[Code space])
  content((rel: (0.6, 0), to: "A"), s[$|overline(0)angle.r$])
  content((rel: (0.6, 0), to: "B"), s[$|overline(1)angle.r$])
  line((-4, 0), (4, 0), stroke: (dash: "dashed"))
  let p0 = (anchor: 150deg, name: "B")
  let p1 = (rel: (-1.8, 1), to: "B")
  let p2 = (rel: (-1.5, 1.8), to: "B")
  line(p0, p1, mark: (end: "straight"), stroke: red)
  line(p1, p2, mark: (end: "straight"), stroke: red)
  line(p2, p0, mark: (end: "straight"), stroke: blue)
  content((-2.3, -0.7), text(blue, s[QEC algorithm //$arrow.r$ Hamiltonian?
  ]))
  content((-3.6, -2), text(red, s[Pauli error]))
  circle(p1, radius: 0.1, fill: red, stroke: none)
  circle(p2, radius: 0.1, fill: red, stroke: none)
  line("A", "B", mark: (end: "straight", start: "straight"))
  content((2.5, 1), s[Code distance: $d$])
}))
// - #text(size: 18pt)[]
     
  ],
  [
    #text(weight: "bold", fill: primary-color)[Toric Code Hamiltonian:]
$ H = -sum_s S_s - sum_p P_p $
where $S_s = product_(i in s)Z_i, P_p=product_(j in p) X_j $
#figure(
  image("toriccode.png", width: 120%),
)
- Perform on rotated code lattice.
  ],
)
#show strong: alert
// == Bottleneck: Collisional blockaded effect 
// #grid(
//   columns:(1fr, 1fr),
//   gutter: 1em,
//   [
//     #text(weight: "bold", fill: primary-color)[Preparation and operation latency: ]
    
//     #text(weight: "bold", size: 18pt )[Collisional blockaded effect:] #text(size: 18pt)[(50% loading efficiency)@Fung_2015.] 
//     #figure(
//       image("collisional_blockade.png", width: 80%),
//       )
    
//     -- #text(size: 18pt)[Requiring #text(weight: "bold", size: 18pt )[rearrangement] with fast, flexible dynamic control and least computation cost @aah3752.] 
//   ],
//   [
//     #text(weight: "bold", fill: primary-color)[Dynamic Array Generation via AD]
    
//     #text(weight: "bold", size: 18pt)[Algorithm for hologram calculation:] 
//     #figure(
//        image("ad_evolve.png", width: 86%),
//        )
//     -- #text(size: 18pt)[high efficiency, better explainability and better numerical stability.] 
//   ],
// )
// #show strong: alert

== Quantum Error Correction (QEC) on neutral atom array platform

// Timeline labels
#v(0.1in)
  #grid(
    columns: (1fr, 2fr, 3fr),
    gutter: 0.2in,
    align(left)[
      #text(weight: "bold", fill: accent-gold, size: 20pt)[Gate Operation\ ($~ 1mu s$)]
    ],
    align(center)[
      #text(weight: "bold", size: 24pt, fill: dark-blue,)[(Arrow shows the time scale)]
    ],
    align(center)[
      #text(weight: "bold", size: 23pt)[Measurement & movement \ ($~$ hundreds of $mu s$)]
    ]
  )
  // Draw timeline arrow
  #canvas(length: 1cm, {
    import draw: *
    
    let arrow-height = 2
    let total-width = 26
    
    // Yellow segment (gate operation)
    rect((0, 0), (0.8, arrow-height), fill: accent-gold, stroke: none)
    
    // Blue segment (main process) with arrow head
    rect((1.0, 0), (total-width - 3, arrow-height), fill: dark-blue, stroke: none)

    // Blue segment (main process) with arrow head
    rect((16.3, 0), (total-width - 3, arrow-height), fill: gate-black, stroke: none)
    
    // Lightning bolt symbol in the middle
    let bolt-x = 16
    let bolt-y = arrow-height / 2
    line((bolt-x +1, bolt-y + 1.5), (bolt-x - 0.3, bolt-y), stroke: (paint: white, thickness: 8pt))
    line((bolt-x - 0.41, bolt-y), (bolt-x + 0.6 + 0.2, bolt-y), stroke: (paint: white, thickness: 8pt))
    line((bolt-x + 0.7, bolt-y), (bolt-x - 1.1, bolt-y - 2.1), stroke: (paint: white, thickness: 8pt))
    
    // Arrow head
    line((total-width - 3, arrow-height), (total-width, arrow-height / 2), stroke: (paint: gate-black, thickness: 0pt))
    line((total-width - 3, 0), (total-width, arrow-height / 2), stroke: (paint: gate-black, thickness: 0pt))
    // Fill arrow head
    let pts = ((total-width - 3, -0.5), (total-width - 3, arrow-height+0.5), (total-width, arrow-height/2))
    line(..pts, close: true, fill: gate-black, stroke: none)
  })
  #v(-0.4in)
  #grid(
    columns: (1fr, 2fr),
    gutter: 0.5in,
    [
      #text(size: 19pt, weight: "bold")[Quantum Gates:]
      #text(size: 19pt)[Operations are incredibly fast, taking approximately #text(weight: "bold" , fill: gate-red)[1 $mu s$.]]
    ],
    [
      #text(size: 19pt, weight: "bold")[Correction:] #text(size: 19pt)[Conventional QEC requires operations that are dramatically slower:@Bluvstein_2023@Graham_2023]
      #list(
        marker: text(size: 19pt)[#sym.bullet],
        text(size: 19pt, fill: gate-red)[Mid-circuit Measurement: ~100--500 #sym.mu\s (fluorescence detection)],
        text(size: 19pt, fill: gate-red)[Atom Shuttling/Movement: ~10--100 #sym.mu\s. @Bluvstein_2022@Norcia_2023]
      )
    ]
  )

  #text(size: 19pt, weight: "bold")[Consequence:] #text(size: 19pt)[The quantum state decoheres for long operation times]

== Question
#text(weight: "bold", size: 22pt)[Can we design a QEC protocol that eliminates both measurement and movement, using only fast, global pulse sequence?]
#figure(
  image("toriccode.png", width: 90%),
)

#text(weight: "bold", size: 22pt)[ ]

= Error Correction Protocol
== Measurement-free and movement-free QEC protocol@Bluvstein2024_Nature
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#figure(
  image("QEC_withmeasure.pdf", width: 86%),
  caption: [Schematic of the logical processor, split into three zones:\ storage, entangling and readout (see Extended Data@Saffman2010Quantum]
)
// == Measurement-free and movement-free QEC protocol
// #text(size: 25pt, weight: "bold")[Measurement-Free:] #text(size: 22pt)[Replaces slow, destructive fluorescence
// measurements with fully coherent operations. Syndrome
// information is mapped to ancilla qubits, which then trigger
// corrective gates without classical feedback..]

// #text(size: 25pt, weight: "bold")[Movement-Free:] #text(size: 22pt)[Eliminates the need for atom shuttling. The atoms remain in a static lattice, and all interactions are mediated by precisely shaped, global laser pulses.]
// #v(0.4in)
// #text(size: 30pt, weight: "bold", fill: accent-gold)[Key Insight:] #text(size: 22pt)[By executing the entire QEC cycle -- syndrome mapping, error correction, and ancilla reset -- unitarily, we remove the primary sources of latency and decoherence.]


== Measurement-free and movement-free error correction model

#grid(
  columns:(1.5fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Static, three species Rydberg atom array (Toric code space): ]

    #text(weight: "bold",size: 18pt)[Data Qubits (Species D):]
    #text(size: 18pt)[Encode the logical information, located at the vertices of a square lattice.]

    #text(weight: "bold",size: 18pt)[Ancilla Qubits (Species A1): ]
    #text(size: 18pt)[Used to detect Z-type errors, located at the centers of the 'X-stabilizer']

    #text(weight: "bold",size: 18pt)[Ancilla Qubits (Species A2): ]
    #text(size: 18pt)[Used to detect X-type errors, located at the centers of the 'Z-stabilizer']

    #text(weight: "bold",size: 18pt)[Species-Selective Control: ]
    #text(size: 18pt)[The distinct atomic species have well-separated transition frequencies, allowing global laser pulses to address one species without affecting the others.]
  ],
  [
    #figure(
      image("Figure_1_modify.pdf", width: 77%),
      )
  ],
)
#show strong: alert

== Measurement-free and movement-free error correction model
#text(weight: "bold",size: 20pt)[The full cycle for one error type is
executed in three main phases:]

• #text(weight: "bold",size: 20pt)[Error Check:] Information mapping, data qubits $->$ ancilla qubits.

• #text(weight: "bold",size: 20pt)[Error Corection:] The ancillas controls the data qubits with conditional flip

• #text(weight: "bold",size: 20pt)[Reset:] The ancillas are reset to $|0 angle.r$ to prepare for the next cycle. 
#figure(
  image("rubustsequence.pdf", width: 71%),
)

== Movement-free error-check process
#grid(
  columns:(1fr, 1.5fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Single plaquette situation: ]
    
    #figure(
  image("stabilizer_circuit.pdf", width: 106%),
)
  ],
  [
    #text(weight: "bold", fill: primary-color)[Global pulse sequence:]
    
    • #text(weight: "bold",size: 20pt)[Implementation Constraint:] #text(size: 18pt)[data qubit is controlled by 2 neighboring ancilla qubits simultaneously.]
    #figure(
      image("circuits_for_paritycheck_err.pdf", width: 96%),
      )
  ],
)
#show strong: alert

== Movement-free error-check process
#figure(
      image("circuits_for_paritycheck_som.pdf", width: 75%),
      )
- #text(weight: "bold",size: 20pt)[Solution:] Add a double-controlled NOT (CCNOT) gate followed by OR-gate in the global pulse sequence to solve the above conflict.

// == Measurement-free and movement-free error correction model
// #figure(
//   image("model5.png", width: 62%),
// )
// - #text(weight: "bold",size: 20pt)[Solution:] Add a double-controlled NOT (CCNOT) gate in the global pulse sequence to solve the above conflict.

== Pulse sequence design:
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[OR-gate design: ]
    #figure(
      image("OR-gate.pdf", width: 83%),
      )

  ],
  [
    #text(weight: "bold", fill: primary-color)[$C_2$NOT-gate design: ]
    #figure(
      image("CCNOT.pdf", width: 83%),
      )
  ],
)
#show strong: alert
- The Rydberg interaction $V_"dd" >> V_"Vdws"$


= Numerical Methods for Simulation 
== Unit cell tests under pulse-level simulation
#grid(
  columns:(1fr, 1.5fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Unit cell: ]
    #figure(
      image("unitcell.pdf", width: 70%),
      )
  #text(weight:"bold", size: 18pt)[Red colored atoms:] #text(size: 16pt)[Ancilla qubits for X-error check.]

  #text(weight:"bold", size: 18pt)[Blue colored atoms:] #text(size: 16pt)[Data qubits.]

  ],
  [
    #text(weight: "bold", fill: primary-color)[Pulse sequence: ]
    #figure(
      image("fig_laser_Gaussian.svg", width: 90%),
      )
  ],
)
#show strong: alert

== Unit cell tests under pulse-level simulation
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    // #text(weight: "bold", fill: primary-color)[No-error condition: ]
    #figure(
      image("fig_combined1.svg", width: 69%),
      )

  ],
  [
    // #text(weight: "bold", fill: primary-color)[Errored condition: ]
    #figure(
      image("fig_combined3.svg", width: 69%),
      )
  ],
)
#show strong: alert
- #text(weight: "bold")[Fidelity:] Simulations confirm individual operation fidelities exceeding 99.8%
// , limited primarily by non-adiabatic effects
// == Simulation results for X-error parity check--single error
// - $|00000 angle.r -> |00000 angle.r$, Fidelity = 0.9979
// - $|10000 angle.r -> |10100 angle.r$, Fidelity = 0.9979
// - $|01011 angle.r -> |01111 angle.r$, Fidelity = 0.9989
// - $|11011 angle.r -> |11011 angle.r$, Fidelity = 0.9996

== Bottlenecks in pulse-level simulation
#text(weight: "bold")[Scalability bottleneck:] 

Exponential growth of Hilbert space size with increasing atom number.

#text(weight: "bold")[Solutions:] 

Tensor Networks (Matrix Product States, MPS):

-- Efficiently represent the quantum state, .

-- Accurately captures the system's
entanglement structure.

-- Allow for
simulations of larger arrays.
// - Using SLM to generate large-scale neutral atom array with automatic differentiation-based method for flexible adjustment of tweezer locations.
// - Generating an optical tweezer arrays that change smoothly over time with SLM via automatic differentiation-based strategy.

// - Designing measurement-free and movement-free quantum error correction protocol in Rydberg atom array platform.

// first slide: overview, 听完报告能得到什么 I this work， I will present two works. 第一个工作一张slide带过，第二个工作多讲一些细节。第一个slide表述我的工作内容，第一个第二个，其中第二个工作要主要讲解。着重介绍关于Rydberg pulse design in QEC。Rydberg atom array 在Rydberg atom pulse design当中有什么意义。为什么用pulse design，什么事pulse design。问题定义完整，前人的工作review完整。
//什么是hologram generation，为什么要做这个东西，这在tweezer array generation当中有什么用，把背景部分阐述清楚。
// 问题展示清楚，背景展示清楚，数据有逻辑性的罗列清楚 Rydberg atoms近期发展，先说做了什么，为什么error correction。error correction的必要性。
// 为什么关注neutral atom array平台，那么我们要去产生这个large scale tweezer array，（提一下最近的Lukin等的工作）

//SLM 生成大规模阵列的时候要防止未散射的零级光的干扰。这个时候需要spatial filter来阻挡零级光。这就不可避免的占用物理空间导致阵列当中存在间隙，1055的激光就是用于填充间隙而设计的。


// #figure(
//   image("large_array.png", width: 50%),
// )
// == Requirement of large-scale neutral atom array
// - Quantum simulation of many-body phases and dynamics. 
// == Requirement of large-scale neutral atom array
// - Reliable quantum computer building requires correction codes implementation.

// -- The Overhead: A single logical qubit with sufficient fault tolerance may require hundreds to thousands of physical qubits.
// #figure(
//   image("Logical qubit.png", width: 50%),
// )

// -- The Goal: We need arrays scaling from $N approx 100$ (NISQ era) to $N > 10,000$ (Fault-Tolerant era)@Preskill_2018.
// #figure(
//   image("NISQ_.png", width: 60%),
// )

// - Many-Body Physics Simulation: Simulating complex quantum phases of matter (e.g., spin liquids) requires lattice sizes that exceed the capabilities of classical supercomputers ($N > 50-100$).

// - Connectivity: Large 2D and 3D arrays allow for nearest-neighbor interactions required for gate operations via Rydberg blockade.


// - Method of trapping atoms: We sculpt light using phase modulation. Generating optical tweezers($< 1 mu m$ spots) with highly focused laser beams that hold individual atoms.
// #figure(
//   image("difffract.png", width: 40%),
// )
// - Main tools: The Spatial Light Modulator (SLM), a programmable diffractive element, imprints a phase profile $phi(x,y)$ onto the laser beam.

// - Algorithm for hologram generation: Calculating the phase pattern $phi(x,y)$ to produce the desired intensity pattern at the focal plane.
// #figure(
//   image("array.png", width: 60%),
// )

// Hindered scalability: preparation and operation latency
// - Collisional blockaded effect: (50% loading efficiency)@Fung_2015. 
// #figure(
//   image("collisional_blockade.png", width: 60%),
// )

// == Requ irements for large-scale neutral atom array generation
// - Requiring rearrangement with fast, flexible dynamic control and least computation cost. 

// -- Previous works@aah3752: rearranging atoms with acousto-optic deflectors (AODs).

// #figure(
//   image("rearrange.png", width: 29%),
// )


// = Dynamic Array Generation //via Automatic Differentiation
// == Dynamic Array Generation via Automatic Differentiation
//相比之前的方法，AD-based method有以下优点，包括可以更加灵活的生成想要的阵列形状，可以更加高效的计算phase pattern，并且相对neural network-based method有更好的数值稳定性和可解释性。
// - high efficiency, better explainability and better numerical stability.
// #figure(
//   image("difffract.png", width: 55%),
// )
// == Dynamic Array Generation via Automatic Differentiation
// - Algorithm for calculating the the hologram displayed on SLM: 
// #figure(
//   image("ad_evolve.png", width: 60%),
// )
// knowing the locations of two continuous timesteps; calculating the hologram phase pattern of the previous timestep with C_WGS; calculating the velocity of the moving dots; calculating the phase-change velocity with AD(implicit differentiation); Evolve and update the phase dynamics.
// == Dynamic Array Generation via Automatic Differentiation
// - The AD-based method treats the phase-coordinate relationship as an analytic function
// == Critical bottlenecks in large array generation
// - After the preparation stage, movement and measurement of atoms during quantum operations is time-consuming: (hundreds of $mu$s)@Bluvstein_2023@Graham_2023.
// #figure(
//   image("timeconsuming.png", width: 60%),
// )
// == Measurement-free and movement-free protocol
// -- Using static atoms of two species and applying global pulse sequences for implementing @Anand2024. 
// #figure(
//   image("dualspecies.png", width: 60%),
// )


// == Quantum error correction and code space
// - Code space, redundancy, syndrome, error correction.
// #figure(
//   image("codespace.png", width: 30%),
// )
// == Toric code
// - Toric code Hamiltonian:
// $ H = -sum_s S_s - sum_p P_p $
// where $S_s = product_(i in s)Z_i, P_p=product_(j in p) X_j $
// #figure(
//   image("toriccode.png", width: 60%),
// )
// - Stabilizer:
// - Stabilized: Eigenvalue of all stabilizers is $+1$.

//== Necessity of quantum error correction
//- Example: Performing universal and large-scale quantum computation on neutral-atom array
//-- Required gate error rate for performing useful algorithms: $10^(-10)$.@Gidney_2021@reichardt2025faulttolerantquantumcomputationneutral

//-- Physical gate error rate: $10^(-3)$. @Gidney_2021@reichardt2025faulttolerantquantumcomputationneutral
//laser noise, atomic motion and Rydberg state decay
//atom loss.
// //These algorithms are incredibly fragile. A single bit-flip or phase-flip at the wrong time can cascade and ruin the entire computation. The only known way to run these algorithms is to use QEC to encode one perfect logical qubit into many noisy physical qubits, and constantly correct errors on the physical qubits to protect the logical information.

//Aquiring extreme low physical gate error rate and sufficiently many qubits for redundancy. 

//-- Quantum advantage will dissappear as system size grows. 

//-- Solution: Quantum error correction (QEC) process.@shor1997faulttolerantquantumcomputation@1996@Dennis_2002
//add a figure()
//== How to perform quantum error correction
// - QEC process and Toric code:@Khalifa2021Digital

// #figure(
//   image("toriccode.png", width: 60%),
// )

// #figure(
//   image("errorcorrection.png", width: 60%),
// )
//$ H = -sum_s S_s - sum_p P_p $
//where $S_s = product_(i in s)Z_i, P_p=product_(j in p) X_j $

// == Main problem
// - Measurement and feedback is time-consuming.
// (movement-100$mu$s@Bluvstein_2022@Bluvstein_2023; illuminating and collecting-500$mu$s@Norcia_2023@Graham_2023)
// #figure(
//    image("errorcorrection.png", width: 60%),
//    caption: [quantum error correction process @Khalifa2021Digital]
// )
// - Alternative: self-correcting quantum code(using Hamiltonian to confine to the ground state)@Yoshida_2011

// == Measurement-free scheme model
// - Measurement-free error correction scheme@Heu_en_2024: 
// #figure(
//   image("model2.png", width: 40%),
// )
//-- Encoding the logical qubit into multiple physical qubits.  
//-- Performing parity check process to extract the error syndrome.
//-- Correcting the error syndrome with a recovery process.
//- The parity check process can be performed with ancilla qubits as control qubits and data qubits as target qubits.
//- The recovery process can be performed with ancilla qubits as control qubits and data qubits as target qubits.


//== Quantum error correction in Rydberg atom platforms

//- Advantage of QEC in Rydberg atom platforms@Bluvstein_2023:

//-- Scalability

//-- Dynamic Reconfigurability therefore high connectivity.@cong2022hardwareefficientfaulttolerantquantumcomputation

//-- High gate fidelity (over 99.9%)@Evered_2023@Xue_2024 and long coherence time(> 1s)@Bluvstein_2023@ludmir2024modelingsimulatingrydbergatom@Wintersperger_2023.

//-- Long range Rydberg interaction enables flexiable qubit connectivity.

//-- Reconfigurable arrays allow implementing quantum error correction code in parallel.
//== Quantum error correction in Rydberg atom platforms
//- Bottlenecks:
//-- Time consuming Parity-check process @science.aah3752@Bluvstein_2022@Barredo_2018

//-- Long measurement time results in external error rate.@PhysRevA.92.042710

//-- Laser Complexity and Crosstalk.

// == Parity-check process is time consuming@Barredo_2018
// - Moving to entangling zone $=>$ Gate operation $=>$ Back to storage $=>$ Repeating.
// #figure(
//   image("flip.png", width: 50%),
// )
// - Movement is slow! The reported gate time is about 1$mu$s@Levine_2018 and the movement time is about hundreds of $mu$s.@Bluvstein_2022@Bluvstein_2023
//== Measurement process is time time-consuming
//- Moving the ancilla to readout zone (100$mu$s) $=>$ illuminating with focused imaging beam(500 $mu$s) $=>$ collect image

//- The long measurement time will result in external error rate.
//-- Solutions: 

//-- mid-circuit measurements@lis2023midcircuitoperationsusingomgarchitecture@Norcia_2023@Graham_2023

//-- atom cooling during detection@Saffman_2016

//-- measurement-free error correction.@Heu_en_2024@Perlin_2023


// == Measurement-free and movement-free error correction model
// - Toric code space with periodic boundary condition.
// - Neutral atom array with three different species: ancilla qubits(A1, A2) for Z/X-error check/correction and data qubits(D).
// #figure(
//   image("basic_array.png", width: 27%),
// )
//Three species, interaction strengths, 

//== Step1: Parity-check process
//- no error occurs $=>$ all qubits keep invariant after the effective pulse sequence.
//- X-error $=>$ neighboring ancilla qubit A1(green dots) will flip.
//- Z-error $=>$ neighboring ancilla qubit A2(red dots) will flip.

//#figure(
//  image("flip.png", width: 50%),
//)





// Solution: Modifying the pulse sequence to add a CCNOT gate with neighboring ancilla qubit as control qubit and data qubit as target qubit.






// == Designed pulse sequence for Z-error check
// - $"CNOT"_4$ gate implementation:
// #figure(
//   image("gate1.png", width: 50%),
// )
// - Control qubit in state $|1 angle.r$ $=>$ target qubit flip: $|0 angle.r$ $<=>$ $-|1 angle.r$.
// - Control qubit in state $|0 angle.r$ $=>$ target qubit keep invariant.

// == Designed pulse sequence
// - CCNOT gate implementation:
// #figure(
//   image("gate2.png", width: 50%),
// )
// - Control qubits in state $|1 angle.r$ $=>$ target qubit flip: $|0 angle.r$ $<=>$ $-|1 angle.r$.
// - One of ontrol qubit in state $|0 angle.r$ $=>$ target qubit keep invariant.

// == Simulation results for Z-error parity check
// // - We simulate the nine-atoms unit system with x-axis means time and y-axis means the population of different states with designed julia package:


// // #figure(
// //   image("simulation.png", width: 50%),
// // )
// - All Hadamard rotation $=>$ Pulse sequence $=>$ All Hadamard rotation.
// - Concentrate on the population of single 5-atom plaquette shown below:
// #figure(
//   image("extraction.png", width: 35%),
// )


// #figure(
//   image("figure_2_modify.pdf", width: 70%),
// )
// #figure(
//   image("gateimp1.png", width: 100%),
// )

// - $|00000angle.r => |"+++++"angle.r =>"pulse sequence" => |"+++++"angle.r => |00000 angle.r ("final state")$

// == Simulation results for X-error parity check--no error
// - $|11011angle.r => |"--+--"angle.r =>"pulse sequence" => |"--+--"angle.r => |11011 angle.r ("final state")$
// #figure(
  // image("minus2.png", width: 50%),
// )
// == Simulation results for X-error parity check--single error
// // - $|10000angle.r => |"-++++"angle.r =>"pulse sequence" => |"-+-++"angle.r => |10100 angle.r ("final state")$
// #figure(
//   image("error.png", width: 37%),
// )


// == Quantum cellular automata approach
// - Approach: Discretization

// - Abstracts continuous evolution into discrete, local update rules. Perfect for studying logical error propagation and topological thresholds on massive lattices.
// #figure(
//   image("qca.png", width: 45%),
//   caption: [Qubits are represented by the colored boxes, while the three-qubit local rules derived from pulse-level physics are represented by the black rectangles.]
// )

// == Discrete update rules
// #figure(
//   image("rules.png", width: 60%),
//   caption: [Local update rules for the QCA model of the measurement-free error correction protocol.]
// )
// == Bottlenecks in QCA approach
// - QCA:
// -- QCA relies on simplified discrete rules rather than continuous quantum dynamics. Loss of details.

// --  storing the dense vector ($2^N$ amplitudes)

// - Tensor network: 
// -- Objective: To simulate large-scale arrays while retaining the full quantum mechanical description of the state vector $|psi angle.r$.


== Simulation results with QCA

== Tensor Networks (MPS)
// - Approach: Compression

- Mechanism:
-- Decomposes the global state into a chain of local tensors connected by virtual bonds.

-- Mappings: Uses a "snake" ordering path to map 2D atom arrays to 1D MPS structures.
// Retains the full wavefunction but compresses it based on entanglement entropy ("Area Law"). Ideal for high-fidelity simulation of intermediate-scale systems (50-100 atoms).
// Exploits the "area law" of entanglement entropy. As long as entanglement is limited (which is true for stabilizer/ground states), the state can be compressed efficiently without losing quantum information
// #figure(
//   image("mps.png", width: 40%),
//   caption: [Matrix Product State representation of a quantum state.]
// )

// == Simulation with MPS
// - Mapping the 2D lattice to a 1D chain.
#figure(
  image("MPS-32.png", width: 60%),
  caption: [Mapping the 2D lattice to a 1D chain for MPS simulation.]
)

-- Simulation: Use the time- evolving block decimation (TEBD) to evolve the MPS with package `https://github.com/jcmgray/quimb.git` .


== Continuous error-correction simulation with MPS
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Add exactly one error between two correction rounds ]

    - #text(weight: "bold", fill: gate-orange)[With correction(orange line):] The system's correction protocol is able to correct one single error.

    - #text(weight: "bold", fill: gate-blue)[Without correction(blue line):] The system rapidly deviates from the ground state due to accumulating errors.
    

  ],
  [
    // #text(weight: "bold", fill: primary-color)[Errored condition: ]
    #figure(
      image("continue.pdf", width: 120%),
      )
  ],
)
#show strong: alert

== Prospects
#text(weight: "bold", fill: primary-color)[Key areas for future work include: ]

•  #text(weight: "bold", fill: black, size:18pt)[Realize in Surface code: ]

Demonstrating error correction in the more experimentally relevant surface code.

•  #text(weight: "bold", fill: black, size:18pt)[More realistic condition:]

Explore the performance under random errors, noise, atom loss, and other realistic imperfections.

•  #text(weight: "bold", fill: black, size:18pt)[Simulation with TDVP method:]

For higher accuracy and efficiency, use the local time-dependent variational principle (TDVP) method for MPS evolution with Julia language.

#show: appendix

#slide[
  #v(1fr)
  #align(center)[
    #v(1.9in)
    #text(size: 58pt, weight: "bold", fill: primary-color)[
      Thank You
    ]
    #v(-0.5in)
    #line(length: 40%, stroke: 1pt + gray)
  ]
  #v(1fr)
]
// -- Contraction and Trunca  tion to control bond dimension.
= Appendix
== Time-Evolving Block Decimation (TEBD)
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Highly effective for circuits with limited entanglement growth and short-range interactions. ]

    - #text(weight: "bold", fill: gate-orange)[Decompose:] Time-evolution operator $->$ sequence of two-qubit MPO (via Trotter-Suzuki decomposition).

    - #text(weight: "bold", fill: gate-blue)[Apply and truncate:] Apply gates $->$ local truncation(via Singular Value Decomposition) to keep bond dimension manageable.
    

  ],
  [
    // #text(weight: "bold", fill: primary-color)[Errored condition: ]
    #figure(
      image("TEBD.pdf", width: 83%),
      )
  ],
)
#show strong: alert
== Limitations of TEBD
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[Compounding local errors. : ]

#figure(
  canvas(length: 0.7cm, {
    import draw: *
    set-origin((-0.225, 0))      
    // Arrow at the top with label
    line((0, 3.2), (14, 3.2), stroke: gray + 1.5pt, mark: (end: ">", fill: gray))
    content((7, 3.8), text(fill: gray.darken(30%), size: 0.9em)[Truncation at each step])

    // Wave 1: Clean sine wave
    let wave1 = ()
    for i in range(0, 41) {
      let x = i * 0.05
      let y = calc.sin(i * 0.3) * 0.8
      wave1.push((x, y))
    }
    line(..wave1, stroke: rgb("#1a365d") + 2pt)

    // Wave 2: Slightly noisy sine wave
    let wave2 = ()
    for i in range(0, 41) {
      let x = 2.5 + i * 0.05
      let noise = calc.sin(i * 1.5) * 0.08
      let y = calc.sin(i * 0.3) * 0.8 + noise
      wave2.push((x, y))
    }
    line(..wave2, stroke: rgb("#1a365d") + 2pt)

    // Wave 3: More noisy
    let wave3 = ()
    for i in range(0, 41) {
      let x = 5 + i * 0.05
      let noise = calc.sin(i * 2.5) * 0.15 + calc.cos(i * 1.8) * 0.1
      let y = calc.sin(i * 0.3) * 0.8 + noise
      wave3.push((x, y))
    }
    line(..wave3, stroke: rgb("#1a365d") + 2pt)

    // Wave 4: Even more noisy
    let wave4 = ()
    for i in range(0, 41) {
      let x = 7.5 + i * 0.05
      let noise = calc.sin(i * 3.5) * 0.2 + calc.cos(i * 2.2) * 0.15 + calc.sin(i * 5) * 0.1
      let y = calc.sin(i * 0.3) * 0.7 + noise
      wave4.push((x, y))
    }
    line(..wave4, stroke: rgb("#1a365d") + 2pt)

    // Wave 5: Very noisy (approaching random)
    let wave5 = ()
    for i in range(0, 41) {
      let x = 10 + i * 0.05
      let noise = calc.sin(i * 4.7) * 0.25 + calc.cos(i * 3.1) * 0.2 + calc.sin(i * 7.3) * 0.15 + calc.cos(i * 11) * 0.1
      let y = calc.sin(i * 0.3) * 0.5 + noise
      wave5.push((x, y))
    }
    line(..wave5, stroke: rgb("#1a365d") + 2pt)

    // Wave 6: Most noisy (chaotic)
    let wave6 = ()
    for i in range(0, 41) {
      let x = 12.5 + i * 0.05
      let noise = calc.sin(i * 5.3) * 0.3 + calc.cos(i * 4.1) * 0.25 + calc.sin(i * 9.7) * 0.2 + calc.cos(i * 13) * 0.15
      let y = calc.sin(i * 0.3) * 0.3 + noise
      wave6.push((x, y))
    }
    line(..wave6, stroke: rgb("#1a365d") + 2pt)
  }),
) 
- Apply gate $->$ Truncation with local information $->$ Accumulated truncation errors $->$ Requirement of increasing bond dimension.
],
  [
    #text(weight: "bold", fill: primary-color)[Inefficient handling of Long-range interactions: ]

    #figure(
      image("SWAP gates.pdf", width: 60%),
      )

    - Requirement of external SWAP gates increases circuit depth and calculation expense.
    

  ],
)

== Time-Dependent Variational Principle (TDVP)
#grid(
  columns:(1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[More accurate evolution within the MPS manifold:@Benedikter_2018 ]  
    - #text(weight: "bold", fill: gate-blue)[Definition:] TDVP evolves the state $|Psi(A)angle.r$ within a restricted sub-manifold $cal(M)_D$ of the full Hilbert space $cal(H)$

    - #text(weight: "bold", fill: gate-orange)[Advantage:] Finds the provably optimal evolution path, ensuring most efficient use of MPS's representational capacity. Avoids compounding local truncation errors.
  ],
  [
    #figure(
      canvas(length: 2cm, {
        import draw: *

        // Curved manifold surface (M) with gradient effect
        merge-path({
          bezier((3, 1), (6.5, 2.5), (4, 1.8), (5.5, 1.5))
          bezier((6.5, 2.5), (2.85, 4.15), (6, 3.5), (4.5, 4.5))
          bezier((2.85, 4.15), (0.5, 2.5), (1.5, 4), (0.8, 3.5))
          bezier((0.5, 2.5), (3, 1), (0.5, 1.8), (1.5, 1))
        }, close: true, fill: gradient.linear(white, gray.lighten(20%), angle: 90deg), stroke: gray)

        // Tangent plane (parallelogram)
        line((2, 2), (1, 3), (6.5, 4.1), (7.5, 3.1), close: true, fill: gray.lighten(70%), stroke: gray)

        // Point u
        circle((3.5, 3), radius: 0.08, fill: black, stroke: none)

        // Arrow: exact evolution (1/i)Hu
        line((3.5, 3), (5, 5), stroke: black + 1.5pt, mark: (end: ">", fill: black))

        // Arrow: projected evolution P(u)(1/i)Hu
        line((3.5, 3), (5, 3.3), stroke: black + 1.5pt, mark: (end: ">", fill: black))

        // Dashed projection line
        line((5, 5), (5, 3.3), stroke: (dash: "dashed", paint: black))

        // Right angle marker
        line((5, 3.5), (4.8, 3.46), stroke: black + 0.8pt)
        line((4.8, 3.46), (4.8, 3.26), stroke: black + 0.8pt)

        // Labels
        content((5.3, 5.2), $frac(1, i) H u$)
        content((1.3, 1.8), $T_u cal(M)$)
        content((5.8, 3.1), text(size: 0.8em)[$P(u) frac(1, i) H u$])
        content((3.1, 2.7), $u$)
        content((5.5, 1.8), $cal(M)$)
      }),
    )
  ]
)

== Local-TDVP algorithm
- We intend to develop an package for efficiently simulating large-scale Rydberg arrays with long-range interactions using local-TDVP algorithm@sander2025quantumcircuitsimulationlocal with Julia language.

-- #text(weight: "bold", fill: gate-blue)[TDVP methods for discrite unitary gates:] Treating each gate as a discrete time evolution $g_j = e^(-i dot H_j)(delta t=1)$

-- #text(weight: "bold", fill: gate-blue)[local-TDVP methods:]
For a local gate generator H acting on qubits [k,k+q], the global TDVP projector can be approximated by a local projector acting only on the local window [k-1,k+q+1] surrounding the gate.(Computation complexity independent of system size N)


// == Conclusion
// - We have designed and validated a measurement-free and movement-free QEC protocol

// - By combining a multi- species architecture with global, species-selective pulses, the scheme eliminates the primary bottlenecks of measurement latency and atom shuttling.

// - Pulse-level and tensor network simulations confirm the protocol's ability to coherently detect and autonomously correct errors, maintaining high fidelity over many cycles.

// - This approach significantly reduces QEC cycle times and simplifies experimental complexity, accelerating progress in neutral atom quantum computing.


// •  #text(weight: "bold", fill: black, size:18pt)[Implementing Logical Gates:]

// Extending
// the framework to performs perform
// universal logical operations on the
// encoded qubits.

•  #text(weight: "bold", fill: black, size:18pt)[Near-Term Experimental Demonstration:]

Realizing the protocol in existing dual-
species Rydberg atom arrays.

// == Simulation results for X-error parity check--single error
// - $|01011angle.r => |"+-+--"angle.r =>"pulse sequence" => |"+++++"angle.r => |00000 angle.r ("final state")$
// #figure(
//   image("allmflip1.png", width: 50%),
// )


// == Bottlenecks in step1
// - The phase accumulation in the gate schemes will affect the realiablility of the equvalence of parity check process.

// - Duration of adiabatic pulse is too long and result in gate infidelity.

// - feasibility of the designed gate scheme in large system(experimental perspective)(for example, more than 2 species).

// - Physical realization of the toric-code lattice.

// == Derivative Removal by Adiabatic Gate
// - DRAG
// == Step2: Error correcting $C_2"NOT"$ gate
// //- For example, if there is a Z-error happens on data qubit 5, the parity check will flip the neighboring red ancilla qubits b,c. Then, we can perform a $C_2"NOT"$ gate for error correction where the two flipped neighboring ancilla qubits act as control qubits and the errored data qubit acts as target qubit.

// - Rule: Only if the ancilla qubits are both in state $|1 angle.r$, the target data qubit will be flipped.

// //== Step2: Error correcting $C_2"NOT"$ gate
// - gate scheme:
// #figure(
//   image("errorco.png", width: 80%),
// )



== References

#set text(size: 14pt)
#set par(leading: 0.6em)

#bibliography(
  "reference.bib",
  title: none,
  style: "ieee",
)