
#import "@preview/touying:0.6.1": *
#import "lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/unequivocal-ams:0.1.2": ams-article, theorem, proof
#import "@preview/cetz:0.3.2": canvas, draw

#set text(black, font: "New Computer Modern")
// 定义字体颜色
#let primary-color = rgb("#1f77b4")  // 蓝色
#let error-color = rgb("#d62728")  // 红色
#let dark-blue = rgb("#1a365d")
#let accent-gold = rgb("#ac7c01")
#let gate-blue = rgb("#60a5fa")
#let gate-yellow = rgb("#d9d02e")
#let gate-orange = rgb("#fb923c")
#let gate-red = rgb("#f87171")
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
== Quimb simulation
-- Simulation: Use the time- evolving block decimation (TEBD) to evolve the MPS with package `https://github.com/jcmgray/quimb.git` .

#text(weight: "bold", fill: primary-color)[Key Components:]

    #text(size: 16pt)[
    ```
    OMQuTensor_quimb/
    ├── src/omqutensor_quimb/
    │   ├── lattices/        # Geometry
    │   └── gates_and_circuits/
    │       ├── Toric_code_ground.py
    │       ├── continuous_revision.py
    │       └── measurement.py
    └── examples/
        └── ground_state_circuit/
    ```
    ]


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

== Simulation Mechanism: MPS with TEBD-style Gate Application

#text(weight: "bold", fill: primary-color, size: 18pt)[Key Clarification:] The simulation uses #text(weight: "bold")[CircuitMPS] which stores the quantum state as MPS and applies gates using #text(weight: "bold")[TEBD-style SVD truncation].

#text(weight: "bold", fill: error-color)[Bottom line:] CircuitMPS uses TEBD's core algorithm (SVD truncation) but without Trotter decomposition.


// == TEBD-style Gate Application in CircuitMPS
// #text(weight: "bold", fill: primary-color)[The `gate_split_` Method:]

//     This is the #text(weight: "bold")[same method used by TEBD] for applying 2-qubit gates:

//     1. #text(weight: "bold")[Contract]: Merge MPS tensors at sites $i, j$ with gate tensor $U$
//       //  $ T_"combined" = T_i times.circle T_(i+1) times.circle U_"gate" $

//     2. #text(weight: "bold")[Reshape]: Form matrix for SVD
//       //  $ M["left", "right"] $

//     3. #text(weight: "bold")[SVD]: Decompose
//        $ M = U Sigma V^dagger $

//     4. #text(weight: "bold")[Truncate]: Keep singular values where:
//        - $sigma_k >$ `cutoff` (default: $10^(-10)$)
//        - Total kept $<=$ `max_bond` (default: 128)

//     5. #text(weight: "bold")[Update]: Replace MPS tensors



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

== Why This Approach is Fast for QEC Simulation

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #text(weight: "bold", fill: primary-color)[1. No Trotter Decomposition Needed]

    Traditional TEBD for Hamiltonian evolution:
    $ e^(-i H t) approx (e^(-i H_"odd" delta t) e^(-i H_"even" delta t))^(t\/delta t) $

    This introduces #text(fill: error-color)[Trotter error] $O(delta t^n)$.

    Our QEC simulation uses #text(weight: "bold")[discrete gates]:
    $ U = U_n dots.c U_2 U_1 $

    Gates are applied #text(weight: "bold")[exactly] - only truncation error,
  ],
  [
    #text(weight: "bold", fill: primary-color)[3. Efficient Truncation Strategy]

    - `cutoff=1e-10`: Discard singular values $< 10^(-10)$
    - `max_bond=128`: Hard limit prevents memory explosion
    - Truncation error per gate: $epsilon approx sqrt("cutoff") approx 3 times 10^(-6)$

    #text(weight: "bold", fill: primary-color)[4. Hybrid GPU/CPU Workflow]

    #table(
      columns: (auto, auto),
      align: (left, left),
      stroke: 0.5pt,
      inset: 4pt,
      [#text(weight: "bold")[Operation]], [#text(weight: "bold")[Device]],
      [Gate application], [GPU (fast)],
      [SVD truncation], [GPU (fast)],
      [Measurement], [CPU (classical)],
      [Fidelity calc.], [CPU (classical)],
    )
  ],
)

== Error Correction Cycle: Hybrid GPU/CPU Workflow

#text(weight: "bold", fill: primary-color)[Single Correction Cycle:]

