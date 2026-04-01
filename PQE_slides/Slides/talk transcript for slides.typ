// Talk Transcript for PhD Qualifying Exam
// Optical Control of Rydberg Atom Array
// Han Wang, HKUST(GZ)

#set document(title: "Talk Transcript - Optical Control of Rydberg Atom Array", author: "Han Wang")
#set page(margin: 1in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.8em)
#set heading(numbering: "1.1")

#align(center)[
  #text(size: 18pt, weight: "bold")[Talk Transcript]
  #v(0.1in)
  #text(size: 14pt)[Optical Control of Rydberg Atom Array: \ A Measurement-Free and Movement-Free Protocol Using Multi-Species Atoms and Global Control]
  #v(0.1in)
  #text(size: 12pt)[Han Wang | HKUST(GZ) | PhD Qualifying Exam]
]

#v(0.3in)
#line(length: 100%, stroke: 0.5pt)
#v(0.2in)

= Title Slide

Good evening, professors. My name is Wang Han, thank you very much for your presence at my PhD qualifying exam. Today, I will present my research on "Optical Control of Rydberg Atom Array," with a particular focus on a measurement-free and movement-free quantum error correction protocol using multi-species atoms and global control.

#v(0.2in)

= Outline

In this presentation, I will first summerize the main works of my research and I will introduce the neutral atom platform and expain why we use it at our research. Then, I will propose a error correction protocol that eliminates the time required in measurement and movement process and I will present the numerical simulation results and conclude the future prospects.

// In this presentation, I will cover the following topics: First, I will summarize the main works of my research. Then, I will introduce the neutral atom platform and explain why it is the primary platform for our research. Following that, I will present our error correction protocol that eliminates measurement and movement requirements. Finally, I will discuss our numerical simulation methods and results, and conclude with future prospects.

#v(0.2in)

= Summary of Works - Main Works

My research focuses on the optical control of Rydberg atom arrays for quantum computing applications. 

I participated in a work for a flexible adjustment of spot arrays using a diffractive optical element, spatial light modulator. This is of great importance for building large scale neutral atom platforms.

 And the second work is the main focus of today's presentation, which is a measurement-free and movement-free quantum error correction protocol using global pulse sequences in Rydberg atom platform. The work aims to eliminate the operation time during error correction process. Speed up the error correction cycle will decrease the environment noises and improve the overall performance of quantum error correction.

// *Work 1 - Large-scale Atom Array Generation:* I participated in research on large-scale atom array generation using Spatial Light Modulators with an automatic differentiation-based method for flexible adjustment. This provides the foundation for creating the physical platform needed for quantum computing.

// *Work 2 - Measurement-free and Movement-free QEC Protocol:* This is the primary focus of today's presentation. We address a measurement-free and movement-free quantum error correction protocol in the Rydberg atom platform using global pulse sequences. This work aims to overcome critical bottlenecks in current quantum error correction implementations by eliminating the need for slow measurements and atom movements.

#v(0.2in)

= Hardware: Neutral Atom Platform - What is Neutral Atoms

Let me first introduce the neutral atom platform for quantum computing.

*Core Concept:* We use individual atoms, typically Rubidium or Cesium, as qubits.

The whole system locates in vacuum chamber ..., and we use highly focused laser beams to.....

In order to generate such a system, we need the diffractive optical element shown above, the spatial light modulator. We initially disign a target spot array pattern, then we use algorithms to calculate the phase pattern corresponding to the array geometry and display it on the SLM. The SLM imprints the phase profile onto the incoming laser beam. The output beam is focused by an objective lens and produces the desired array of optical tweezers at the focal plane.

// *Trapping:* We use "optical tweezers," which are highly focused laser beams, to hold individual atoms in place. Each tweezer creates a microscopic trap that can confine a single atom.

// *Isolation:* The atoms are placed in a vacuum chamber, which isolates them from environmental noise and allows for long coherence times.

// *Generating Spot Arrays:* We use a Spatial Light Modulator, or SLM, to create configurable arrays of optical tweezers. The SLM is a programmable diffractive element that imprints a phase profile onto the laser beam. As shown in the figure, the SLM-generated hologram produces the desired pattern of tweezers at the focal plane, allowing us to arrange atoms in arbitrary configurations.

#v(0.2in)

= Hardware: Neutral Atom Platform - How It Works: The Rydberg State

