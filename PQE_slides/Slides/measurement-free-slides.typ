// Measurement-Free QEC Speedup Slides
// All figures drawn with Typst for high resolution

#import "@preview/cetz:0.3.2": canvas, draw
#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge

// Color definitions matching the PDF
#let dark-blue = rgb("#1a365d")
#let accent-blue = rgb("#2563eb")
#let accent-gold = rgb("#b8860b")
#let light-gold = rgb("#d4a84b")
#let bg-color = rgb("#f5f5f0")
#let data-blue = rgb("#3b82f6")
#let ancilla-green = rgb("#22c55e")
#let ancilla-red = rgb("#ef4444")
#let gate-green = rgb("#4ade80")
#let gate-blue = rgb("#60a5fa")
#let gate-yellow = rgb("#fbbf24")
#let gate-orange = rgb("#fb923c")
#let gate-red = rgb("#f87171")
#let gate-purple = rgb("#a78bfa")
#let gate-gray = rgb("#9ca3af")

// Page setup for slides
#set page(
  width: 16in,
  height: 9in,
  fill: bg-color,
  margin: (x: 0.8in, y: 0.6in),
)

#set text(font: "New Computer Modern", size: 24pt)

// Slide title style
#let slide-title(body) = {
  text(size: 48pt, weight: "bold", fill: dark-blue)[#body]
  v(0.3in)
}

#let slide-subtitle(body) = {
  text(size: 32pt, weight: "bold", fill: accent-gold)[#body]
}

#let key-insight(body) = {
  text(fill: accent-gold, weight: "bold")[Key Insight:] + [ ] + body
}

#let bold-label(body) = {
  text(weight: "bold")[#body]
}

// ============================================================================
// SLIDE 1: Title Slide
// ============================================================================
#page[
  #v(0.5in)
  #align(center)[
    #text(size: 52pt, weight: "bold", fill: dark-blue)[
      Overcoming the Speed Limit of Quantum Error \
      Correction in Neutral Atom Arrays
    ]
    #v(0.3in)
    #text(size: 36pt, weight: "bold", fill: accent-gold)[
      A Measurement-Free and Movement-Free Protocol \
      Using Multi-Species Atoms and Global Control
    ]
    #v(0.4in)
    
    // Draw the atom array with laser beams illustration
    #canvas(length: 1cm, {
      import draw: *
      
      // Draw flowing laser beams (red and green waves)
      let wave-amplitude = 0.4
      let wave-freq = 0.3
      
      // Green beam (bottom wave)
      for i in range(0, 60) {
        let x1 = -12 + i * 0.5
        let x2 = -12 + (i + 1) * 0.5
        let y1 = calc.sin(i * wave-freq) * wave-amplitude - 2
        let y2 = calc.sin((i + 1) * wave-freq) * wave-amplitude - 2
        line((x1, y1), (x2, y2), stroke: (paint: green.transparentize(50%), thickness: 8pt))
      }
      
      // Red beam (top wave)  
      for i in range(0, 60) {
        let x1 = -12 + i * 0.5
        let x2 = -12 + (i + 1) * 0.5
        let y1 = calc.sin(i * wave-freq + 3.14) * wave-amplitude + 2
        let y2 = calc.sin((i + 1) * wave-freq + 3.14) * wave-amplitude + 2
        line((x1, y1), (x2, y2), stroke: (paint: red.transparentize(60%), thickness: 8pt))
      }
      
      // Draw atom lattice (5x5 grid with some variation)
      let atom-spacing = 1.8
      for row in range(0, 5) {
        for col in range(0, 7) {
          let x = (col - 3) * atom-spacing
          let y = (row - 2) * atom-spacing * 0.8
          // Add slight 3D perspective
          let z-offset = (row - 2) * 0.15
          
          // Draw connecting lines
          if col < 6 {
            line((x, y), (x + atom-spacing, y), stroke: (paint: gray.darken(30%), thickness: 1pt))
          }
          if row < 4 {
            line((x, y), (x, y + atom-spacing * 0.8), stroke: (paint: gray.darken(30%), thickness: 1pt))
          }
          
          // Draw atom as sphere with gradient effect
          circle((x, y), radius: 0.4, fill: gradient.radial(data-blue.lighten(40%), data-blue, center: (30%, 30%), radius: 100%), stroke: none)
        }
      }
    })
    
    #v(0.5in)
    #text(size: 28pt, fill: accent-gold)[
      This work presents a novel QEC scheme that eliminates the dominant latency sources in \
      neutral atom architectures, accelerating the path to fault-tolerant quantum computation.
    ]
  ]
]

// ============================================================================
// SLIDE 2: Neutral Atom Arrays Platform
// ============================================================================
#page[
  #slide-title[Neutral atom arrays have emerged as a leading platform for scalable quantum computing.]
  
  #grid(
    columns: (1fr, 1fr),
    gutter: 0.5in,
    [
      #text(size: 26pt)[Key strengths that make this platform exceptionally promising:]
      #v(0.2in)
      
      #list(
        marker: text(size: 24pt)[#sym.bullet],
        spacing: 0.25in,
        [#bold-label[Exceptional Scalability:] Demonstrations of arrays with thousands of atomic qubits.],
        [#bold-label[Long Coherence Times:] Qubit coherence can surpass one second, significantly longer than many competing platforms.],
        [#bold-label[High Gate Fidelity:] Two-qubit gate fidelities have been pushed beyond 99.5%.],
        [#bold-label[Strong, Tunable Interactions:] Rydberg states enable strong, controllable interactions between atoms.],
      )
      
      #v(0.3in)
      
      // Draw coherence time bar chart
      #canvas(length: 1cm, {
        import draw: *
        
        let bar-height = 0.8
        let y-spacing = 1.5
        
        // Labels
        content((-1, 2 * y-spacing), anchor: "east", text(size: 18pt)[Trapped Ions])
        content((-1, 1 * y-spacing), anchor: "east", text(size: 18pt)[Neutral Atoms])
        content((-1, 0), anchor: "east", text(size: 18pt)[Superconducting\ Qubits])
        
        // Bars (log scale representation)
        // Trapped Ions: ~1000s -> full width
        rect((-0.5, 2 * y-spacing - bar-height/2), (12, 2 * y-spacing + bar-height/2), fill: gray.lighten(20%), stroke: none)
        
        // Neutral Atoms: ~10s -> most of width  
        rect((-0.5, 1 * y-spacing - bar-height/2), (9.5, 1 * y-spacing + bar-height/2), fill: accent-blue, stroke: none)
        
        // Arrow and annotation for Neutral Atoms
        line((10, 1 * y-spacing), (9.7, 1 * y-spacing), stroke: (paint: accent-gold, thickness: 2pt), mark: (end: "stealth", fill: accent-gold))
        content((11.5, 1 * y-spacing + 0.3), text(size: 14pt, fill: accent-gold)[Our Platform])
        content((11.5, 1 * y-spacing - 0.3), text(size: 14pt, fill: accent-gold)[of Choice: A])
        content((11.5, 1 * y-spacing - 0.9), text(size: 14pt, fill: accent-gold)[Key Advantage])
        
        // Superconducting: ~1ms -> small
        rect((-0.5, -bar-height/2), (2, bar-height/2), fill: gray.lighten(20%), stroke: none)
        
        // X-axis
        line((-0.5, -1.2), (12.5, -1.2), stroke: black)
        
        // Log scale labels
        for (i, label) in ((0, [$10^(-4)$]), (2, [$10^(-3)$]), (4, [$10^(-2)$]), (6, [$10^(-1)$]), (8, [$10^0$]), (10, [$10^1$]), (12, [$10^2$]), (13.5, [$10^3$])) {
          line((i - 0.5, -1.2), (i - 0.5, -1.4), stroke: black)
          content((i - 0.5, -1.8), text(size: 14pt)[#label])
        }
        
        content((6, -2.6), text(size: 16pt)[Coherence Time (seconds) \[Log Scale\]])
      })
    ],
    [
      // Draw atom array image representation (black background with white dots)
      #canvas(length: 1cm, {
        import draw: *
        
        // Black background
        rect((-0.5, -0.5), (14, 14), fill: black, stroke: none)
        
        // Draw circular arrangement of atoms
        let center-x = 7
        let center-y = 7
        let max-radius = 6
        
        // Create grid of atoms in circular pattern
        for row in range(0, 28) {
          for col in range(0, 28) {
            let x = col * 0.5
            let y = row * 0.5
            let dx = x - center-x
            let dy = y - center-y
            let dist = calc.sqrt(dx * dx + dy * dy)
            
            if dist < max-radius and dist > 0.5 {
              circle((x, y), radius: 0.08, fill: white, stroke: none)
            }
          }
        }
        
        // Add some empty spots in pattern to show atom arrangement
        // (HKUST-GZ logo area left empty as in the original)
      })
    ]
  )
]

