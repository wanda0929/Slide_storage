
#import "@preview/touying:0.6.1": *
#import "lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#set text(black, font: "New Computer Modern")
#let colors = (maroon, olive, eastern)
// 定义字体颜色
#let primary-color = rgb("#1f77b4")  // 蓝色
#let error-color = rgb("#d62728")  // 红色
// 定义颜色辅助函数
#let blue-text(content) = text(fill: primary-color, content)
#let red-text(content) = text(fill: error-color, content)

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
    title: [Quantum Cellular Automata Simulation in Multi-species Rydberg Atom Array],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)

#title-slide()

#outline-slide()

// Extract methods
#show strong: alert
= Background
== Theoretical model
- Multi-species array
#figure(
  image("model.png", width: 80%),
)

== Global pulse sequence and level scheme
#figure(
  image("rules.png", width: 80%),
)

== Pulse shape
#figure(
  image("laser.png", width: 80%),
)

== Pulse-level simulaiton
- No flipped error
#figure(
  image("noerror.png", width: 35%),
)

- Single X-error
#figure(
  image("error.png", width: 35%),
)

= Quantum cellular automata
== cellular automata
#tblock(title: [What is CA (cellular automata)])[
  - Defination: CA consists of an array of identical cells, each of which can be in one of a finite number of states. The array evolves in discrete time steps according to a local, identical interaction rule.@doi:10.3233@Kari1999OnTC@TOFFOLI1977213
  - Cell state: each cell can take one of a finite number of possible states. 
  - Evolution: The whole array evolves in discrete time steps by iterating a function $G$, known as the global evolution. 
  // - Properties of Global Evolution ($G$):
    
  //   ◦ It is shift-invariant: it acts in the same way everywhere (homogeneity).
    
  //   ◦ It is local: information cannot be transmitted faster than some fixed number of cells per time step (causality).
  // - Role in Computing: CA are considered a physics-like model of computation because they share fundamental symmetries of theoretical physics, such as homogeneity and causality
]
// 特点一：平移不变性 (Shift-invariant) / 均匀性 (Homogeneity)
// • 简单来说： 这意味着规则在任何地方都一样。
// • 详细解释： 无论你观察元胞阵列的哪个位置，应用于该位置的演化规则（即 $G$）都是相同的。这在理论物理学中被称为均匀性（或同质性），指的是物理定律在时间和空间上的不变性。
// 特点二：局部性 (Local) / 因果关系 (Causality)
// • 简单来说： 这意味着信息传播速度是有限的。
// • 详细解释： 任何一个单元格在下一个时间步的状态，只取决于它附近的局部邻域（通常是少数相邻单元格）的状态。信息不能比某个固定数量的单元格/每时间步更快地传播。这种性质在物理学中被称为因果关系（Causality）。

// #tblock(title: [What is QCA])[
//   It can evolve automatically according to the local rules without any external control. 
// ]

// #figure(
//   image("CA1.png", width: 60%), 
//   caption: [
//     Cellular Automata
//   ],
// )

#figure(
  image("CA2.png", width: 60%), 
  caption: [
    Cellular Automata
  ],
)

#tblock(title: [CA (cellular automata) for universal computation])[
  Universal CA is universal for classical computation @10.5555-2, which, likes Turing machine, exhibits universality. 
]
#tblock(title: [Example: Game of Life (Universal for TM)])[
  CA have been widely used in the study of complex systems, such as the Game of Life by Conway.
  
  In 2D grid, each cell has 8 neighbors.

  If the cell is alive, then it stays alive if it has either 2 or 3 live neighbors
  
  If the cell is dead, then it springs to life only in the case that it has 3 live neighbors
]

#figure(
  image("Gameoflife.png", width: 45%), 
  caption: [
    Game of Life by Conway
  ],
)
== Quantum Cellular Automata
#tblock(title: [QCA@doi:10.3233-2@ARRIGHI20121883])[
  QCA is a quantum version of CA, which can perform quantum computation.
  - cells $arrow$ qubits
  - classical states $arrow$ quantum states(superposition)
  - local classical function $arrow$ unitary operator@Nagaj_2008
  Characteristics:
  - no external control (Low noise)
  - Evolution: evolve unitarily in discrete time steps
]
= QCA simulation in our system
== QCA simulation in our system
- Multi-species array
#figure(
  image("model.png", width: 80%),
)
== QCA simulation in our system