But, how can we use neutral atoms to perform quantum operations? for example. How can we entangle those qubits? How can we store information in those qubits?

1.  quantum information is stored in its internal energy levels. Different energy levels means different states of a qubit. For example, We denote these as $|0 angle.r$ and $|1 angle.r$, which correspond to specific hyperfine ground states of the atom.

2. To make qubits talk to each other, we need to excite the valence electron of the atom to a very far place. This is called the Rydberg state with a very large principal quantum number n. The Rydberg states have large dipole moments, leading to a strong interaction between nearby atoms. In this figure, we use a laser to couple two states of an atom, however, because the interaction between two nearby atoms, the energy levels are shifted and the excitation of one atom can block the excitation of another. This is called the Rydberg blockade effect, which is the basis for implementing two-qubit gates.
// *The Interaction - Rydberg Blockade:* To make qubits "talk" to each other, we excite them to a Rydberg state. Rydberg states are highly excited atomic states with very large principal quantum numbers. When two nearby atoms are both excited to Rydberg states, they experience strong dipole-dipole interactions. This leads to the Rydberg blockade effect: if one atom is already in the Rydberg state, it prevents nearby atoms from being excited due to an energy shift. This conditional behavior is the basis for implementing two-qubit gates.

// #v(0.2in)

= Hardware: Neutral Atom Platform - Why Neutral Atoms? (Part 1)

It comes to the third question, why we use nutral atoms, First, we can achieve long-range interactions between atoms and it is tunable by adjusting the Rydberg state and interatomic distances. 

Second, the coherence times are very long compared to other platforms, Long coherence times are essential because they determine how long quantum information can be preserved before errors accumulate.

third, the gate fidelity is enough for error correction and increased rapidly in recent years. 

The last one is the scalability, which is perhaps the most striking advantage for fault-tolerant quantum computing, which requires large numbers of physical qubits for error correction. The neutral atom platform has achieved a 6,100-qubit milestone using Cesium atoms with 99.98% imaging survival. 
// *First, Strong and Tunable Interactions:* Neutral atoms exhibit long-range interactions when excited to Rydberg states. These interactions can be precisely controlled by adjusting the Rydberg state and interatomic distances.

// *Second, Long Coherence Times:* As shown in the data from the 6,100-atom array experiment, neutral atom platforms have demonstrated remarkable coherence times of up to 12.6 seconds. This is dramatically longer than superconducting qubits, which have achieved records of only 1.68 milliseconds. The table shows additional metrics: imaging survival of 0.9998952, imaging fidelity of 0.9999374, and vacuum lifetime of 22.9 minutes. Long coherence times are essential because they determine how long quantum information can be preserved before errors accumulate.

// *Third, High Gate Fidelity:* As shown in the comparison table, neutral atoms have achieved 99.5% fidelity in large-scale parallel operations on 60 atoms, and 99.9% in single-pair laboratory demonstrations. These fidelities are comparable to superconducting qubits at 99.93% and trapped ions at 99.99%. Importantly, neutral atoms have surpassed the 99% threshold, which is the critical requirement for surface code error correction. We've seen exponential improvement from approximately 90% in 2018 to over 99.5% in 2024.

// #v(0.2in)

// = Hardware: Neutral Atom Platform - Why Neutral Atoms? (Part 2)

// *Fourth, Exceptional Scalability:* This is perhaps the most striking advantage. The neutral atom platform has achieved a 6,100-qubit milestone using Cesium atoms with 99.98% imaging survival. The figure shows a representative single-shot and rearranged image of single cesium atoms across an 11,998-site tweezer array.

// In comparison, superconducting systems have reached 1,121 physical qubits with IBM's Condor processor, while trapped ion systems typically operate with 32 to 56 physical qubits. This scalability advantage of nearly an order of magnitude is crucial for fault-tolerant quantum computing, which requires large numbers of physical qubits for error correction.

// #v(0.2in)

= Quantum Error Correction - Basic Concepts

In neutral atom platform, a logical qubit is encoded in many physical qubits for preserving quantum information, if one pauli error hoccurs, the state is pushed out of the code space. we can detect and correct them to recover the logical information. This is called quantum error correction.

