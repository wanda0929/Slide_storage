#import "@preview/touying:0.6.1": *
#import "lib.typ": *

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
    title: [Investigations on the multi-qubit gates and corresponding applications],
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

== Construction of the parity-controlled gate
- Construction of the parity-controlled gate
== Practical applications:
- Three-qubit repitition codes
- Rotated surface codes featuring XZZX stabilizers, enabling single-shot readout of stabilizer measurements.
- basic building blocks of quantum error correction and measurements.

== Model
#figure(
  image("model.png", width: 80%),
)
- Total Hamiltonian for two control atoms and one target atom: 
#figure(
  image("model2.png", width: 60%),
)
- Interaction Hamiltonian:
#figure(
  image("interaction.png", width: 64%),
)

- The interaction Hamiltonian $H_"dd"^1$ can be devided into two subspaces {DPD,DDP,PDD} and {DPP,PDP,PPD} and another interaction Hamiltonian $H_"dd"^2$ can be devided into three subspaces ${D Lambda P, P Lambda D}$, ${Lambda D P, Lambda P D}$, ${D P Lambda, P D Lambda}$.
- Under condition $J = Delta gt.double {|Omega_0|, |Omega_1|, |Omega_c|}$, the can discard some far-off resonant states and the notion $E_v^mu$ denotes the $mu$-th basis of $v$ subspace where $mu in {1,2,3}$, $v in {"DPD","DPP",D Lambda P, Lambda D P, D P Lambda}$:

#figure(
  image("hamitonian.png", width: 38%),
)

The Hamiltonian can be further reduced by condition alert($Omega_c>> {|Omega_0|, |Omega_1|}$). The effective form of the Hamiltonian is 
#figure(
  image("effectiveh.png", width: 80%),
)
#figure(
  image("nexth.png", width: 60%),
)

- Finally, the effective geometric evolution operator can be expressed as:
#figure(
  image("effective.png", width: 80%),
)

== parity gate(original H)
#figure(
  image("parity.png", width: 80%),
)

== parity gate (effective H)
#figure(
  image("parity2.png", width: 80%),
) 
== Reference
#bibliography("ref.bib")

