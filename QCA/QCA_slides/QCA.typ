#import "@preview/touying:0.7.0": *
#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.4.5" as fletcher: node, edge
#import "lib.typ": *

// ── Theme + metadata ─────────────────────────────────────────

#show: hkustgz-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Quantum Cellular Automata design on Rydberg atoms arrays],
    author: [Han Wang],
    date: datetime.today(),
    institution: [香港科技大学],
  ),
)

// ── Fonts (Chinese + Latin) ──────────────────────────────────

#set text(font: ("Linux Libertine", "Source Han Sans SC", "Source Han Sans"))
#show strong: it => text(fill: rgb("#005bac"), it)

// ═════════════════════════════════════════════════════════════
// SECTION 1 – Background for quantum cellular automata
// ═════════════════════════════════════════════════════════════

= Background for quantum cellular automata
== Cellular Automata(CA)

#tblock(title: [What is CA (cellular automata)])[
  CA consists of an array of identical cells, each of which can be in one of a finite number of states. The cells update their states synchronously according to a local function G in discrete time steps.
]

#tblock(title: [What can CA (cellular automata) do?])[
  It can evolve automatically according to the local rules without any external control.
]

#figure(
  image("CA1.png", width: 70%),
  caption: [Cellular Automata],
)

#figure(
  image("CA2.png", width: 70%),
  caption: [Cellular Automata],
)

#tblock(title: [CA (cellular automata) for universal computation])[
  Universal CA is universal for classical computation @10.5555-2, which, likes Turing machine, exhibits universality.
]

#tblock(title: [Example: Game of Life （Universal for TM）])[
  CA have been widely used in the study of complex systems, such as the Game of Life by Conway.

  In 2D grid, each cell has 8 neighbors.

  If the cell is alive, then it stays alive if it has either 2 or 3 live neighbors

  If the cell is dead, then it springs to life only in the case that it has 3 live neighbors
]

#figure(
  image("Gameoflife.png", width: 45%),
  caption: [Game of Life by Conway],
)

// ═════════════════════════════════════════════════════════════
// SECTION 2 – Introduction of QCA
// ═════════════════════════════════════════════════════════════

= Introduction of QCA

== Quantum Cellular Automata

#tblock(title: [QCA])[
  QCA is a quantum version of CA, which can perform quantum computation.
  - cells = qubits
  - states = quantum states
  - local function G = unitary operator
  - no external control (Low noise)
]

#tblock(title: [Universality of QCA])[
  The QCA-related results are focus on universality.
  Proving the universality of QCA in the sense of Quantum Turing Machine @Watrous1995OnOQ is necessary.
  - Proving that the evolution operator of QCA can cover all the unitary operators.
  - Prove that QCA is equivalent to a known universal quantum gate set.
]

== Interesting works under QCA models

#tblock(title: [Main category])[
  - Construction of intrinsically universal QCA.@PhysRevLett.97.020502@ARRIGHI20121883
  - QCA for error correction. @Lang_2018@PhysRevLett.133.150601
  - QCA based on Rydberg atom array@Cesa_2023@PhysRevLett.124.070503
  - Many-body simulation with QCA.@PhysRevLett.125.100403,@PhysRevB.106.104309,@long2024topologicalphasesmanybodylocalized

  - Numerical simulation of QCA (under noise).@10.1063 @Hillberry_2021
  - Entanglement dynamics in QCA.@PhysRevA.68.042311,@pizzamiglio2024classificationqubitcellularautomata
]

== Intrinsically universal QCA

- Margolus partitioning: A general 2D lattice sites are partitioned into cells of size $2 times 2$
- Separate partitioning for different time steps. (Overlap)

#figure(
  image("Margolus's CA.png", width: 30%),
  caption: [Margolus's physics-like cellular automata],
)

#tblock(title: [Intrinsically universal 1D QCA])[
  - The 1D intrinsically universal QCA is able to simulate all other 1D QCA@doi:10.3233-2。
  - Universal QCA(multi-steps)->simulated QCA(one-step)
]

