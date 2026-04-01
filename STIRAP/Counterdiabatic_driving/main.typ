#import "@preview/clean-math-paper:0.2.0": *
#import "@preview/cetz:0.3.2": canvas, draw, tree, vector, decorations

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Shortcut to adiabatic population transfer in quantum three-level systems: Effective two-level problems and feasible counterdiabatic driving",
  authors: (
    (name: "Han Wang", affiliation-id: 1, orcid: "0000-0000-0000-0000"),
    //(name: "Author 2",  affiliation-id: "2,*"),
  ),
  affiliations: (
    (id: 1, name: "HKUST(GZ)", address: "Guangzhou, China"),
   // (id: 2, name: "Affiliation 2, Address 2"),
   // (id: "*", name: "Corresponding author")
  ),
  date: date,
  heading-color: rgb("#0000ff"),
  link-color: rgb("#008002"),
  abstract: [In this paper, they mainly concentrate on a stimulated Raman shortcut-to-adiabatic passage in quantum three-level systems. They intend to achieve the counterdiabatic driving without additional coupling. ],
  keywords: ("measurement-free error correction", "multi-species array", "parity-gate", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

= Introduction
In order to achieve high-fidelity state transfer, they use adiabatic approaches including rapid adiabatic passage and stimulated Raman adiabatic passage and relevant variants. These adiabatic methods are robust against parameter fluctuations, but considering dissipation and decoherence effects, the fast and high-fidelity quantum state control are required.

In this paper, they proposed the stimulated Raman shortcut-to-adiabatic passage in quantum three-level systems by only modifying the shapes of the pump and Stokes pulses. 

= Model
#figure(
  image("model.png", width: 50%),
)
Hamiltonian:$ H = planck.reduce/2[Omega_p (t) * (|1⟩⟨2| + |2⟩⟨1|) + Omega_s (t) * (|2⟩⟨3| + |3⟩⟨2|) + Delta * |2⟩⟨2| + delta_s * |3⟩⟨3|)] $

where, $Omega_p (t)$ and $Omega_s (t)$ are the Rabi frequencies of the pump and Stokes fields, respectively. $Delta = (E_2-E_1)\/planck.reduce - omega_p$ is the one-photon detuning between the pump field and the transition $|1⟩ <-> |2⟩$, and $delta_s = Delta - [(E_2 - E_3)\/planck.reduce - omega_s]$ is the two-photon detuning. Assuming $delta_s = 0$, in order to keep in dark state, there are two adiabatic conditions: $|dot(theta)(t)| << sqrt(Omega_p^2 (t) + Omega_s^2 (t))$ and $ t_f * sqrt(Omega_p^2 (t) + Omega_s^2 (t)) >> 1$.

== Reproducing STIRAP within a shorter time
=== Additional coupling
Applying counterdiabatic driving, the total Hamiltonian becomes: $H(t) = H_0 (t) + H_"cd" (t)$, where $H_"cd" (t) = i planck.reduce * sum_n |partial_t n⟩⟨n|$ is the counterdiabatic term.

$ H_"cd" = planck.reduce/2 mat(0, 0, i*Omega_a (t); 0, 0, 0; -i*Omega_a (t), 0, 0) $
with $Omega_a (t) = 2 * [dot(Omega)_p (t)Omega_s (t) - dot(Omega)_s (t)Omega_p (t)]\/[Omega_p^2 (t) + Omega_s^2 (t)]$. It can be implemented by a microwave field directly coupling the two ground states $|1⟩$ and $|3⟩$.

=== two-photon resonance
Assuming that the large intermediate-level detuning $Delta >> Omega_p (t), Omega_s (t)$ and two photon resonance $delta_s$, the three-level system can be reduced to an effective two-level system by adiabatically eliminating the intermediate state $|2⟩$. The effective Hamiltonian is:

$ H_"eff" (t) = planck.reduce/2 mat(-Delta_"eff" (t), Omega_"eff" (t); Omega_"eff" (t), Delta_"eff" (t)) $
where, $ Delta_"eff" (t) = [Omega_p^2 (t) - Omega_s^2 (t)]\/4Delta $ $ Omega_"eff" (t) = - Omega_p (t)Omega_s (t)\/2Delta $. 

The counterdiabatic term is: $ H_"cd" (t) = planck.reduce/2 mat(0, - i*Omega_a (t); i*Omega_a (t), 0) $ 
with $ Omega_a (t) = [dot(Delta)_"eff" (t)Omega_"eff" (t) - dot(Omega)_"eff" (t)Delta_"eff" (t)]\/[(Omega_"eff"^2 (t) + Delta_"eff"^2 (t))]$.

The total Hamiltonian is: $ H(t) = planck.reduce/2 mat(-Delta_"eff" (t), sqrt(Omega^2_"eff" (t) + Omega^2_a (t))*exp(-i Phi); sqrt(Omega^2_"eff" (t) + Omega^2_a (t))*exp(i Phi), Delta_"eff" (t)) $ where $Phi = "arctan"[Omega_a (t)\/Omega_"eff" (t)]$.

Applying the unitary transformation $U(t) = mat(exp(-i Phi (t)\/2), 0; 0, exp(i Phi (t)\/2))$. Thus, the $ overline(H)_"eff" = U^dagger H(t) U - i planck.reduce U^dagger U$. And we can inversly use the effective two-level Hamiltonian to design the pump and Stokes pulses.

- Simulation results

- Initial pulse shapes:
#figure(
  image("pulse.png", width: 80%),
)

- population transfer:
#figure(
  image("population.png", width: 80%),
)
- Modified pulse shapes:
#figure(
  image("pulse_mod.png", width: 80%),
)

- population transfer:
#figure(
  image("population_mod.png", width: 80%),
)