For example, I will introduce the Toric code. It is a topologically protected code defined on a toris shape geometry. The data qubits are located on the edges of the lattice and we use a string of Pauli operators and call them stabilizers to detect errors because they do not change the states within the code space. There are two types of stabilizers, the star operators S_s detect Z-type errors around a vertex and the plaquette operators P_p detect X-type errors around the plaquette. If there is an X-errpr occurs, the measurement results of the stabilizers will change from +1 to -1. When the eigenvalue of both star and plaquette operators are +1, the state isin the ground state, also within the code space.
// *Code Space and Redundancy:* In quantum error correction, we protect quantum information by encoding logical qubits into a larger physical space. The diagram illustrates this concept - within the full physical Hilbert space, we define a code space containing our logical states, represented by $|overline(0)angle.r$ and $|overline(1)angle.r$.`

// *Syndrome and Error Correction:* When a Pauli error occurs, the state is pushed out of the code space. The QEC algorithm detects this through syndrome measurement and applies corrections to return the state to the code space. The code distance d determines how many errors can be corrected.

// *Toric Code Hamiltonian:* We implement our protocol using the toric code, with Hamiltonian $H = -sum_s S_s - sum_p P_p$, where $S_s = product_(i in s) Z_i$ and $P_p = product_(j in p) X_j$. This is a topologically protected Hamiltonian that we perform on a rotated code lattice.

#v(0.2in)

= Quantum Error Correction on Neutral Atom Platform

However, during the error correction process in neutral atoms, the gate operation time is about order of 1 microsecond, while the measurement and movement operations are much slower, on the order of hundreds of microseconds. The quantum state decoherence during long operation times and introduces additional errors in the process.

// In quantum error correction on neutral atom platforms, there is a severe timing mismatch. As shown by the timeline arrow indicating time scale, quantum gate operations are incredibly fast, taking approximately 1 microsecond. However, conventional quantum error correction requires operations that are dramatically slower - on the order of hundreds of microseconds.

// *Quantum Gates:* Operations are incredibly fast, taking approximately 1 microsecond.

// *Correction Operations:* Conventional QEC requires operations that are dramatically slower:
- Mid-circuit Measurement: 100 to 500 microseconds using fluorescence detection
- Atom Shuttling/Movement: 10 to 100 microseconds

// *The Critical Consequence:* The quantum state decoheres during these long operation times, introducing additional errors that can negate the benefits of error correction.

#v(0.2in)

= Question

This leads us to the central question of my research: *Can we design a QEC protocol that eliminates both measurement and movement, using only fast, global quantum gates?*

In the neutral atom platform, we use the rotated toric code as our model system. We can put an ancilla qubit at the center of plaquette to detect different pauli errors with different quantum gates. For example, the center of red plaquette is used to detect Z-type errors with CNOT gates, while the center of blue plaquette is used to detect X-type errors with CZ gates. In previous solution, they need to move a pair of atoms to an isolated place and perform gate operation. However, if we use different atom species among data qubits, ancilla for X/Z-error correction, then we do not need to move atom pair and we can perform gate sets under global pulse sequence. 

#v(0.2in)

= Error Correction Protocol - Measurement-Free and Movement-Free QEC Protocol Overview

To address this challenge, we propose a measurement-free and movement-free quantum error correction protocol.

The gate operation requires moving the atoms to a entangling zone, and then moving them to readout zone for measurement and feedback correction. 

But in our protocol, we intend to use three different atomic species to encode data qubits, and ancillas. different species are sensitive to different laser frequencies, so we do not need to worry about the crosstalks.

// The schematic shows a logical processor split into three zones: storage, entangling, and readout. In the conventional approach, atoms must be shuttled between these zones. Our protocol eliminates this by keeping all atoms static in a multi-species lattice and applying global pulse sequences. The measurement step is replaced by fully coherent operations that map syndrome information onto ancilla qubits.

#v(0.2in)

= Error Correction Protocol - Model Architecture

Our model uses a static, three-species Rydberg atom array implementing the toric code space.

*Data Qubits (Species D):* These encode the logical information and are located at the vertices of a square lattice.

*Ancilla Qubits (Species A1):* These are used to detect Z-type errors and are located at the centers of the X-stabilizer plaquettes.

*Ancilla Qubits (Species A2):* These are used to detect X-type errors and are located at the centers of the Z-stabilizer plaquettes.

*Species-Selective Control:* The distinct atomic species have well-separated transition frequencies, allowing global laser pulses to address one species without affecting the others. This is the key insight that enables movement-free operation.

#v(0.2in)

= Error Correction Protocol - Cycle Phases