#figure(
  image("PQCA.png", width: 45%),
  caption: [Partitioned one-dimensional QCA with scattering unitary U which gets applied upon two cells. Time flows upwards.],
)

- Intrinsic simulation of a QCA by another:

#figure(
  image("Intrinsicsim.png", width: 34%),
  caption: [Intrinsic simulation of a QCA by another: The universal U-QCA and simulated V-QCA. In this case we need two cells of the U-QCA in order to encode one cell of the V-QCA, and we need to run the U-QCA for four time steps in order to simulate one time step of the V-QCA.],
)

#tblock(title: [Intrinsic Simulation @ARRIGHI20121883])[
  #figure(
    image("Intrinsicsimulation.png", width: 100%),
  )
]

#figure(
  image("Intrinsic.png", width: 41%),
  caption: [The concept of intrinsic simulation made formal.],
)

They proposed nD PQCA which can simulate all other nD PQCA and have arbitrary precision@ARRIGHI20121883. The key is to determine the universal scattered unitary.

#tblock(title: [Partitioned QCA (PQCA)])[
  The cells of QCA are devided into many non-overlapping blocks, and each block updates independently according to a specific rule. The blocks interact with each other in an alternating or staged manner, and the evolution rules are also processed in blocks. It is important to determine the universal scattered unitary.
]

#figure(
  image("PQCA.png", width: 70%),
  caption: [Partitioned one-dimensional QCA with scattering unitary U.],
)

#tblock(title: [Block QCA (BQCA)])[
  Quantisations of block representations of CA are generally presented as two-layer. We can assume that $U_i$ is the unitary operator that acts on the ith block of cells. The evolution of the QCA is given by the following figure:
]

#figure(
  image("2layerBQCA.png", width: 70%),
  caption: [Two-layer block representation QCA],
)

#tblock(title: [PQCA simulating BQCA])[
  The difference is that two layers of BQCA are different. Thus, we need to use a U defined PQCA, with a U capable of performing $U_0$ and $U_1$.
]

#figure(
  image("PQCAsimBQCA.png", width: 90%),
  caption: [PQCA simulating a BQCA: The QCA is decorated with control qubits following a simple encoding procedure (left), which allow the scattering unitary U (centre) to act as either U0 or U1, according to the layer (right). The black box can be any unitary.],
)

#tblock(title: [BQCA simulating QCA])[
  If we can use PQCA to simulate BQCA, we can achieve the simulation of QCA by PQCA.
]

#figure(
  image("BQCAsimQCA.png", width: 30%),
  caption: [BQCA simulating QCA.],
)

== QCA for error correction

#figure(
  image("1.png", width: 90%),
  caption: [QCA for error correction],
)

Error correction with CAs has been studied as a density-classification problem@PhysRevLett.133.150601

#tblock(title: [Density Classification problem])[
  The DC problem is a generalization of the majority problem, which is to determine whether the majority of cells are in a certain state.
]

#tblock(title: [Local majority voting])[
  If at least two of the three neighbors are 1, the updated state of the central cell is 1. Otherwise it is 0. For example, the evolution of 1D chain: [0 1 0 1 1 0 1 0 1]->[0 0 1 1 1 1 0 1 0]->[0 0 1 1 1 1 1 0 0]. If 1 is the majority in the initial state, it tends to be all 1 eventually. Conversely it goes to all zeros
]

#figure(
  image("Q232.png", width: 50%),
  caption: [Local majority voting],
)

#tblock(title: [Two-line voting (better performance under noise)])[
  QTLV can solve the majority voting problem under noise. It is A 2D CA model with high robust. There are top line and bottom line. The updated state depends on the states of the neighbors in both top line and bottom line.
]

#figure(
  image("QTLV.png", width: 50%),
  caption: [Two-line voting],
)

#tblock(title: [1D topological QEC with symmetry-constrained CA @Lang_2018])[
  - Focusing on the 1D Majorana chain
  - constructing a strictly local decoder based on self-dual CA for error correction
  Decoder: Scalability, with exponentially growing decoherence times in the presence of noise. (Essential for large-scale quantum storage).
]

#figure(
  image("2.png", width: 66%),
  caption: [1D topological QEC],
)