#figure(
  image("model1.png", width: 110%), 
  caption: [
    QCA simulation in our system
  ],
)

== QCA simulation in our system
Effect of different pulses
// - Pulse $h_D$/$h_1$/$h_2$: act on D/A1/A2, Hadamard gate
// - Pulse $b_1$/$b_2$: act on A1/A2, state transition $|1 angle.r arrow.l.r |r angle.r$
// - Pulse $c_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, state transition $|0 angle.r arrow.l.r |1 angle.r$, otherwise, do nothing. Note: it is a composite pulse, also known as the EIT pulse.
// - Pulse $d_1$/$d_2$: act on A1/A2, state transition $|0 angle.r arrow.l.r |r angle.r$
// - Pulse $e_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, do nothing, otherwise, state transition $|0 angle.r arrow.l.r |1 angle.r$
#figure(
  image("pulse.png", width: 80%),
)
== Lattice construction
purple points means data qubits and blue "x" means ancilla qubits.
#figure(
  image("lattice.jpeg", width:45%),
)

== Local rules
#figure(
  image("abox_cal.png", width: 80%),
)
// #figure(
//   table(
//     columns: 3,
//     align: (center, left, left),
//     stroke: 0.75pt,
//     table.header(
//       [*Step*], [*Operation*], [*Description*]
//     ),
//     [1], [Hadamard Rotation], [Apply $H$ gate to all qubits: $|psi angle.r arrow.r H^(times.circle 32) |psi angle.r$],
//     [2], [$pi$ Pulse (Ancilla)], [Apply $X$ gate to ancilla qubits $A = {11,13,14,16,19,21,22,24}$: \ $|psi angle.r arrow.r X_A |psi angle.r$, where $|1 angle.r arrow.l.r |r angle.r$],
//     [3], [Conditional EIT Pulse], [Apply conditional flip $c_D$ on data qubits: \ If $exists$ neighbor in $|r angle.r$: $|0 angle.r arrow.l.r |1 angle.r$],
//     [4], [$pi$ Pulse (Repeat)], [Repeat Step 2: $|psi angle.r arrow.r X_A |psi angle.r$],
//     [5], [C2NOT Operation], [Multi-controlled NOT on data qubits with \ ancilla controls: $|psi angle.r arrow.r "C2NOT"_(A arrow.r D) |psi angle.r$],
//     [6], [Hadamard Rotation], [Apply $H$ gate to all qubits: $|psi angle.r arrow.r H^(times.circle 32) |psi angle.r$],
//     [7], [State Extraction], [Measure computational basis: ${|0 angle.r, |1 angle.r}^(times.circle 32)$],
//   ),
//   caption: [
//     QCA evolution steps for measurement-free error detection in Rydberg atom array. The lattice contains 32 qubits total (16 data + 16 ancilla) with periodic boundary conditions. Ancilla qubits in set $A$ detect X-errors through parity checks implemented via global pulse sequences.
//   ],
// ) <tab:qca_algorithm>


// - Performing Hadamard rotation on all qubits(step1)
// - Defining and performing $pi$ pulse on ancilla qubits for X-error correction(11,13,14,16,19,21,22,24)(step2)
// - Defining and performing conditional EIT pulse on data qubits(step3).
// - Performing step 2.(step4)
// - Defining C2NOT pulse operation on data qubit and ancilla qubits(11,13,14,16,19,21,22,24) and apply it.(step5)
// - Performing Hadamard rotation on all qubits(step6)
// - Extracting the final state of the lattice(step7)

== Simulation results
#figure(
  image("results.png", width: 80%),
)
#figure(
  image("lattice.jpeg", width: 30%),
)

// - No error $=>$ The whole system keeps invariant

// - Initially, all qubits in system are in state $|0 angle.r$, there is a single X-error on data qubit 5. After the QCA process, the neighboring ancilla qubits 16, 19 flip to state $|1 angle.r$.

// - Initially, all data qubits in system are in state $|1 angle.r$, there is a single X-error on data qubit 5. After the QCA process, the neighboring ancilla qubits 13, 16, 19, 22 flip to state $|1 angle.r$.

== Periodic boundary condition:
#figure(
  image("periodiclattice.png", width:45%),
)
== bottleneck
- Periodic boundary condition: Requiring larger lattice to meet the condition.

- How to represent the state of the whole lattice with discrete steps of QCA evolution?


#bibliography("reference.bib")