The full error correction cycle for one error type is executed in three main phases.

*Phase 1 - Error Check:* Information mapping from data qubits to ancilla qubits. The parity information from data qubits surrounding a plaquette is mapped onto the central ancilla qubit.

*Phase 2 - Error Correction:* The ancillas control the data qubits with conditional flip operations based on the syndrome pattern.

*Phase 3 - Reset:* The ancillas are reset to the ground state $|0 angle.r$ to prepare for the next error correction cycle.

This entire sequence is performed coherently without any measurements.

#v(0.2in)

= Error Correction Protocol - Movement-Free Error-Check Process (Single Plaquette)

Let me explain the error-check process in detail.

For a single plaquette, we need to implement CNOT gates from each of the four surrounding data qubits to the central ancilla. if one of the data is errored, the ancilla qubit will experence a state flip. 

However, in a global pulse sequence, there are more than one plaquettes operating simutaneously. Therefore, each data qubit is controlled by two neighboring ancilla qubits at the same time. The traditional CNOT gate should be restructured in the circuit to taking the global control into account. In our protocol, we found that A three-qubit OR gate and a C2-NOT gate can solve this conflict.

// *Implementation Constraint:* In a global pulse sequence, each data qubit is controlled by two neighboring ancilla qubits simultaneously. This creates a conflict because a naive implementation would cause unintended operations.

#v(0.2in)

// = Error Correction Protocol - Movement-Free Error-Check Process (Solution)

// *Solution:* We add a double-controlled NOT gate (CCNOT) followed by an OR-gate in the global pulse sequence to solve this conflict.

// The circuit diagram shows how the OR-gate logic resolves the situation where a data qubit sits between two ancilla plaquettes. The CCNOT gate ensures that corrections are only applied when the syndrome pattern unambiguously identifies the error location.

#v(0.2in)

= Error Correction Protocol - Pulse Sequence Design

Now. I will introduce the mechanism of these two gates:

*OR-Gate Design:* The OR-gate implements the logic where the target flips if either control qubit is excited. When one of controls is in $|1 angle.r$, the strong Rydberg interaction shifts the energy levels of the target qubit, allowing a transition among two ground states.

*C2-NOT Gate Design:* The CCNOT gate, when one of the atoms are in state 0, the Rydberg blockade effect prevent the excitation of the target qubit. Only when both control qubits are in state 1, the target qubit can be excited and flipped.
// Both gates exploit the strong Rydberg interactions. The dipole-dipole interaction $V_"dd"$ is much stronger than the Van der Waals interaction $V_"vdW"$, which allows us to engineer the desired conditional dynamics through careful pulse shaping.

#v(0.2in)

= Numerical Methods for Simulation - Unit Cell Tests (Setup)

We validated our protocol through pulse-level simulations on a unit cell.

The unit cell consists of data qubits (shown in blue) and ancilla qubits for X-error checking (shown in red). The pulse sequence shows the temporal profile of the laser fields, including Gaussian-shaped pulses for adiabatic operations.

#v(0.2in)

= Numerical Methods for Simulation - Unit Cell Tests (Results)

We simulated the full quantum dynamics of this system, tracking the evolution of the wavefunction under the designed pulse sequence.

The figures show the population dynamics under different initial conditions - both no-error and errored conditions. Our simulations confirm individual operation fidelities exceeding 99.8%.

#v(0.2in)

= Numerical Methods for Simulation - Bottlenecks in Pulse-Level Simulation

However, pulse-level simulation faces a fundamental scalability bottleneck.

*The Problem:* The Hilbert space size grows exponentially with the number of atoms. For N atoms, we need to track $2^N$ complex amplitudes. This quickly becomes computationally intractable for systems larger than about 20 atoms.

*The Solution - Tensor Networks:* We employ Matrix Product States, or MPS, to overcome this limitation. MPS efficiently represents quantum states by exploiting the structure of entanglement. They can accurately capture the system's entanglement structure while allowing for simulations of larger arrays.

#v(0.2in)

= Numerical Methods for Simulation - Simulation Results with QCA

We also explored Quantum Cellular Automata (QCA) approaches for simulation, which provide an alternative framework for understanding the dynamics of our error correction protocol. QCA abstracts continuous evolution into discrete, local update rules, which is useful for studying logical error propagation and topological thresholds on larger lattices.

#v(0.2in)

