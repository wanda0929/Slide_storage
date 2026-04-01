#import "@preview/touying:0.6.1": *
#import "lib.typ": *
#set cite(style:"apa")

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
    title: [Dual-species Rydberg array],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)

#title-slide()

//#outline-slide()

// Extract methods
#show strong: alert

== What are dual-species Rydberg arrays?
- Dual-species Rydberg atom arrays are quantum platforms that trap two different atomic species (e.g., Rb-Ce, Rb-Yb, or 87Rb-85Rb)
- Key features include: Multi-species trapping; Rydberg interactions; Individual control
#figure(
  image("heteronuclear.png", width: 55%)
)

== experimental realization
- 2D dual-species array@Sheng_2022
#figure(
  image("experimentalarray.png", width: 65%)
)

- A Rb-Cs dual-species magneto-optical trap@Shao2025@Xu:25

- Defect-free 2D mixed-species atom arrays@wei2025enhancedatombyatomassemblydefectfree@PhysRevX.12.011040@fang2025interleaveddualspeciesarrayssingle@Tao_2022
#figure(
  image("experimentalarray2.png", width: 55%)
)
== Other experimental realizations
- Preparation of a heteronuclear two-atom system in the three-dimensional ground state in an optical tweezer@PhysRevA.100.063429

- Balanced Coherence Times of Mixed-Species Atomic Qubits in a Dual 3 x 3
- Magic-Intensity Optical Dipole Trap Array@Guo_2020.

== Some questions:
- What are the capabilities of dual-species Rydberg arrays?
-- Avoiding crosstalk, enabling individual addressing, tunable and long-range interactions, speedup the quantum processor, fault-talerant QEC...

- Leading research: Saffman in 2016.(next page)

- Fault-tolerant QEC(page.10)






== What are the capabilities of dual-species Rydberg arrays?
- evading the crosstalk in neutral-atom array@Saffman_2016.
#figure(
  image("dualarray.png", width: 65%)
)
-- Cs(computation qubits), Rb(ancilla qubits for measurements) @PhysRevA.92.042710 for lossless and crosstalk-free quantum nondemolition (QND) state measurements.

-- An experimental paper@Covey2023
#figure(
  image("dualexper.png", width: 65%)
)

-- Green shaded qubits denote ancilla syndrome qubits used to measure stabilizer generators, and solid black qubits denote data qubits of
the planar code.@PhysRevA.96.052320
#figure(
  image("qecarray.png", width: 35%)
)

-- Auxiliary "spectator" qubits for probing noise and real-time correction of correlated errors@Singh2023. The dual-species array avoids the crosstalks. 
#figure(
  image("spectator.png", width: 55%)
)

-- Cs atoms are serve as ancella qubits and date qubits. Rb atoms are used for measurements@PhysRevA.110.042404.

#figure(
  image("measurement.png", width: 45%)
)
== What are the capabilities of dual-species Rydberg arrays?
- Single-species Rydberg arrays are limited to nearest-neighbor interactions, while dual-species Rydberg arrays can achieve long-range interactions.@PhysRevA.92.063407
#figure(
  image("long-range.png", width: 65%)
)

== What are the capabilities of dual-species Rydberg arrays?
- In quantum processor, the need of protecting memory coherence and enabling a fast qubit-photon interface. 
- Saffman.al using two species for memory and communication which coupled using interspecies Rydberg gates.@Young_2022@radnaev2025universalneutralatomquantumcomputer
#figure(
  image("processing.png", width: 65%)
)
== What are the capabilities of dual-species Rydberg arrays?
- Entanglement of heteronuclear Rydberg atoms with spectral isolation and inidividual addressing.@PhysRevLett.119.160502
#figure(
  image("heteronuclearentanglement.png", width: 30%)
)

- In realizing Rydberg quantum simulators, another species atomic qubit can work as an auxiliary qubit to manipulate the many-body spin interaction in target qubits, or provide a dissipative element when being optically pumped.@Weimer2010
#figure(
  image("simulator.png", width: 45%)
)

- Probing into the 1D dual-species Rydberg array based on Foster resonance:

-- demonstrating an interspecies Rydberg blockade and implement a quantum state transfer from one species to another.

-- generating a Bell state between Rb and Cs hyperfine qubits through an interspecies controlled-phase gate.

-- combining interspecies entanglement with a native midcircuit read-out to achieve quantum non-demolition measurements.

#figure(
  image("dualarray2.png", width: 65%)
)
== What are the capabilities of dual-species Rydberg arrays?
- In realizing the ground state of the fractonic X-cube model under the dual-species architecture, including cide qubits(blue) and ancella qubits(red)@nevidomskyy2024realizingfractonorderlongrange.

#figure(
  image("x-code.png", width: 38%)
)
== Reference
#bibliography("reference.bib")

