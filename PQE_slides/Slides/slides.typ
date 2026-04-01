#import "@preview/touying:0.6.1": *
#import "lib.typ": *

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
    title: [Measurement-Free Error Correction in Rydberg atom array],
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
== Motivation
- Developing a #red-text[one-step parity check] process with #red-text[global pulse sequence] in #red-text[Rydberg atom system] without multi-step movements of atoms. 

- The errored qubit can be corrected by the ancilla qubits #red-text[without measurement] (Ancilla qubits acts as control qubits and errored data qubit as target qubit.@Heu_en_2024)

== Model
- Three different species.(Blue$->$data qubits; red/green$->$ancilla qubit A2/A1)
- Parity check: (Z-error in plaquette A2), (X-error in plaquette A1)
- Strong interaction between different species, weak interaction between same species.
#figure(
  image("threespecies.png", width: 49%),
)
== Syndrome extraction can be done with parity-check process
- We intend to perform #red-text[parity-check process] (with the ancilla qubit acts as target qubit and the neighboring data qubit acts as control qubit)

-- no error $->$ all qubits keep invariant after the effective pulse sequence.

-- X-error $->$ neighboring ancilla qubit A1(green dots) will flip.

-- Z-error $->$ neighboring ancilla qubit A2(red dots) will flip.
#figure(
  image("flip.png", width: 50%),
)
== Parity check process is hard to design with global pulse sequence
- The one-step parity check process is not easy to implement:
-- We intend that only when #red-text[the number of errored data qubits is odd, the neighboring ancilla qubit A1 will flip.]

- In Rydberg atom system:

-- Parity check under blockade effect.

-- Parity check under interaction-conpensation scheme(anti-blockade effect).

== Parity check can be implemented equivalently on gate level @PhysRevA.96.052320
- In one plaquette, we can use hardmard gates to #red-text[exchange the control and target qubits.] 

- The effective parity check can be implemented with #red-text[ancilla qubit as control qubit and data qubit as target qubit.]

#figure(
  image("effect.png", width: 42%),
)

== Global pulse implements different circuit

- Overlapped data qubits:
#figure(
  image("overlapped.png", width: 90%),
)
- For global pulse sequence, we need to change the gate scheme mentioned above $=>$ #red-text[implement the operation shown in left-hand circuit through one global pulse.]



// == Effective parity-check process
// - pulse sequence to #red-text[verify] the effectiveness of the designed pulse sequence:
// #figure(
//   image("sequence.png", width: 80%),
// )
// - Effect of different pulses: 
// -- Pulse $h_D$/$h_1$/$h_2$: act on D/A1/A2, Hadamard gate

// -- Pulse $b_1$/$b_2$: act on A1/A2, state transition $|1 angle.r arrow.l.r |r angle.r$
// -- Pulse $c_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, state transition $|0 angle.r arrow.l.r |1 angle.r$, otherwise, do nothing. Note: it is a composite pulse, also known as the EIT pulse.
// -- Pulse $d_1$/$d_2$: act on A1/A2, state transition $|0 angle.r arrow.l.r |r angle.r$
// -- Pulse $e_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, do nothing, otherwise, state transition $|0 angle.r arrow.l.r |1 angle.r$

// -- Pulse $R_1$/$R_2$: act on A1/A2, state transition $|? angle.r arrow.r |0 angle.r$ (reset)

// - Based on the rules in pulse sequence, we can perform the simulaton to prove the effectiveness of the parity check process.


== Main problem:
- Hard to construct one-step multi-qubit parity gate for perfect parity check. 

 $=>$ We construct effective gate for parity check

- Because of the interactions between data qubits and ancilla qubits, I cannot determine the minimum unit for gate-level  pulse design. 

$=>$ We simulate to verify the effectiveness of the designed pulse sequence.

//- The direct analysis of the effective parity check process in this large system is not easy to perform. 

- feasibility of the designed gate scheme in large system(experimental perspective)(for example, more than 2 species).
== Appendix: Multi-qubit CNOT gate
// - If we assume that there is only one plaquette in the system, for example, we only consider data qubits 2,3,5,6 and one ancilla qubit b. The effective parity check can be implemented through $"CNOT"_4$ gate and Hadamard gates.

// #figure(
//   image("circuit.png", width: 29%),
// )
- In order to perform the $"CNOT"_4$ gate, we intend to use Rydberg blockade effect and:

-- When ancilla qubit is in state $|0 angle.r$, the data qubits are unchanged.

-- When ancilla qubit is in state $|1 angle.r$, the data qubits are flipped.

- For example: 
#figure(
  image("energy_level.png", width: 33%),
)


== Appendix: Parity Gate scheme
- The overlapped data qubit requires that when both neighboring ancilla qubits are in state $|1 angle.r$ or $|0angle.r$, the target data qubit will be unchanged.@guo2025paritycontrolledgatetwodimensionalneutralatom 

#figure(
  image("parity.png", width: 60%),
)
- The scheme is implemented through anti-blockade effect which requires accurate control of the interaction strength between data qubits and ancilla qubits.
// == Appendix: Effective parity check
// - However, in the real model, we need to consider larger system. Each data qubit is influenced by both neighboring ancilla qubits and each ancilla qubit is influenced by four neighboring data qubits. Thus, after applying a Hadamard gate, the entanglement between data qubits and ancilla qubits is not easy to control.
// #figure(
//   image("threespecies.png", width: 45%),
// )

- Double control considered(whether the parity gate scheme can achieve effective parity check):
$ |0_c 0_c 0_t angle.r arrow.l.r |0_c 0_c 0_t angle.r  $
$ |0_c 1_c 0_t angle.r arrow.l.r |0_c 1_c 1_t angle.r  $
$ |1_c 0_c 0_t angle.r arrow.l.r |1_c 0_c 1_t angle.r  $
$ |1_c 1_c 0_t angle.r arrow.l.r |1_c 1_c 0_t angle.r  $

== Appendix: Error correcting $C_2"NOT"$ gate
- For example, if there is a Z-error happens on data qubit 5, the parity check will flip the neighboring red ancilla qubits b,c. Then, we can perform a $C_2"NOT"$ gate for error correction where the two flipped neighboring ancilla qubits act as control qubits and the errored data qubit acts as target qubit.

- Rule: Only if the ancilla qubits are both in state $|1 angle.r$, the target data qubit will be flipped.

== Appendix: Error correcting $C_2"NOT"$ gate
- gate scheme:
#figure(
  image("2qubitgate.png", width: 80%),
)

- The $C_2"NOT"$ gate can be constructed through the EIT effect and the Rydberg blockade effect.
== Literature Review
1. Construction of multi-qubit $"CNOT"_k$ gate through EIT:@PhysRevA.96.052320, through optimization of the pulse@kazemi2025multiqubitparitygatesrydberg, through adiabatic pulse design@PhysRevLett.128.120503@photonics10111280 and experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501; Parity gate construction through specially designed interaction strength@guo2025paritycontrolledgatetwodimensionalneutralatom.

2. Measurement-free fault-tolerant quantum error correction:@Heu_en_2024

3. Mid-circuit correction of correlated phase errors using an array of spectator qubits@Singh2023

4. mesoscopic Rydberg gate based on EIT:@PhysRevLett.128.120503. Experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501

5. There is a scheme familiar to this work in one plaquette.@photonics10111280


== Reference
#bibliography("ref.bib")