// ============================================================================
// SLIDE 3: QEC Bottleneck
// ============================================================================
#page[
  #slide-title[QEC cycles are orders of magnitude slower than quantum gates, creating a critical performance bottleneck.]
  
  #v(0.3in)
  
  // Timeline labels
  #grid(
    columns: (1.5fr, 2fr, 3fr),
    gutter: 0in,
    align(left)[
      #text(size: 22pt)[Gate Operation\ (~1 #sym.mu\s)]
    ],
    align(center)[
      #text(size: 22pt)[Measurement &\ Movement Process]
    ],
    align(center)[
      #text(size: 22pt)[Extended Duration\ (~hundreds of #sym.mu\s)]
    ]
  )
  
  #v(0.1in)
  
  // Draw timeline arrow
  #canvas(length: 1cm, {
    import draw: *
    
    let arrow-height = 1.5
    let total-width = 28
    
    // Yellow segment (gate operation)
    rect((0, 0), (0.8, arrow-height), fill: gate-yellow, stroke: none)
    
    // Blue segment (main process) with arrow head
    rect((0.8, 0), (total-width - 3, arrow-height), fill: accent-blue, stroke: none)
    
    // Lightning bolt symbol in the middle
    let bolt-x = 18
    let bolt-y = arrow-height / 2
    line((bolt-x, bolt-y + 0.6), (bolt-x - 0.3, bolt-y), stroke: (paint: white, thickness: 3pt))
    line((bolt-x - 0.3, bolt-y), (bolt-x + 0.2, bolt-y), stroke: (paint: white, thickness: 3pt))
    line((bolt-x + 0.2, bolt-y), (bolt-x - 0.1, bolt-y - 0.6), stroke: (paint: white, thickness: 3pt))
    
    // Arrow head
    line((total-width - 3, arrow-height), (total-width, arrow-height / 2), stroke: (paint: accent-blue, thickness: 0pt))
    line((total-width - 3, 0), (total-width, arrow-height / 2), stroke: (paint: accent-blue, thickness: 0pt))
    // Fill arrow head
    let pts = ((total-width - 3, 0), (total-width - 3, arrow-height), (total-width, arrow-height/2))
    line(..pts, close: true, fill: accent-blue, stroke: none)
  })
  
  #v(0.4in)
  
  #grid(
    columns: (1fr, 2fr),
    gutter: 0.5in,
    [
      #text(size: 28pt, weight: "bold")[Quantum Gates:]
      #v(0.1in)
      #text(size: 24pt)[Operations are incredibly fast, taking approximately 1 microsecond (#sym.mu\s).]
    ],
    [
      #text(size: 28pt, weight: "bold")[Corrective Actions:] #text(size: 24pt)[Conventional QEC requires operations that are dramatically slower:]
      #v(0.15in)
      #list(
        marker: text(size: 24pt)[#sym.bullet],
        [Mid-circuit Measurement: ~100--500 #sym.mu\s (fluorescence detection)],
        [Atom Shuttling/Movement: ~10s--100s of #sym.mu\s]
      )
    ]
  )
  
  #v(0.5in)
  
  #text(size: 28pt, weight: "bold")[The Consequence:] #text(size: 26pt)[The quantum state decoheres while waiting for slow measurements and movements, undermining the very purpose of error correction.]
]

// ============================================================================
// SLIDE 4: Our Solution - Paradigm Shift
// ============================================================================
#page[
  #slide-title[Our solution is a new QEC paradigm that is both measurement-free and movement-free.]
  
  #v(0.2in)
  
  #grid(
    columns: (1fr, 0.8fr, 1fr),
    gutter: 0.3in,
    [
      #align(center)[
        #text(size: 32pt, weight: "bold")[Conventional QEC]
        #v(0.2in)
        
        // Draw conventional QEC diagram
        #canvas(length: 1cm, {
          import draw: *
          
          // Atom grid (left side)
          for row in range(0, 4) {
            for col in range(0, 4) {
              let x = col * 1.2 - 2
              let y = row * 1.2 - 1.5
              let colors = (red, orange, yellow, green, blue, purple)
              let c = colors.at(calc.rem(row + col, 6))
              circle((x, y), radius: 0.3, fill: c, stroke: none)
            }
          }
          
          // Dashed lines showing interaction zone
          arc((2, 1), start: -30deg, stop: 30deg, radius: 3, stroke: (paint: black, thickness: 1pt, dash: "dashed"))
          arc((2, 1), start: -50deg, stop: 50deg, radius: 4, stroke: (paint: black, thickness: 1pt, dash: "dashed"))
          arc((2, 1), start: -70deg, stop: 70deg, radius: 5, stroke: (paint: black, thickness: 1pt, dash: "dashed"))
          
          // Measurement device (eye symbol)
          rect((4, 0.5), (7, 3.5), fill: gray.lighten(60%), stroke: black)
          
          // Eye
          circle((5.5, 2.5), radius: 0.6, stroke: black, fill: white)
          circle((5.5, 2.5), radius: 0.25, fill: black)
          
          // Meter label
          content((5.5, 4.2), text(size: 14pt)[Meter])
          
          // Wavy line (signal)
          let wave-start = 6.5
          for i in range(0, 8) {
            let x1 = wave-start + i * 0.15
            let x2 = wave-start + (i + 1) * 0.15
            let y1 = 2.5 + calc.sin(i * 1.5) * 0.15
            let y2 = 2.5 + calc.sin((i + 1) * 1.5) * 0.15
            line((x1, y1), (x2, y2), stroke: black)
          }
          
          // Labels
          content((5.5, 1.5), text(size: 12pt)[Measurement])
          content((5.5, 1.0), text(size: 12pt)[(~500 #sym.mu\s)])
          
          content((3, -0.5), text(size: 12pt)[interaction])
          content((3, -1), text(size: 12pt)[zone])
          
          // Classical Feedback box
          rect((4, -2.5), (7, -1.5), fill: white, stroke: black)
          content((5.5, -2), text(size: 12pt)[Classical])
          content((5.5, -2.5), text(size: 12pt)[Feedback])
          
          // Arrow from measurement to feedback
          line((5.5, 0.5), (5.5, -1.5), stroke: black, mark: (end: "stealth"))
        })
      ]
      
      #v(0.3in)
      #text(size: 22pt, weight: "bold")[Measurement-Free:] #text(size: 20pt)[Replaces slow, destructive fluorescence measurements with fully coherent operations. Syndrome information is mapped to ancilla qubits, which then trigger corrective gates without classical feedback.]
    ],
    [
      #align(center)[
        #v(1.5in)
        // Paradigm Shift arrow
        #canvas(length: 1cm, {
          import draw: *
          
          // Arrow body
          rect((0, 0), (3, 1.5), fill: accent-gold.darken(10%), stroke: none)
          
          // Arrow head
          let pts = ((3, -0.5), (3, 2), (5, 0.75))
          line(..pts, close: true, fill: accent-gold.darken(10%), stroke: none)
          
          // Text
          content((2, 0.75), text(size: 18pt, weight: "bold", fill: white)[Paradigm])
          content((2, 0.2), text(size: 18pt, weight: "bold", fill: white)[Shift])
        })
      ]
    ],
    [
      #align(center)[
        #text(size: 32pt, weight: "bold")[Our Protocol]
        #v(0.2in)
        
        // Draw our protocol diagram - static lattice with laser beams
        #canvas(length: 1cm, {
          import draw: *
          
          // Draw laser beams (colored bands)
          let beam-colors = (blue.transparentize(60%), red.transparentize(60%), green.transparentize(60%), purple.transparentize(60%))
          
          for (i, c) in beam-colors.enumerate() {
            let y-offset = i * 1.5 - 2.25
            // Horizontal beam
            rect((-3, y-offset - 0.4), (9, y-offset + 0.4), fill: c, stroke: none)
          }
          
          // Draw atom lattice (8x4 grid)
          for row in range(0, 4) {
            for col in range(0, 8) {
              let x = col * 1.2 - 1
              let y = row * 1.5 - 2.25
              
              // Alternate colors: blue (data), green (A1), red (A2)
              let c = if calc.rem(row, 2) == 0 {
                if calc.rem(col, 2) == 0 { data-blue } else { ancilla-green }
              } else {
                if calc.rem(col, 2) == 0 { ancilla-red } else { data-blue }
              }
              
              circle((x, y), radius: 0.35, fill: gradient.radial(c.lighten(40%), c, center: (30%, 30%), radius: 100%), stroke: none)
            }
          }
        })
      ]
      
      #v(0.3in)
      #text(size: 22pt, weight: "bold")[Movement-Free:] #text(size: 20pt)[Eliminates the need for atom shuttling. The atoms remain in a static lattice, and all interactions are mediated by precisely shaped, global laser pulses.]
    ]
  )
  
  #v(0.3in)
  #align(center)[
    #text(size: 26pt, fill: accent-gold, weight: "bold")[Key Insight:] #text(size: 26pt)[By executing the entire QEC cycle---syndrome mapping, error correction, and ancilla reset---unitarily, we remove the primary sources of latency and decoherence.]
  ]
]