#figure(
  canvas(length: 0.99cm, {
    import draw: *

    // Boxes for each step
    let box-height = 1.5
    let box-width = 4
    let y-pos = 0

    // Step 1: GPU
    rect((0, y-pos), (box-width, y-pos + box-height), fill: gate-blue.lighten(70%), stroke: gate-blue)
    content((box-width/2, y-pos + box-height/2), text(size: 10pt)[1. Create CircuitMPS])
    content((box-width + 0.5, y-pos + box-height/2), text(size: 9pt, fill: gate-blue)[GPU])

    // Arrow
    line((box-width + 1.5, y-pos + box-height/2), (box-width + 2.5, y-pos + box-height/2), mark: (end: ">"))

    // Step 2: GPU
    rect((box-width + 3, y-pos), (2*box-width + 3, y-pos + box-height), fill: gate-blue.lighten(70%), stroke: gate-blue)
    content((1.5*box-width + 3, y-pos + box-height/2), text(size: 10pt)[2. Apply Error])
    content((2*box-width + 3.5, y-pos + box-height/2), text(size: 9pt, fill: gate-blue)[GPU])

    // Arrow
    line((2*box-width + 4.5, y-pos + box-height/2), (2*box-width + 5.5, y-pos + box-height/2), mark: (end: ">"))

    // Step 3: GPU
    rect((2*box-width + 6, y-pos), (3*box-width + 6, y-pos + box-height), fill: gate-blue.lighten(70%), stroke: gate-blue)
    content((2.5*box-width + 6, y-pos + box-height/2), text(size: 10pt)[3. Correction Round])
    content((3*box-width + 6.5, y-pos + box-height/2), text(size: 9pt, fill: gate-blue)[GPU])

    // Second row
    let y-pos2 = -2.5

    // Step 4: Transfer
    rect((0, y-pos2), (box-width, y-pos2 + box-height), fill: gray.lighten(70%), stroke: gray)
    content((box-width/2, y-pos2 + box-height/2), text(size: 10pt)[4. Transfer to CPU])

    // Arrow down
    line((3*box-width + 6 - box-width/2, y-pos - 0.2), (box-width/2, y-pos2 + box-height + 0.2), mark: (end: ">"), stroke: (dash: "dashed"))

    // Arrow
    line((box-width + 0.5, y-pos2 + box-height/2), (box-width + 2.5, y-pos2 + box-height/2), mark: (end: ">"))

    // Step 5: CPU
    rect((box-width + 3, y-pos2), (2*box-width + 3, y-pos2 + box-height), fill: gate-orange.lighten(70%), stroke: gate-orange)
    content((1.5*box-width + 3, y-pos2 + box-height/2), text(size: 10pt)[5. Measure & Reset])
    content((2*box-width + 3.5, y-pos2 + box-height/2), text(size: 9pt, fill: gate-orange)[CPU])

    // Arrow
    line((2*box-width + 4.5, y-pos2 + box-height/2), (2*box-width + 5.5, y-pos2 + box-height/2), mark: (end: ">"))

    // Step 6: CPU
    rect((2*box-width + 6, y-pos2), (3*box-width + 6, y-pos2 + box-height), fill: gate-orange.lighten(70%), stroke: gate-orange)
    content((2.5*box-width + 6, y-pos2 + box-height/2), text(size: 10pt)[6. Compute Fidelity])
    content((3*box-width + 6.5, y-pos2 + box-height/2), text(size: 9pt, fill: gate-orange)[CPU])
  })
)

#v(0.3in)

#text(weight: "bold", fill: primary-color)[Why hybrid?] 

GPU excels at tensor operations; 

CPU needed for measurement (classical processing).

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

•  #text(weight: "bold", fill: black, size:18pt)[Near-Term Experimental Demonstration:]

Realizing the protocol in existing dual-
species Rydberg atom arrays.


== Present focus

•  #text(weight: "bold", fill: black, size:18pt)[Simulation with TDVP method:]

Advantages: 

TDVP avoids the compounding local truncation errors of TEBD, providing more accurate evolution within the MPS manifold.

Avoiding using SWAP gates for long-range interactions, reducing circuit depth and computational expense.

Difficulties:

When performing three-qubit gate, the local TDVP projector needs to act on a larger window, increasing computational cost.




For higher accuracy and efficiency, use the local time-dependent variational principle (TDVP) method for MPS evolution with Julia language.

- Possible cause: the three qubit gate simulation: truncation error and swap gate overhead.

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



== References

#set text(size: 14pt)
#set par(leading: 0.6em)

#bibliography(
  "reference.bib",
  title: none,
  style: "ieee",
)