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
    title: [Non-Perturbative Floquet Engineering of the Toric-code Hamiltonian and its ground state],
    subtitle: none,
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)

== Main contents
- Difficulties of quantum gate construction in neutral-atom system.

- Adiabatic passage: Adiabatic rapid passage.

- Quantum gate construction with ARP pulse.

== Quantum computing in neutral-atom system

- High-fidelity two qubit gate based on blockade effect.@Beterov_2020

-- Difficulty: single-atom loss.
#figure(
  image("blockade.png", width: 70%),
)
- Mesoscopic atomic ensemble with single excitation can be regarded as a qubit.@Beterov_2020
-- advantage: reduced sensitivity to atom losses; enhanced coupling to light. 

-- difficulty: fluctuation of the number of atoms in the ensemble.
#figure(
  image("ensembleatoms.png", width: 62%),
)

== Traditional $pi$-pulse methods
- Highly sensitive to variations in pulse area.
#figure(
  image("pi.png", width: 60%),
)

== ensemble with unknown number of atoms

  
  - ensemble: pulse area = $sqrt(N)*Omega*t = pi$.

//#figure(
//  image("collective.png", width: 50%),
//)
  //-- Applying pulse with chirped frequency: The phase accumulation is not affected by $N$.
  - randomly loaded dipole trap follows a Poissonian distribution in atom number.(unknown N)



== Adiabatic passage

- Two-level system transfer: Adiabatic rapid passage(ARP) 
- Three-level system: Stimulated Raman adiabatic passage(STIRAP).


== Adiabatic rapid passage(ARP)
- Two-level system transfer.@Beterov_2020
- Driven with chirped pulse.@PhysRevA.84.023413
#figure(
  image("ARP_pulse.png", width: 50%),
)


== Why ARP?
- Point 1: 100% transition probability under adiabatic condition.

== ARP and LZ theory

#tblock(
  title: [Landau-Zener theory@PhysRevA.23.3107@10.10635.0235741])[
    - Linear sweep of the energy level.
    $ H = "vt"/2 sigma_z + Omega/2 sigma_x $
    #figure(
      image("avoidedcrossings.png", width: 36%),
    )
    - Transition probability:
    $ P = exp(-(pi Omega^2)/(2v)) $

    if $ v lt.double Omega^2$(Slow varying system, $P=0$): adiabatic transition from $|0 angle.r$ to $|1 angle.r$ during  $t=-infinity$ to $t = infinity$. 
  ]
  == Connection between ARP and LZ
   - Two-level system:@Beterov_2020@PhysRevA.84.023413
   adiabatically following the eigenstate.
   #figure(
     image("byhand.png", width: 69%),
   )







== Why ARP?

- Point 2: 
-- Insitive to pulse areas@cite-key@PhysRevA.84.023413.

-- Overcoming the problem of the $sqrt(N)$ dependence of the collective Rabi frequency in the ensemble with unknown number of atoms.@PhysRevA.84.023413

-- As mentioned above, the Rabi frequency is only required to meet the adiabatic condition and the pulse area does not influence the transition probability. 

== Deterministic single-excitation with ARP
- Linear chirped Gaussian pulse with blockade condition.@PhysRevA.84.023413
#figure(
  image("model1.png", width: 41%),
)

- Time-dependence of excitation probability with different chirped rate:
#figure(
  image("excitationprobability.png", width: 100%),
)
- The probability of single-atom Rydberg excitation is independent of the number of atoms.


== Why ARP?
- Point3: 
-- The phase accumulation is not affected by $N$.@Beterov_2020

 -- performing high-fidelity quantum gate without precise knowledge of the ensemble number.


== Two-level system with ARP pulse
$ H(t) = mat(0, Omega(t)\/2; Omega(t)\/2, -Delta(t)) $
$ Delta(t) = alpha*t; Omega(t) = exp(-t^2/(2tau)) $

where $alpha\/2pi = 1"MHz"; Omega\/2pi = 2"MHz", tau = 1 mu s$
#figure(
  image("ARP.png", width: 80%),
)

== Two-level system with ARP pulse

- phase accumulation is zero
- state transition: $|0angle.r -> |+ angle.r -> |r angle.r -> |+ angle.r -> |0angle.r$
#figure(
  image("0phase.png", width: 34%),
)