// ============================================================================
// SLIDE 5: Three-Species Rydberg Atom Array
// ============================================================================
#page[
  #slide-title[The protocol is implemented on a static, three-species Rydberg atom array.]
  
  #grid(
    columns: (1fr, 1.2fr),
    gutter: 0.3in,
    [
      #text(size: 24pt)[The lattice architecture is composed of three distinct roles:]
      #v(0.2in)
      
      #list(
        marker: text(size: 24pt)[#sym.bullet],
        spacing: 0.2in,
        [#bold-label[Data Qubits (Species D):] Encode the logical information, located at the vertices of a square lattice.],
        [#bold-label[Ancilla Qubits (Species A1):] Used to detect X-type errors, located at the centers of the 'X-stabilizer' plaquettes.],
        [#bold-label[Ancilla Qubits (Species A2):] Used to detect Z-type errors, located at the centers of the 'Z-stabilizer' plaquettes.],
        [#bold-label[Species-Selective Control:] The distinct atomic species have well-separated transition frequencies, allowing global laser pulses to address one species without affecting the others.],
      )
    ],
    [
      #align(center)[
        // Draw the 4x4 lattice with three species
        #canvas(length: 1cm, {
          import draw: *
          
          let spacing = 2.5
          
          // Draw grid lines first
          for i in range(0, 5) {
            // Vertical lines
            line((i * spacing, 0), (i * spacing, 4 * spacing), stroke: (paint: gray.darken(20%), thickness: 1.5pt))
            // Horizontal lines
            line((0, i * spacing), (4 * spacing, i * spacing), stroke: (paint: gray.darken(20%), thickness: 1.5pt))
          }
          
          // Draw data qubits (blue) at vertices
          for row in range(0, 5) {
            for col in range(0, 5) {
              let x = col * spacing
              let y = row * spacing
              circle((x, y), radius: 0.45, fill: gradient.radial(data-blue.lighten(40%), data-blue, center: (30%, 30%), radius: 100%), stroke: none)
            }
          }
          
          // Draw ancilla qubits at plaquette centers
          // A1 (green) and A2 (red) alternate in checkerboard
          for row in range(0, 4) {
            for col in range(0, 4) {
              let x = col * spacing + spacing / 2
              let y = row * spacing + spacing / 2
              let c = if calc.rem(row + col, 2) == 0 { ancilla-green } else { ancilla-red }
              circle((x, y), radius: 0.45, fill: gradient.radial(c.lighten(40%), c, center: (30%, 30%), radius: 100%), stroke: none)
            }
          }
          
          // Legend
          let legend-y = -1.5
          circle((1, legend-y), radius: 0.35, fill: gradient.radial(data-blue.lighten(40%), data-blue, center: (30%, 30%), radius: 100%), stroke: none)
          content((4.5, legend-y), anchor: "west", text(size: 16pt)[Data Qubits (Species D) - e.g., #super[87]Rb])
          
          circle((1, legend-y - 1), radius: 0.35, fill: gradient.radial(ancilla-green.lighten(40%), ancilla-green, center: (30%, 30%), radius: 100%), stroke: none)
          content((4.5, legend-y - 1), anchor: "west", text(size: 16pt)[Ancilla Qubits (Species A1) - X-error detection])
          
          circle((1, legend-y - 2), radius: 0.35, fill: gradient.radial(ancilla-red.lighten(40%), ancilla-red, center: (30%, 30%), radius: 100%), stroke: none)
          content((4.5, legend-y - 2), anchor: "west", text(size: 16pt)[Ancilla Qubits (Species A2) - Z-error detection])
        })
      ]
    ]
  )
]

// ============================================================================
// SLIDE 6: QEC Cycle Pulse Sequence
// ============================================================================
#page[
  #slide-title[A complete QEC cycle is driven by a sequence of global, species-selective laser pulses.]
  
  #grid(
    columns: (1fr, 1.8fr),
    gutter: 0.3in,
    [
      #text(size: 22pt)[The full cycle for one error type is executed in two main phases:]
      #v(0.15in)
      
      #list(
        marker: text(size: 20pt)[#sym.bullet],
        spacing: 0.15in,
        [#text(fill: accent-gold, weight: "bold")[Error Check:] Parity information from four data qubits is coherently mapped onto a central A1 ancilla. This involves a sequence of Hadamard gates and conditional multi-qubit gates (OR gate, C#sub[2]NOT).],
        [#text(fill: accent-gold, weight: "bold")[Error Correction:] The resulting state of the A1 ancillas then controls a final C#sub[2]NOT gate, which conditionally flips the erroneous data qubit to correct the error.],
        [#text(fill: accent-gold, weight: "bold")[Reset:] The A1 ancillas are reset to |0#sym.angle.r to prepare for the next cycle. An analogous sequence using A2 ancillas corrects Z-errors.],
      )
    ],
    [
      // Draw pulse sequence diagram
      #canvas(length: 1cm, {
        import draw: *
        
        let row-height = 2.5
        let col-width = 1.3
        let gate-w = 1.0
        let gate-h = 1.0
        
        // Row labels
        content((-1.5, 2 * row-height), text(size: 20pt, weight: "bold")[D])
        content((-1.5, 1 * row-height), text(size: 20pt, weight: "bold")[A1])
        content((-1.5, 0), text(size: 20pt, weight: "bold")[A2])
        
        // Horizontal lines
        line((0, 2 * row-height), (22, 2 * row-height), stroke: black)
        line((0, 1 * row-height), (22, 1 * row-height), stroke: black)
        line((0, 0), (22, 0), stroke: black)
        
        // Arrow at end
        line((22, 0), (22.5, 0), stroke: black, mark: (end: "stealth"))
        
        // Vertical dashed line separating X and Z error sections
        line((11, -1), (11, 6.5), stroke: (paint: gray, dash: "dashed"))
        
        // X-error check gates (D row)
        let x-gates-d = (
          (0.5, "h#sub[D]", gate-green),
          (1.8, "cD", gate-blue),
          (3.1, "eD", gate-yellow),
          (4.4, "h#sub[D]", gate-green),
          (5.7, "eD", gate-yellow),
        )
        
        for (x, label, c) in x-gates-d {
          rect((x, 2 * row-height - gate-h/2), (x + gate-w, 2 * row-height + gate-h/2), fill: c, stroke: gray)
          content((x + gate-w/2, 2 * row-height), text(size: 14pt)[#label])
        }
        
        // X-error check gates (A1 row)
        let x-gates-a1 = (
          (0.5, "h1", gate-orange),
          (1.8, "b1", gate-red),
          (3.1, "b1", gate-red),
          (4.4, "d1", gate-purple),
          (5.7, "d1", gate-purple),
          (7.0, "h1", gate-orange),
        )
        
        for (x, label, c) in x-gates-a1 {
          rect((x, 1 * row-height - gate-h/2), (x + gate-w, 1 * row-height + gate-h/2), fill: c, stroke: gray)
          content((x + gate-w/2, 1 * row-height), text(size: 14pt)[#label])
        }
        
        // X-error correction
        rect((8.3, 1 * row-height - gate-h/2), (8.3 + gate-w, 1 * row-height + gate-h/2), fill: gate-purple, stroke: gray)
        content((8.3 + gate-w/2, 1 * row-height), text(size: 14pt)[d1])
        
        rect((9.6, 1 * row-height - gate-h/2), (9.6 + gate-w, 1 * row-height + gate-h/2), fill: gate-gray, stroke: gray)
        content((9.6 + gate-w/2, 1 * row-height), text(size: 14pt)[R1])
        
        // Z-error check gates (D row)
        let z-start = 11.5
        let z-gates-d = (
          (z-start, "h#sub[D]", gate-green),
          (z-start + 1.3, "cD", gate-blue),
          (z-start + 2.6, "eD", gate-yellow),
          (z-start + 3.9, "h#sub[D]", gate-green),
          (z-start + 5.2, "eD", gate-yellow),
          (z-start + 6.5, "h#sub[D]", gate-green),
        )
        
        for (x, label, c) in z-gates-d {
          rect((x, 2 * row-height - gate-h/2), (x + gate-w, 2 * row-height + gate-h/2), fill: c, stroke: gray)
          content((x + gate-w/2, 2 * row-height), text(size: 14pt)[#label])
        }
        
        // Z-error check gates (A2 row)
        let z-gates-a2 = (
          (z-start + 1.3, "b2", gate-orange),
          (z-start + 2.6, "b2", gate-orange),
          (z-start + 3.9, "d2", gate-purple),
          (z-start + 5.2, "d2", gate-purple),
        )
        
        for (x, label, c) in z-gates-a2 {
          rect((x, -gate-h/2), (x + gate-w, gate-h/2), fill: c, stroke: gray)
          content((x + gate-w/2, 0), text(size: 14pt)[#label])
        }
        
        // Z-error correction
        rect((z-start + 6.5, -gate-h/2), (z-start + 6.5 + gate-w, gate-h/2), fill: gate-purple, stroke: gray)
        content((z-start + 6.5 + gate-w/2, 0), text(size: 14pt)[d2])
        
        rect((z-start + 7.8, -gate-h/2), (z-start + 7.8 + gate-w, gate-h/2), fill: gate-purple, stroke: gray)
        content((z-start + 7.8 + gate-w/2, 0), text(size: 14pt)[d2])
        
        rect((z-start + 9.1, -gate-h/2), (z-start + 9.1 + gate-w, gate-h/2), fill: gate-gray, stroke: gray)
        content((z-start + 9.1 + gate-w/2, 0), text(size: 14pt)[R2])
        
        // Section labels
        content((4, -1.5), text(size: 18pt)[X-error check])
        content((8.5, -1.5), text(size: 18pt)[X-error])
        content((8.5, -2), text(size: 18pt)[correction])
        content((15, -1.5), text(size: 18pt)[Z-error check])
        content((19.5, -1.5), text(size: 18pt)[Z-error])
        content((19.5, -2), text(size: 18pt)[correction])
      })
    ]
  )
]

// ============================================================================
// SLIDE 7: Multi-qubit Gates
// ============================================================================
#page[
  #slide-title[Multi-qubit gates are realized using Electromagnetically Induced Transparency and Rydberg blockade.]
  
  #v(0.2in)
  
  #grid(
    columns: (1fr, 1fr),
    gutter: 0.5in,
    [
      #align(center)[
        #text(size: 28pt, weight: "bold")[OR Gate (via EIT)]
        #v(0.2in)
        
        // Draw OR gate energy level diagram
        #canvas(length: 1cm, {
          import draw: *
          
          // Control Ancilla levels (left)
          let ctrl-x = 0
          line((ctrl-x, 0), (ctrl-x + 2, 0), stroke: black)
          content((ctrl-x - 0.5, 0), anchor: "east", text(size: 14pt)[$|0 angle.r_c$])
          
          line((ctrl-x, 1.5), (ctrl-x + 2, 1.5), stroke: black)
          content((ctrl-x - 0.5, 1.5), anchor: "east", text(size: 14pt)[$|1 angle.r_c$])
          
          line((ctrl-x, 5), (ctrl-x + 2, 5), stroke: black)
          content((ctrl-x - 0.5, 5), anchor: "east", text(size: 14pt)[$|r angle.r_c$])
          
          line((ctrl-x, 6.5), (ctrl-x + 2, 6.5), stroke: black)
          content((ctrl-x - 0.5, 6.5), anchor: "east", text(size: 14pt)[$|R angle.r_c$])
          
          // Transition arrows for control
          line((ctrl-x + 1, 1.5), (ctrl-x + 1, 5), stroke: (paint: blue, thickness: 2pt), mark: (end: "stealth", start: "stealth"))
          content((ctrl-x + 0.3, 3.25), text(size: 16pt, fill: blue)[1,3])
          
          // V_dd interaction
          bezier((ctrl-x + 2, 6.5), (ctrl-x + 4, 7.5), (ctrl-x + 3, 7), (ctrl-x + 3.5, 7.5), stroke: (paint: accent-gold, thickness: 2pt))
          content((ctrl-x + 3, 8), text(size: 14pt, fill: accent-gold)[$V_"dd"$])
          
          // Target Data Qubit levels (right)
          let tgt-x = 6
          line((tgt-x, 0), (tgt-x + 2, 0), stroke: black)
          content((tgt-x + 2.5, 0), anchor: "west", text(size: 14pt)[$|0 angle.r_t$])
          
          line((tgt-x, 1.5), (tgt-x + 2, 1.5), stroke: black)
          content((tgt-x + 2.5, 1.5), anchor: "west", text(size: 14pt)[$|1 angle.r_t$])
          
          // P level (intermediate)
          line((tgt-x, 3.5), (tgt-x + 2, 3.5), stroke: (paint: black, dash: "dashed"))
          content((tgt-x + 2.5, 3.5), anchor: "west", text(size: 14pt)[$|P angle.r_t$])
          
          // R level
          line((tgt-x, 6.5), (tgt-x + 2, 6.5), stroke: black)
          content((tgt-x + 2.5, 6.5), anchor: "west", text(size: 14pt)[$|R angle.r_t$])
          
          // Omega_c coupling
          line((tgt-x + 0.5, 3.5), (tgt-x + 0.5, 6.5), stroke: (paint: accent-gold, thickness: 2pt), mark: (end: "stealth", start: "stealth"))
          content((tgt-x - 0.3, 5), text(size: 14pt, fill: accent-gold)[$Omega_c$])
          
          // Delta_p detuning
          line((tgt-x + 1.5, 3.2), (tgt-x + 1.8, 3.2), stroke: black)
          line((tgt-x + 1.5, 3.8), (tgt-x + 1.8, 3.8), stroke: black)
          line((tgt-x + 1.65, 3.2), (tgt-x + 1.65, 3.8), stroke: black, mark: (end: "stealth", start: "stealth"))
          content((tgt-x + 2.3, 3.5), text(size: 12pt)[$Delta_p$])
          
          // Raman transitions
          line((tgt-x + 1, 0), (tgt-x + 1.2, 3.3), stroke: (paint: green, thickness: 2pt))
          line((tgt-x + 1.2, 3.7), (tgt-x + 1, 1.5), stroke: (paint: green, thickness: 2pt), mark: (end: "stealth"))
          content((tgt-x + 1.8, 1.8), text(size: 16pt, fill: green)[2])
          
          // V_vdw
          bezier((tgt-x + 1.5, 6.5), (tgt-x + 3, 7.5), (tgt-x + 2, 7), (tgt-x + 2.5, 7.5), stroke: (paint: accent-gold, thickness: 2pt))
          content((tgt-x + 2.8, 8), text(size: 14pt, fill: accent-gold)[$V_"vdW"$])
          
          // Labels
          content((ctrl-x + 1, -1), text(size: 14pt)[Control Ancilla])
          content((tgt-x + 1, -1), text(size: 14pt)[Target Data Qubit])
        })
        
        #v(0.2in)
        #text(size: 18pt)[An ancilla in the |1#sym.angle.r state is excited to a Rydberg state. This shifts the energy levels of the neighboring data qubit, breaking an Electromagnetically Induced Transparency (EIT) condition and allowing a Raman transition (a flip) to occur.]
      ]
    ],
    [
      #align(center)[
        #text(size: 28pt, weight: "bold")[CCNOT (C#sub[2]NOT) Gate]
        #v(0.2in)
        
        // Draw CCNOT gate energy level diagram
        #canvas(length: 1cm, {
          import draw: *
          
          // Control Ancilla 1
          let c1-x = 0
          line((c1-x, 0), (c1-x + 1.5, 0), stroke: black)
          content((c1-x - 0.3, 0), anchor: "east", text(size: 12pt)[$|0 angle.r_(c 1)$])
          
          line((c1-x, 1.2), (c1-x + 1.5, 1.2), stroke: black)
          content((c1-x - 0.3, 1.2), anchor: "east", text(size: 12pt)[$|1 angle.r_(c 1)$])
          
          line((c1-x, 4), (c1-x + 1.5, 4), stroke: black)
          content((c1-x - 0.3, 4), anchor: "east", text(size: 12pt)[$|r angle.r_(c 1)$])
          
          // Transitions for C1
          bezier((c1-x + 0.5, 1.2), (c1-x + 0.5, 4), (c1-x + 0.2, 2.6), (c1-x + 0.2, 2.6), stroke: (paint: red, thickness: 2pt))
          bezier((c1-x + 1, 1.2), (c1-x + 1, 4), (c1-x + 1.3, 2.6), (c1-x + 1.3, 2.6), stroke: (paint: red, thickness: 2pt))
          content((c1-x + 0.3, 2.6), text(size: 14pt, fill: red)[1])
          content((c1-x + 1.2, 2.6), text(size: 14pt, fill: red)[5])
          
          // Control Ancilla 2
          let c2-x = 3
          line((c2-x, 0), (c2-x + 1.5, 0), stroke: black)
          content((c2-x - 0.3, 0), anchor: "east", text(size: 12pt)[$|0 angle.r_(c 2)$])
          
          line((c2-x, 1.2), (c2-x + 1.5, 1.2), stroke: black)
          content((c2-x - 0.3, 1.2), anchor: "east", text(size: 12pt)[$|1 angle.r_(c 2)$])
          
          line((c2-x, 4), (c2-x + 1.5, 4), stroke: black)
          content((c2-x - 0.3, 4), anchor: "east", text(size: 12pt)[$|r angle.r_(c 2)$])
          
          // Transitions for C2
          bezier((c2-x + 0.5, 1.2), (c2-x + 0.5, 4), (c2-x + 0.2, 2.6), (c2-x + 0.2, 2.6), stroke: (paint: red, thickness: 2pt))
          bezier((c2-x + 1, 1.2), (c2-x + 1, 4), (c2-x + 1.3, 2.6), (c2-x + 1.3, 2.6), stroke: (paint: red, thickness: 2pt))
          content((c2-x + 0.3, 2.6), text(size: 14pt, fill: red)[1])
          content((c2-x + 1.2, 2.6), text(size: 14pt, fill: red)[5])
          
          // V_dd interaction between controls
          bezier((c1-x + 1.5, 4), (c2-x, 4), (c1-x + 2.25, 5), (c2-x - 0.75, 5), stroke: (paint: blue, thickness: 2pt))
          content((c1-x + 2.25, 5.5), text(size: 14pt, fill: blue)[$V_"dd"$])
          
          // Target Data Qubit
          let t-x = 6.5
          line((t-x, 0), (t-x + 1.5, 0), stroke: black)
          content((t-x + 2, 0), anchor: "west", text(size: 12pt)[$|A angle.r_t$])
          
          line((t-x, 1.5), (t-x + 1.5, 1.5), stroke: black)
          content((t-x + 2, 1.5), anchor: "west", text(size: 12pt)[$|B angle.r_t$])
          
          line((t-x, 4), (t-x + 1.5, 4), stroke: black)
          content((t-x + 2, 4), anchor: "west", text(size: 12pt)[$|r angle.r_t$])
          
          // Transitions for target
          line((t-x + 0.5, 0), (t-x + 0.5, 4), stroke: (paint: blue, thickness: 2pt), mark: (end: "stealth", start: "stealth"))
          content((t-x + 0.2, 2), text(size: 14pt, fill: blue)[2])
          
          line((t-x + 0.75, 1.5), (t-x + 0.75, 4), stroke: (paint: green, thickness: 2pt), mark: (end: "stealth", start: "stealth"))
          content((t-x + 0.5, 2.75), text(size: 14pt, fill: green)[3])
          
          line((t-x + 1, 0), (t-x + 1, 1.5), stroke: (paint: blue, thickness: 2pt), mark: (end: "stealth", start: "stealth"))
          content((t-x + 1.3, 0.75), text(size: 14pt, fill: blue)[4])
          
          // V_vdw
          bezier((c2-x + 1.5, 4), (t-x, 4), (c2-x + 2.5, 5), (t-x - 1, 5), stroke: (paint: accent-gold, thickness: 2pt))
          content((c2-x + 2.5, 5.5), text(size: 14pt, fill: accent-gold)[$V_"vdW"$])
          
          // Labels
          content((c1-x + 0.75, -1), text(size: 12pt)[Control])
          content((c1-x + 0.75, -1.5), text(size: 12pt)[Ancilla 1])
          content((c2-x + 0.75, -1), text(size: 12pt)[Control])
          content((c2-x + 0.75, -1.5), text(size: 12pt)[Ancilla 2])
          content((t-x + 0.75, -1), text(size: 12pt)[Target Data])
          content((t-x + 0.75, -1.5), text(size: 12pt)[Qubit])
        })
        
        #v(0.2in)
        #text(size: 18pt)[The data qubit is flipped only if _both_ neighboring ancillas are in a specific state. This is achieved by configuring the Rydberg blockade such that the presence of ancillas in a blocking state prevents the transition on the data qubit.]
      ]
    ]
  )
  
  #v(0.3in)
  #align(center)[
    #text(size: 24pt, weight: "bold")[Mechanism:] #text(size: 22pt)[The protocol relies on strong Rydberg interactions between data and ancilla qubits (V#sub[dd]) being much stronger than between data qubits themselves (V#sub[vdW]).]
  ]
]