= Numerical Methods for Simulation - Tensor Networks (MPS)

Let me explain our MPS approach in more detail.

*Mechanism:* The global state is decomposed into a chain of local tensors connected by virtual bonds. The bond dimension controls the amount of entanglement that can be represented.

*Mapping:* We use a "snake" ordering path to map our 2D atom arrays to 1D MPS structures. This mapping preserves locality as much as possible, keeping the bond dimensions manageable.

*Simulation Method:* We use the time-evolving block decimation (TEBD) to evolve the MPS, implemented using the quimb package.

#v(0.2in)

= Numerical Methods for Simulation - Continuous Error-Correction Simulation with MPS

Using MPS, we performed continuous error-correction simulations where we add exactly one error between two correction rounds.

*With Correction (Orange Line):* The system's correction protocol is able to correct single errors, maintaining the system in the ground state.

*Without Correction (Blue Line):* The system rapidly deviates from the ground state due to accumulating errors.

This comparison clearly demonstrates the effectiveness of our measurement-free, movement-free error correction protocol.

#v(0.2in)

= Prospects

Looking forward, key areas for future work include:

*Realize in Surface Code:* Demonstrating error correction in the more experimentally relevant surface code, which has different geometry but is more commonly used in current experimental setups.

*More Realistic Conditions:* Exploring the performance under random errors, noise, atom loss, and other realistic imperfections that would be present in actual experiments.

#v(0.2in)

= Closing

Thank you for your attention. I would be happy to answer any questions you may have about the protocol design, simulation methods, or future directions of this research.

#v(0.3in)
#line(length: 100%, stroke: 0.5pt)
#v(0.1in)

// ========================================
// APPENDIX - Additional Slides for Q&A
// ========================================

#pagebreak()

#align(center)[
  #text(size: 16pt, weight: "bold")[Appendix - Additional Material for Q&A]
]

#v(0.2in)

= Appendix: Time-Evolving Block Decimation (TEBD)

TEBD is highly effective for circuits with limited entanglement growth and short-range interactions.

*Decompose:* The time-evolution operator is decomposed into a sequence of two-qubit gates via Trotter-Suzuki decomposition.

*Apply and Truncate:* Gates are applied and local truncation via Singular Value Decomposition keeps the bond dimension manageable.

#v(0.2in)

= Appendix: Limitations of TEBD

TEBD has two main limitations.

*Compounding Local Errors:* Truncation at each step leads to accumulated truncation errors. As shown in the schematic with progressively noisier waveforms, each truncation step introduces small errors that compound over time, requiring increasing bond dimension to maintain accuracy.

*Inefficient Handling of Long-Range Interactions:* Long-range gates require external SWAP gates to bring distant qubits to neighboring positions, which increases circuit depth and computational expense.

#v(0.2in)

= Appendix: Time-Dependent Variational Principle (TDVP)

TDVP provides more accurate evolution within the MPS manifold.

*Definition:* TDVP evolves the state $|Psi(A)angle.r$ within a restricted sub-manifold $cal(M)_D$ of the full Hilbert space $cal(H)$.

*Advantage:* It finds the provably optimal evolution path, ensuring most efficient use of MPS's representational capacity while avoiding compounding local truncation errors.

The diagram shows how the exact evolution tangent $(1/i) H u$ is orthogonally projected into the tangent space $T_u cal(M)$ of the MPS manifold, yielding the optimal effective evolution $P(u)(1/i) H u$.

#v(0.2in)

= Appendix: Local-TDVP Algorithm

We intend to develop a package for efficiently simulating large-scale Rydberg arrays with long-range interactions using the local-TDVP algorithm with Julia language.

*TDVP for Discrete Unitary Gates:* We treat each gate as a discrete time evolution $g_j = e^(-i H_j)$ with $delta t = 1$.

*Local-TDVP Method:* For a local gate generator H acting on qubits [k, k+q], the global TDVP projector can be approximated by a local projector acting only on the local window [k-1, k+q+1] surrounding the gate. This makes computation complexity independent of system size N, enabling simulation of much larger systems.

*Near-Term Experimental Demonstration:* We are working toward realizing this protocol in existing dual-species Rydberg atom arrays, bridging the gap between theory and experiment.

#v(0.3in)
#line(length: 100%, stroke: 0.5pt)
#v(0.1in)
#align(center)[
  #text(size: 10pt, fill: gray)[End of Transcript]
]