== QCA based on Rydberg atom arrays

#figure(
  image("3.png", width: 80%),
  caption: [Hamiltonian quantum cellular automata],
)

- global driving, without local addressing @Cesa_2023
- two different structures are proposed:
  - imprint the circuit onto the trap positions of the atoms and then apply pulses.
  - arrange the atoms in a circuit-independent way, with the algorithm completely encoded in the global driving sequence.

#figure(
  image("Arrangedcircuit.png", width: 50%),
  caption: [Atomic arrangement],
)

#tblock(title: [1D wires of atoms])[
  - qubit state($|Psi(k)angle.r$) is located at a single atom k.
  - After applying pulses: $ |Psi(k)angle.r ->|Psi(k+1)angle.r $
  - The qubit propagates through the wire as the pulses progress - defining an information flow.
]

#figure(
  image("circuitindependent.png", width: 70%),
  caption: [state transported through a wire via global pulses.],
)

#figure(
  image("4.png", width: 90%),
)

- Unitary (reversible) and non-Unitary (dissipative of intermediate state) QCA can be implemented with Rydberg atoms.@PhysRevLett.124.070503

#figure(
  image("PhysicalQCA.png", width: 33%),
  caption: [Rydberg QCA],
)

== Many-body simulation with QCA.

#figure(
  image("5.png", width: 90%),
)

#tblock(title: [Nonequilibrium Phase Transition in (1+1)D QCA])[
  - (1+1)D QCA, dimension of time and space.
  - Based on Domany-Kinzel cellular automaton
    - stationary behavior and nonequilibrium phase transitions despite being isolated systems
    - permitting the controlled introduction of local quantum correlations.
  - projected entangled pair state (PEPS) tensor networks for natural and efficient representation of the cellular automaton.@PhysRevLett.125.100403
]

== Many-body simulation with QCA.

#figure(
  image("6.png", width: 90%),
)

#tblock(title: [Topological Phases of Many-Body Localized Systems: Beyond Eigenstate Order])[
  - Many-body localization system, for instance, Anomalous localized topological phase, there eigenstates are trivial but the entire Hamiltonian cannot be deformed to a trivial localized model without going through a delocalization transition. @long2024topologicalphasesmanybodylocalized
  - Method: mapping complex MBL systems to QCA, and classifying ALTs by QCA rules.
]

== Numerical simulation of QCA (under noise).

#figure(
  image("12.png", width: 77%),
)

#tblock(title: [Performance of 1D quantum cellular automata in the presence of error])[
  - Based on Block QCA model, they consider realistic physical error including over- and under- rotations of quantum states during gate sequence, stochastic phase and bit flip errors, and undesired interactions with neighbors when carrying out single qubit operation (which can be eliminated through compensation method). @10.1063
]

#figure(
  image("13.png", width: 100%),
)

#tblock(title: [Entangled quantum cellular automata, physical complexity, and Goldilocks rules])[
  - Goldilocks Rule: The quantum rule is in intermediate state (not too active nor static) and result in complex behavior. @Hillberry_2021
]

== Entanglement dynamics in QCA.

#figure(
  image("10.png", width: 90%),
)

#tblock(title: [Entanglement dynamics and ergodicity breaking in QCA])[
  - QCA: classical rule that updates a site if its two neighbors are in the lower state.
  - showing that the breaking of ergodicity extends to chaotic states.
  - Reason of breaking of ergodicity: chiral quasiparticle excitations which propagate entanglement.@PhysRevB.106.104309
]

#figure(
  image("14.png", width: 90%),
)

#tblock(title: [Entanglement dynamics in one-dimensional quantum cellular automata])[
  - In general quantum computation, complex operation on certain qubits are required.
  - Quantum computation based on QCA requires only homogeneous local interactions that can be implemented in parallel.
  - In 1D Ising model, they show some minimal physical requirements for constructing QCA. And demonstrate optimal pulse sequence for information transport and entanglement distribution.
  - Some non-Unitary operation (environment disturbed situation) can generate environment assisted entanglement.@PhysRevA.68.042311
]

== Reference

#bibliography("reference.bib")