// ============================================================================
// SLIDE 8: Pulse-level Simulations - No Error
// ============================================================================
#page[
  #slide-title[Pulse-level simulations on a 9-atom unit cell validate the high fidelity of the parity-check mechanism.]
  
  #grid(
    columns: (1fr, 1.5fr),
    gutter: 0.3in,
    [
      #text(size: 22pt)[To verify the physical implementation, we performed exact numerical integration of the Schrödinger equation for a 9-atom cluster (4 data, 5 ancilla qubits).]
      #v(0.2in)
      
      #text(size: 26pt, weight: "bold")[Scenario 1: No Error]
      #v(0.1in)
      
      #text(size: 22pt)[When the system starts in an error-free state (e.g., |+++++#sym.angle.r), the parity-check sequence correctly leaves the ancillas in the |0#sym.angle.r state and returns the data qubits to their original state.]
      #v(0.2in)
      
      #text(size: 24pt, weight: "bold")[Fidelity:] #text(size: 22pt)[Simulations confirm individual operation fidelities exceeding 99%, limited primarily by non-adiabatic effects.]
    ],
    [
      // Draw the simulation results
      #grid(
        columns: (1fr, 1fr),
        gutter: 0.2in,
        [
          // Circuit diagram (simplified)
          #canvas(length: 1cm, {
            import draw: *
            
            // Background
            rect((-0.5, -0.5), (8.5, 3), fill: gray.lighten(80%), stroke: none)
            
            // Lines
            content((-1.2, 2.2), text(size: 12pt)[D])
            content((-1.2, 1.2), text(size: 12pt)[A1])
            content((-1.2, 0.2), text(size: 12pt)[A2])
            
            line((0, 2.2), (8, 2.2), stroke: black)
            line((0, 1.2), (8, 1.2), stroke: black)
            line((0, 0.2), (8, 0.2), stroke: black)
            
            // Gates on D
            let gates-d = ((0.5, gate-green, "h#sub[D]"), (2, gate-blue, "c#sub[D]"), (3.5, gate-yellow, "e#sub[D]"), (5, gate-green, "h#sub[D]"))
            for (x, c, label) in gates-d {
              rect((x, 1.8), (x + 1, 2.6), fill: c, stroke: gray)
              content((x + 0.5, 2.2), text(size: 10pt)[#label])
            }
            
            // Gates on A1
            let gates-a1 = ((0.5, gate-orange, "h#sub[1]"), (1.25, gate-orange, "h#sub[1]"), (2, gate-red, "b#sub[1]"), (3.5, gate-purple, "d#sub[1]"), (4.25, gate-purple, "d#sub[1]"), (5, gate-orange, "h#sub[1]"))
            for (x, c, label) in gates-a1 {
              rect((x, 0.8), (x + 0.7, 1.6), fill: c, stroke: gray)
              content((x + 0.35, 1.2), text(size: 8pt)[#label])
            }
            
            content((4, -0.5), text(size: 14pt)[X-error check])
          })
        ],
        [
          // Pulse sequence plot
          #canvas(length: 1cm, {
            import draw: *
            
            // Axes
            line((0, 0), (0, 4), stroke: black)
            line((0, 0), (6, 0), stroke: black)
            
            content((-0.3, 4.5), text(size: 10pt)[Pulse sequence])
            content((-1.5, 2.5), anchor: "south", text(size: 9pt)[Rabi])
            content((-1.5, 1.5), anchor: "north", text(size: 9pt)[freq.])
            content((3, -0.8), text(size: 10pt)[Time (#sym.mu\s)])
            
            // Sample pulse shapes
            // Gaussian-like pulse
            for i in range(0, 20) {
              let t = i * 0.25
              let amp = 2 * calc.exp(-calc.pow(t - 2.5, 2) / 2)
              if i > 0 {
                let t-prev = (i - 1) * 0.25
                let amp-prev = 2 * calc.exp(-calc.pow(t-prev - 2.5, 2) / 2)
                line((t-prev, amp-prev + 2), (t, amp + 2), stroke: (paint: accent-gold, thickness: 1.5pt))
              }
            }
            
            // Step functions
            line((0, 2), (1, 2), stroke: (paint: green, thickness: 1.5pt))
            line((1, 2), (1, 3), stroke: (paint: green, thickness: 1.5pt))
            line((1, 3), (2, 3), stroke: (paint: green, thickness: 1.5pt))
            line((2, 3), (2, 2), stroke: (paint: green, thickness: 1.5pt))
            
            line((3, 2), (4, 2), stroke: (paint: blue, thickness: 1.5pt))
            line((4, 2), (4, 2.5), stroke: (paint: blue, thickness: 1.5pt))
            line((4, 2.5), (5, 2.5), stroke: (paint: blue, thickness: 1.5pt))
          })
        ]
      )
      
      #v(0.2in)
      
      #grid(
        columns: (1fr, 1fr),
        gutter: 0.2in,
        [
          // 9-atom cluster diagram
          #canvas(length: 1cm, {
            import draw: *
            
            let sp = 2
            
            // Draw grid
            for i in range(0, 3) {
              line((i * sp, 0), (i * sp, 2 * sp), stroke: (paint: accent-blue, thickness: 2pt))
              line((0, i * sp), (2 * sp, i * sp), stroke: (paint: accent-blue, thickness: 2pt))
            }
            
            // Draw atoms with numbers
            // Data qubits (corners) - blue
            let data-pos = ((0, 0, "1"), (2*sp, 0, "2"), (0, 2*sp, "3"), (2*sp, 2*sp, "4"))
            for (x, y, n) in data-pos {
              circle((x, y), radius: 0.5, fill: gradient.radial(data-blue.lighten(40%), data-blue, center: (30%, 30%), radius: 100%), stroke: accent-blue)
              content((x, y), text(size: 14pt, fill: white, weight: "bold")[#n])
            }
            
            // Ancilla qubits - red (edges and center)
            let anc-pos = ((sp, 0, "6"), (0, sp, "7"), (2*sp, sp, "8"), (sp, 2*sp, "9"), (sp, sp, "5"))
            for (x, y, n) in anc-pos {
              circle((x, y), radius: 0.4, fill: gradient.radial(ancilla-red.lighten(40%), ancilla-red, center: (30%, 30%), radius: 100%), stroke: none)
              content((x, y), text(size: 12pt, fill: white, weight: "bold")[#n])
            }
            
            // State label
            content((sp, 2*sp + 1.2), text(size: 14pt)[$|00000 angle.r$])
          })
        ],
        [
          // Population plot
          #canvas(length: 1cm, {
            import draw: *
            
            // Axes
            line((0, 0), (0, 4), stroke: black)
            line((0, 0), (6, 0), stroke: black)
            
            content((3, 4.5), text(size: 11pt)[Quantum State Populations (Initial: |+++++#sym.angle.r)])
            content((-1.2, 2.5), anchor: "south", text(size: 9pt)[Pop-])
            content((-1.2, 1.5), anchor: "north", text(size: 9pt)[ulation])
            content((3, -0.6), text(size: 10pt)[Time (#sym.mu\s)])
            
            // Y-axis labels
            content((-0.3, 0), text(size: 9pt)[0.0])
            content((-0.3, 2), text(size: 9pt)[0.5])
            content((-0.3, 4), text(size: 9pt)[1.0])
            
            // Plot line - population staying near 1
            line((0, 4), (1, 3.9), stroke: (paint: accent-blue, thickness: 2pt))
            line((1, 3.9), (2, 3.7), stroke: (paint: accent-blue, thickness: 2pt))
            line((2, 3.7), (3, 1.5), stroke: (paint: accent-blue, thickness: 2pt))
            line((3, 1.5), (4, 3.7), stroke: (paint: accent-blue, thickness: 2pt))
            line((4, 3.7), (5, 3.9), stroke: (paint: accent-blue, thickness: 2pt))
            line((5, 3.9), (6, 4), stroke: (paint: accent-blue, thickness: 2pt))
            
            // Legend
            content((5.5, 3.5), text(size: 9pt)[$|"+++++>" angle.r$])
          })
        ]
      )
    ]
  )
]

// ============================================================================
// SLIDE 9: Single Error Detection
// ============================================================================
#page[
  #slide-title[The protocol correctly identifies a single-qubit error and triggers the appropriate correction.]
  
  #grid(
    columns: (1fr, 1.3fr),
    gutter: 0.3in,
    [
      #text(size: 26pt, weight: "bold")[Scenario 2: Single Error]
      #v(0.1in)
      
      #text(size: 22pt)[We introduce a single X-error (a bit flip) on one data qubit.]
      #v(0.15in)
      
      #text(size: 24pt, weight: "bold")[Detection:] #text(size: 22pt)[After the parity-check sequence, the two ancillas neighboring the flipped qubit correctly transition to the |1#sym.angle.r state, flagging the precise location of the error. All other ancillas remain in |0#sym.angle.r.]
      #v(0.15in)
      
      #text(size: 24pt, weight: "bold")[Correction:] #text(size: 22pt)[The state of these two ancillas then triggers the double-controlled correction gate, which successfully flips the data qubit back to its correct state.]
    ],
    [
      // Circuit with error
      #canvas(length: 1cm, {
        import draw: *
        
        // Background
        rect((-1, -0.5), (14, 4), fill: gray.lighten(85%), stroke: none)
        
        // X-error check region (dashed box)
        rect((4, 0), (8, 3.5), stroke: (paint: green.darken(20%), dash: "dashed", thickness: 2pt), fill: none)
        content((6, 3.8), text(size: 12pt)[X-error check])
        
        // Lines
        content((-2, 2.8), text(size: 14pt)[Data D])
        content((-2, 1.8), text(size: 14pt)[Ancilla A1])
        content((-2, 0.8), text(size: 14pt)[Ancilla A2])
        
        line((0, 2.8), (13, 2.8), stroke: black)
        line((0, 1.8), (13, 1.8), stroke: black)
        line((0, 0.8), (13, 0.8), stroke: black)
        
        // Gates
        let gate-w = 0.8
        let gates = (
          (0.5, 2.8, "h#sub[D]", gray.lighten(20%)),
          (1.5, 2.8, "c#sub[D]", gray.lighten(20%)),
          (2.5, 2.8, "e#sub[D]", gray.lighten(20%)),
          (3.5, 2.8, "h#sub[1]", gate-orange),
          (4.5, 2.8, "b#sub[1]", gate-red),
          (5.5, 2.8, "d#sub[1]", gate-purple),
          (6.5, 2.8, "h#sub[1]", gate-orange),
        )
        
        for (x, y, label, c) in gates {
          rect((x, y - 0.35), (x + gate-w, y + 0.35), fill: c, stroke: gray)
          content((x + gate-w/2, y), text(size: 10pt)[#label])
        }
        
        // A1 gates
        let a1-gates = (
          (3.5, 1.8, "h#sub[1]", gate-orange),
          (4.5, 1.8, "b#sub[1]", gate-red),
          (5.5, 1.8, "d#sub[1]", gate-purple),
          (6.5, 1.8, "h#sub[1]", gate-orange),
        )
        for (x, y, label, c) in a1-gates {
          rect((x, y - 0.35), (x + gate-w, y + 0.35), fill: c, stroke: gray)
          content((x + gate-w/2, y), text(size: 10pt)[#label])
        }
        
        // OR gate label
        content((4.5, 0.2), text(size: 12pt, fill: accent-gold)[OR gate])
        
        // Connection dots
        circle((4.9, 1.8), radius: 0.1, fill: gray)
        line((4.9, 1.8), (4.9, 0.8), stroke: gray)
        circle((4.9, 0.8), radius: 0.1, fill: gray)
        
        // C2NOT
        circle((11.5, 1.8), radius: 0.1, fill: gray)
        line((11.5, 1.8), (11.5, 0.8), stroke: gray)
        circle((11.5, 0.8), radius: 0.25, stroke: green.darken(20%), fill: none)
        line((11.5, 0.55), (11.5, 1.05), stroke: green.darken(20%))
        line((11.25, 0.8), (11.75, 0.8), stroke: green.darken(20%))
        
        content((11.5, 0), text(size: 12pt, fill: accent-gold)[C2NOT])
      })
      
      #v(0.2in)
      
      #grid(
        columns: (1fr, 1.2fr),
        gutter: 0.2in,
        [
          // 9-atom cluster with error
          #canvas(length: 1cm, {
            import draw: *
            
            let sp = 1.8
            
            // Draw grid
            for i in range(0, 3) {
              line((i * sp, 0), (i * sp, 2 * sp), stroke: (paint: accent-blue, thickness: 2pt))
              line((0, i * sp), (2 * sp, i * sp), stroke: (paint: accent-blue, thickness: 2pt))
            }
            
            // Data qubits
            let data-pos = ((0, 0, "1"), (2*sp, 0, "3"), (0, 2*sp, "6"), (2*sp, 2*sp, "9"))
            for (x, y, n) in data-pos {
              circle((x, y), radius: 0.45, fill: gradient.radial(data-blue.lighten(40%), data-blue, center: (30%, 30%), radius: 100%), stroke: none)
              content((x, y), text(size: 12pt, fill: white, weight: "bold")[#n])
            }
            
            // Ancilla qubits - gray (inactive)
            let anc-gray = ((sp, 0, "2"), (0, sp, "4"), (2*sp, sp, "5"), (sp, 2*sp, "7"))
            for (x, y, n) in anc-gray {
              circle((x, y), radius: 0.35, fill: gray.lighten(30%), stroke: none)
              content((x, y), text(size: 10pt, fill: white)[#n])
            }
            
            // Error marker (red X)
            let err-x = sp
            let err-y = sp
            circle((err-x, err-y), radius: 0.35, fill: data-blue, stroke: none)
            content((err-x, err-y), text(size: 10pt, fill: white)[7])
            
            // Red X overlay
            line((err-x - 0.3, err-y - 0.3), (err-x + 0.3, err-y + 0.3), stroke: (paint: red, thickness: 3pt))
            line((err-x - 0.3, err-y + 0.3), (err-x + 0.3, err-y - 0.3), stroke: (paint: red, thickness: 3pt))
          })
        ],
        [
          // Population dynamics plot
          #canvas(length: 1cm, {
            import draw: *
            
            // Axes
            line((0, 0), (0, 5), stroke: black)
            line((0, 0), (7, 0), stroke: black)
            
            content((3.5, 5.5), text(size: 11pt)[Quantum State Populations vs. Time (#sym.mu\s)])
            content((-1.2, 3), anchor: "south", text(size: 9pt)[Pop-])
            content((-1.2, 2), anchor: "north", text(size: 9pt)[ulation])
            content((3.5, -0.6), text(size: 10pt)[Time (#sym.mu\s)])
            
            // Y-axis labels
            for (y, label) in ((0, "0.0"), (1, "0.2"), (2, "0.4"), (3, "0.6"), (4, "0.8"), (5, "1.0")) {
              content((-0.4, y), text(size: 8pt)[#label])
            }
            
            // X-axis labels
            for (x, label) in ((0, "0.00"), (1.75, "0.05"), (3.5, "0.10"), (5.25, "0.15"), (7, "0.20")) {
              content((x, -0.3), text(size: 8pt)[#label])
            }
            
            // Initial state (blue) - decaying
            let pts-blue = ((0, 5), (1, 4.5), (2, 3.5), (3, 2), (4, 1), (5, 0.5), (6, 0.3), (7, 0.2))
            for i in range(0, pts-blue.len() - 1) {
              line(pts-blue.at(i), pts-blue.at(i + 1), stroke: (paint: accent-blue, thickness: 2pt))
            }
            
            // Syndrome state (olive) - rising
            let pts-olive = ((0, 0), (1, 0.5), (2, 1.5), (3, 3), (4, 4), (5, 4.5), (6, 4.7), (7, 4.8))
            for i in range(0, pts-olive.len() - 1) {
              line(pts-olive.at(i), pts-olive.at(i + 1), stroke: (paint: olive, thickness: 2pt))
            }
            
            // Legend
            line((4.5, 4.8), (5.2, 4.8), stroke: (paint: accent-blue, thickness: 2pt))
            content((6, 4.8), text(size: 9pt)[Initial State])
            
            line((4.5, 4.2), (5.2, 4.2), stroke: (paint: olive, thickness: 2pt))
            content((6.2, 4.2), text(size: 9pt)[Syndrome State (|..1..1..#sym.angle.r)])
          })
        ]
      )
    ]
  )
]

// ============================================================================
// SLIDE 10: Tensor Network Simulations
// ============================================================================
#page[
  #slide-title[Tensor network simulations are used to verify the protocol's performance on scalable quantum systems.]
  
  #grid(
    columns: (1fr, 1.5fr),
    gutter: 0.4in,
    [
      #text(size: 24pt, weight: "bold", fill: accent-gold)[The Challenge:] #text(size: 22pt)[Simulating large quantum systems is classically intractable due to the exponential growth of the Hilbert space.]
      #v(0.25in)
      
      #text(size: 24pt, weight: "bold", fill: accent-gold)[The Method:] #text(size: 22pt)[We use Matrix Product States (MPS), a type of tensor network, to efficiently represent the quantum state. This method accurately captures the system's entanglement structure, allowing for simulations of larger arrays.]
      #v(0.25in)
      
      #text(size: 24pt, weight: "bold", fill: accent-gold)[Implementation:] #text(size: 22pt)[The 2D atom array is mapped to a 1D chain for the MPS simulation. We use the time-dependent variational principle (TDVP) to accurately evolve the state under the QEC pulse sequence.]
    ],
    [
      // MPS mapping diagram
      #canvas(length: 1cm, {
        import draw: *
        
        let sp = 2.2
        
        // 2D array (4x4)
        for row in range(0, 4) {
          for col in range(0, 4) {
            let x = col * sp
            let y = (3 - row) * sp
            
            // Connection lines (snake pattern)
            if col < 3 {
              let next-x = (col + 1) * sp
              bezier((x + 0.4, y), (next-x - 0.4, y), (x + 0.8, y - 0.3), (next-x - 0.8, y - 0.3), stroke: (paint: accent-gold, thickness: 2pt))
            }
            
            // Determine color based on position
            let c = if calc.rem(row + col, 2) == 0 {
              data-blue
            } else if calc.rem(row, 2) == 0 {
              ancilla-green
            } else {
              ancilla-red
            }
            
            circle((x, y), radius: 0.45, fill: gradient.radial(c.lighten(40%), c, center: (30%, 30%), radius: 100%), stroke: none)
          }
        }
        
        // Row connection lines
        for row in range(0, 3) {
          let y1 = (3 - row) * sp
          let y2 = (3 - row - 1) * sp
          let x = if calc.rem(row, 2) == 0 { 3 * sp } else { 0 }
          bezier((x, y1 - 0.4), (x, y2 + 0.4), (x + 0.5, y1 - 0.8), (x + 0.5, y2 + 0.8), stroke: (paint: accent-gold, thickness: 2pt))
        }
        
        // Arrow to 1D chain
        line((8, 3.3), (10, 3.3), stroke: (paint: black, thickness: 2pt), mark: (end: "stealth"))
        content((9, 4), text(size: 16pt)[Snake-like])
        content((9, 3.6), text(size: 16pt)[Mapping])
        
        // 1D chain (vertical)
        let chain-x = 13
        let chain-start-y = 7
        
        // Draw 32 atoms in vertical chain with colors
        let chain-colors = (data-blue, ancilla-green, data-blue, ancilla-red) * 8
        for i in range(0, 16) {
          let y = chain-start-y - i * 0.55
          let c = chain-colors.at(calc.rem(i, 4))
          circle((chain-x, y), radius: 0.35, fill: gradient.radial(c.lighten(40%), c, center: (30%, 30%), radius: 100%), stroke: none)
        }
        
        // Labels
        content((chain-x + 1.5, chain-start-y), text(size: 14pt)[1-16])
        content((chain-x + 1.5, chain-start-y - 4.5), text(size: 14pt)[17-24])
        content((chain-x + 1.5, chain-start-y - 8), text(size: 14pt)[25-32])
      })
    ]
  )
]

// ============================================================================
// SLIDE 11: Error Correction Results
// ============================================================================
#page[
  #slide-title[Active error correction maintains >99.998% ground state probability, while uncorrected states rapidly decay.]
  
  #grid(
    columns: (1fr, 1.3fr),
    gutter: 0.4in,
    [
      #text(size: 22pt)[We simulated 10 full QEC cycles on a 4x4 toric code (32 qubits), applying random Pauli errors each cycle. The results show a stark contrast:]
      #v(0.2in)
      
      #list(
        marker: text(size: 20pt)[#sym.bullet],
        spacing: 0.2in,
        [#text(fill: ancilla-red, weight: "bold")[With Correction (Red Line):] The system's probability of being in the correct ground state remains near unity. The protocol effectively finds and fixes errors, preserving the logical information.],
        [#text(fill: accent-blue, weight: "bold")[Without Correction (Blue Line):] Errors accumulate unchecked. The ground state probability decays steadily to approximately 60% after just 10 cycles, indicating significant information loss.],
      )
    ],
    [
      #align(center)[
        #text(size: 22pt, weight: "bold")[Ground State Probability: With vs. Without Error Correction]
        #v(0.2in)
        
        // Plot
        #canvas(length: 1cm, {
          import draw: *
          
          let plot-w = 14
          let plot-h = 9
          
          // Axes
          line((0, 0), (0, plot-h), stroke: black)
          line((0, 0), (plot-w, 0), stroke: black)
          
          // Y-axis labels and grid
          for (y, label) in ((0, "0.4"), (1.5, "0.5"), (3, "0.6"), (4.5, "0.7"), (6, "0.8"), (7.5, "0.9"), (9, "1.0")) {
            content((-0.8, y), text(size: 14pt)[#label])
            line((0, y), (plot-w, y), stroke: (paint: gray.lighten(50%), thickness: 0.5pt))
          }
          
          // X-axis labels
          for i in range(0, 6) {
            let x = i * 2.8
            content((x, -0.6), text(size: 14pt)[#(i * 2)])
            line((x, 0), (x, -0.2), stroke: black)
          }
          
          // Axis labels
          content((-2.5, plot-h/2 + 1.5), anchor: "south", text(size: 12pt)[Probability])
          content((-2.5, plot-h/2 - 1.5), anchor: "north", text(size: 12pt)[(Ground State)])
          content((plot-w/2, -1.5), text(size: 16pt)[Round Number])
          
          // With correction (red) - stays near 1.0
          let red-pts = ()
          for i in range(0, 11) {
            let x = i * 1.4
            let y = 9 - 0.01 * i  // Very slight decay
            red-pts.push((x, y))
            // Square markers
            rect((x - 0.15, y - 0.15), (x + 0.15, y + 0.15), fill: maroon, stroke: maroon)
          }
          for i in range(0, red-pts.len() - 1) {
            line(red-pts.at(i), red-pts.at(i + 1), stroke: (paint: maroon, thickness: 2pt))
          }
          
          // Without correction (blue) - decays
          let blue-pts = ()
          for i in range(0, 11) {
            let x = i * 1.4
            let y = 9 - i * 0.45  // Decay to ~60%
            blue-pts.push((x, y))
            // Circle markers
            circle((x, y), radius: 0.2, fill: accent-blue, stroke: accent-blue)
            // Error bars
            line((x, y - 0.3), (x, y + 0.3), stroke: accent-blue)
            line((x - 0.1, y - 0.3), (x + 0.1, y - 0.3), stroke: accent-blue)
            line((x - 0.1, y + 0.3), (x + 0.1, y + 0.3), stroke: accent-blue)
          }
          for i in range(0, blue-pts.len() - 1) {
            line(blue-pts.at(i), blue-pts.at(i + 1), stroke: (paint: accent-blue, thickness: 2pt))
          }
          
          // Legend
          rect((6, 2), (6.3, 2.3), fill: maroon, stroke: maroon)
          line((5.7, 2.15), (6.6, 2.15), stroke: (paint: maroon, thickness: 2pt))
          content((8.5, 2.15), text(size: 14pt)[With Error Correction])
          
          circle((6.15, 1), radius: 0.15, fill: accent-blue, stroke: accent-blue)
          line((5.7, 1), (6.6, 1), stroke: (paint: accent-blue, thickness: 2pt))
          content((8.8, 1), text(size: 14pt)[Without Error Correction])
        })
      ]
    ]
  )
]

// ============================================================================
// SLIDE 12: Comparison Table
// ============================================================================
#page[
  #slide-title[The measurement-free approach offers a 1-2 order of magnitude speedup in QEC cycle time.]
  
  #v(0.3in)
  
  #align(center)[
    #table(
      columns: (2fr, 2.5fr, 2.5fr),
      inset: 15pt,
      stroke: (x, y) => if y == 0 { (bottom: 2pt + black) } else { (bottom: 1pt + gray) },
      fill: (x, y) => if x == 2 and y > 0 { rgb("#e8eef4") } else if y == 0 { rgb("#f0f0e8") } else { none },
      align: center + horizon,
      
      [#text(size: 26pt, weight: "bold")[Feature]],
      [#text(size: 26pt, weight: "bold")[Conventional\ Measurement-Based QEC]],
      [#text(size: 26pt, weight: "bold")[This Work:\ Measurement-Free QEC]],
      
      [#text(size: 24pt)[Syndrome Readout]],
      [#text(size: 24pt)[Slow (~100--500 #sym.mu\s)]],
      [#text(size: 24pt)[Coherent & Fast (< 10 #sym.mu\s)]],
      
      [#text(size: 24pt)[Atom Shuttling]],
      [#text(size: 24pt)[Required]],
      [#text(size: 24pt, weight: "bold")[Not required] (Static Array)],
      
      [#text(size: 24pt)[Local Addressing]],
      [#text(size: 24pt)[Required (Complex hardware)]],
      [#text(size: 24pt, weight: "bold")[Not required] (Global Pulses)],
      
      [#text(size: 24pt)[Classical Feedback]],
      [#text(size: 24pt)[Required]],
      [#text(size: 24pt, weight: "bold")[Not required] (Autonomous)],
      
      [#text(size: 24pt)[Cycle Time]],
      [#text(size: 24pt)[~1 ms]],
      [#text(size: 24pt, weight: "bold")[~10--100 #sym.mu\s]],
      
      [#text(size: 24pt)[Ancilla Overhead]],
      [#text(size: 24pt)[1 auxiliary species]],
      [#text(size: 24pt)[2 auxiliary species]],
    )
  ]
  
  #v(0.4in)
  
  #align(center)[
    #text(size: 28pt)[The tradeoff of requiring a second ancilla species is vastly outweighed by the dramatic reduction in cycle time and hardware complexity.]
  ]
]

// ============================================================================
// SLIDE 13: Conclusion
// ============================================================================
#page[
  #slide-title[This protocol provides a viable pathway toward hardware-efficient, fault-tolerant quantum computation.]
  
  #grid(
    columns: (1fr, 1.2fr, 1fr),
    gutter: 0.3in,
    [
      #list(
        marker: text(size: 20pt)[#sym.bullet],
        spacing: 0.2in,
        [We have designed and validated a measurement-free and movement-free QEC protocol for the toric code.],
        [By combining a multi-species architecture with global, species-selective pulses, the scheme eliminates the primary bottlenecks of measurement latency and atom shuttling.],
      )
    ],
    [
      // Central figure - toric code lattice with laser effects
      #canvas(length: 1cm, {
        import draw: *
        
        let sp = 1.8
        
        // Draw some "laser beam" effects in background
        for i in range(0, 5) {
          let y = i * sp - 1
          rect((-1, y - 0.3), (11, y + 0.3), fill: if calc.rem(i, 2) == 0 { blue.transparentize(85%) } else { green.transparentize(85%) }, stroke: none)
        }
        
        // Draw lattice
        for row in range(0, 5) {
          for col in range(0, 5) {
            let x = col * sp + 1
            let y = row * sp
            
            // Grid lines
            if col < 4 {
              line((x, y), (x + sp, y), stroke: (paint: white.darken(20%), thickness: 1pt))
            }
            if row < 4 {
              line((x, y), (x, y + sp), stroke: (paint: white.darken(20%), thickness: 1pt))
            }
          }
        }
        
        // Draw atoms
        for row in range(0, 5) {
          for col in range(0, 5) {
            let x = col * sp + 1
            let y = row * sp
            
            // Determine color and label
            let (c, label) = if calc.rem(row + col, 2) == 0 {
              (data-blue, "D")
            } else if calc.rem(row, 2) == 0 {
              (ancilla-green, "A1")
            } else {
              (ancilla-red, "A2")
            }
            
            circle((x, y), radius: 0.5, fill: gradient.radial(c.lighten(30%), c.darken(20%), center: (30%, 30%), radius: 100%), stroke: none)
            content((x, y), text(size: 10pt, fill: white, weight: "bold")[#label])
          }
        }
      })
    ],
    [
      #list(
        marker: text(size: 20pt)[#sym.bullet],
        spacing: 0.2in,
        [Pulse-level and tensor network simulations confirm the protocol's ability to coherently detect and autonomously correct errors, maintaining high fidelity over many cycles.],
        [This approach significantly reduces QEC cycle times and simplifies experimental complexity, accelerating progress in neutral atom quantum computing.],
      )
    ]
  )
]

// ============================================================================
// SLIDE 14: Future Directions
// ============================================================================
#page[
  #slide-title[The measurement-free paradigm opens several compelling directions for future research.]
  
  #grid(
    columns: (1fr, 1.5fr),
    gutter: 0.3in,
    [
      #text(size: 24pt, weight: "bold")[Key areas for future work include:]
      #v(0.2in)
      
      #list(
        marker: text(size: 20pt)[#sym.bullet],
        spacing: 0.18in,
        [#bold-label[Scaling to Larger Codes:] Demonstrating error suppression with higher-distance toric codes.],
        [#bold-label[Exploring Advanced Codes:] Adapting the protocol to other promising code families like concatenated or LDPC codes.],
        [#bold-label[Rigorous Fault-Tolerance Analysis:] Performing a full noise threshold analysis under realistic experimental conditions.],
        [#bold-label[Implementing Logical Gates:] Extending the framework to perform universal logical operations on the encoded qubits.],
        [#bold-label[Near-Term Experimental Demonstration:] Realizing the protocol in existing dual-species Rydberg atom arrays.],
      )
    ],
    [
      // Scaling visualization - small to large lattice
      #canvas(length: 1cm, {
        import draw: *
        
        // Small lattice (left)
        let small-sp = 1.5
        let small-offset = (0, 5)
        
        for row in range(0, 4) {
          for col in range(0, 4) {
            let x = col * small-sp + small-offset.at(0)
            let y = row * small-sp + small-offset.at(1)
            
            // Lines
            if col < 3 { line((x, y), (x + small-sp, y), stroke: gray) }
            if row < 3 { line((x, y), (x, y + small-sp), stroke: gray) }
            
            let c = if calc.rem(row + col, 2) == 0 { data-blue } 
                    else if calc.rem(row, 2) == 0 { ancilla-green } 
                    else { ancilla-red }
            circle((x, y), radius: 0.35, fill: gradient.radial(c.lighten(40%), c, center: (30%, 30%), radius: 100%), stroke: none)
          }
        }
        
        // Arrow
        line((6, 7), (8, 7), stroke: (paint: black, thickness: 2pt), mark: (end: "stealth"))
        
        // Large lattice (right) - more atoms, smaller
        let large-sp = 0.7
        let large-offset = (9, 2)
        
        for row in range(0, 10) {
          for col in range(0, 8) {
            let x = col * large-sp + large-offset.at(0)
            let y = row * large-sp + large-offset.at(1)
            
            // Lines (denser)
            if col < 7 { line((x, y), (x + large-sp, y), stroke: (paint: gray.lighten(30%), thickness: 0.5pt)) }
            if row < 9 { line((x, y), (x, y + large-sp), stroke: (paint: gray.lighten(30%), thickness: 0.5pt)) }
            
            let c = if calc.rem(row + col, 2) == 0 { data-blue } 
                    else if calc.rem(row, 2) == 0 { ancilla-green } 
                    else { ancilla-red }
            circle((x, y), radius: 0.2, fill: gradient.radial(c.lighten(40%), c, center: (30%, 30%), radius: 100%), stroke: none)
          }
        }
        
        // Circuit elements on the right
        let circ-x = 18
        let circ-y = 7
        
        // Some circuit symbols
        circle((circ-x, circ-y), radius: 0.5, stroke: black, fill: none)
        line((circ-x, circ-y - 0.5), (circ-x, circ-y + 0.5), stroke: black)
        
        rect((circ-x - 0.4, circ-y - 2.5), (circ-x + 0.4, circ-y - 1.5), stroke: black, fill: none)
        content((circ-x, circ-y - 2), text(size: 12pt)[$H$])
      })
    ]
  )
]