== Two-level system with chirped pulse
- for one single excitation, the phase accumulation is 
#figure(
  image("singlephase.png", width: 105%),
)
- The corresponding population is:
#figure(
  image("population.png", width: 55%),
)
== Two-level system with chirped pulse
- for two single excitation, the phase accumulation is
#figure(
  image("doublephase.png", width: 105%),
)

- The corresponding population is:
#figure(
  image("pop_2atoms.png", width: 55%),
)

== Gate design with ARP pulse
#figure(
  image("CZ.png", width: 56%),
)
- if we do not switch the phase:
#figure(
  image("piphase.png", width: 49%),
)
#figure(
  image("ARPaccumu.png", width: 105%),
)

#figure(
  image("1atomphasepi.png", width: 65%),
)

== Gate design with ARP pulse@PhysRevA.101.062309
#figure(
  image("phasegate.png", width: 100%),
)

- Basis: $|00 angle.r$, $|01 angle.r$, $|10 angle.r$, $|11 angle.r$

-- Prepare in state $|00 angle.r$: We neglect optical excitation of the |0〉 state due to the large detuning $ omega_q >> |Omega|$

-- Prepare in state $|10 angle.r$ or $|10 angle.r$: $ H(t) = mat(0, Omega(t)\/2; Omega(t)\/2, -Delta(t)) $

-- Prepare in state $|11 angle.r$: $ H(t) = mat(0, sqrt(2)Omega(t)\/2; sqrt(2) Omega(t)\/2, -Delta(t)) $

The Rabi frequency in ARP pulse is only determined for satisfying adiabatic condition. 

- As mentioned above, the phase accumulation of both state $|10 angle.r , |01angle.r$ and $|11 angle.r$ is $pi$.

//== other methods
//- Accelerating the CZ gate above
//- Method: modifying the hamiltonian that realizes the same population transfer. (Counterdiabatic driving).

//- Effective counterdiabatic driving based on Floquet engineering. The pulses are modified with additional Fourier components. They can track the adiabatic dynamics closely all the time. 



== Application of ARP
- Useful technique for state preparation in quantum dots@10.10635.0012257, population inversion@PhysRevA.102.040201 and quantum computing.
- Frequency-swept picosecond laser pulses can be used to achieve efficient population transfer by ARP in two-level and multi-level systems in the adiabatic limit.@10.10631.468368
- A general theory of ARP with intense, linearly chirped laser pulses with a modified LZ formula to determine the optimal conditions for efficient and robust population transfer.@cite-key
- Coherent population transfer between Rydberg states of Li atoms  with ARP of a single multiphoton transition.alert(@PhysRevLett.96.073002

== ARP process considering relaxing
- Considerign the effect of dissipation induced by environmental coupling.@PhysRevB.43.5397@PhysRevLett.62.3004@PhysRevLett.103.220401. They showed a non-monotonic dependence of the transition probability on the sweep speed due to competition between relaxation and the external sweep. @PhysRevLett.97.200404@PhysRevA.93.012121@PhysRevLett.107.210402@PhysRevA.94.042109

- Also, strong drive can also result in driven induced dessipation(DID), which deserves further investigation.@Chanda_2023


== development of ARP
- Initial experiments: fixed laser frequency and sweeped DC field.@PhysRevLett.41.473@PhysRevLett.32.814
- More recent methods: STIRAP(Stimulated Raman Adiabatic Passage), APLIP(Adiabatic Passage with Laser Induced Potentials).

== Appendix

== Chirped pulse in ARP
- Sweeping laser frequency with a linear chirpe.
$ omega(t) = omega_0 + alpha t $
$ E(t) = E_0 exp(-t^2/(2tau)-i omega_0 t -i alpha t^2/2) $

Thus, the hamiltonian of two-level system with chirped pulse is:
$ H = Delta(t)/2 sigma_z + Omega/2 sigma_x $

== Adiabatic condition
   - Adiabatic condition:

$ (|angle.l psi_+| "dH"/"dt" |psi_- angle.r|)/(E_+ - E_-)^2 lt.double 1 $

- Under two-level system($H = "vt"/2 sigma_z + Omega/2 sigma_x$): 
$ (v Omega)/(2(Delta^2 + Omega^2)^(3/2)) lt.double 1 $
when $Delta = 0$, $v lt.double 2Omega^2$, we need to sweep slow enough. 

//== Three-level ladder system
//#figure(
//  image("STIRAPsingle.png", width: 50%),
//)
== Reference
#bibliography("ref.bib")

