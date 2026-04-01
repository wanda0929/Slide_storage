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
    title: [Non-Perturbative Floquet Engineering of the Toric-code Hamitonian and its ground state],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)

#title-slide()

== Why Error Correction? 
- In quantum computation, the information can become randomized or lost under the noise and a buildup of errors will renders the algorithm useless.
#tblock(title: [Error Sources in Quantum Computation])[
  - Errors in gate operations. 
  - Crosstalk between qubits.
  - Environmental deccoherence.
  - Thermal noise.
  - initialization errors and qubit loss
  - Measurement errors.
]
- To preserve messages sent through a noisy transmission channel by encoding the messages
in an error-correcting code.

== Why Self-correcting in Quantum computation?
- For quantum computers, they can not correct errors by copying encoded data and they need other ways to realize quantum error correction.
- Self-correcting: don't need active error correction and is crucial important for scalable quantum computation. 
- Crucial mechanism: topological protection, energy barriers, and energy cost for local error in system.

== Self-correcting in classical system
//#tblock(title: [Classical Repetition code])[
//  - Correcting a single bit flip error:
//  $ 0 -> 000, 1 -> 111 $

//  A single bit flip error can be corrected by a majority vote. $010 -> 0$
//]

#tblock(title: [2D Ising model])[
  
  $ H = -sum_(i,j)Z_i Z_j $
  -- 2-fold degenerate, Extensive distance, Finite temperature ordered phase, Expontential memory lifetime.
  #figure(
    image("2D Ising.png", width: 18%),
    caption: [2D Ising model.]
  )

]

//== Quantum Error Correction
//#tblock(title: [Barriers])[
//  - Measurement destroys superpositions
//  - No-cloning theorem prevents repetition.
// - Correction of multiple types of errors
//  -- e.g., bit ip and phase errors
//  ]


//#tblock(title: [Methods])[
//  - Measure the error, not the data.
//  - Redundancy instead of repetition.
//  - Nine qubit code.
//]

== Self-correcting in quantum system
- External thermal fluctuations and quantum fluctuations will spoil classic ordered phase.
- Non-local entanglement tend to spread errors.
- Using topological order and energy gap to protect quantum information from errors.
== Self-correcting Quantum Memory
//- The system size is too limited which cannot prevent the error from spreading.
//- The relationship between energy gap and temperature is $k_B T<<Delta$. Thus, the temperature is required to be very low. 
//- Self-correcting quantum memories currently exist in four and higher dimensions, with their existence in three dimensions being an open question.
#tblock(title: [Core Requirements])[
  - Lifetime of quantum information increases exponentially with the scale of the system under finite temperature.
  - Relying on the energy barriers or topological protection to prevent the error from spreading instead of active error correction.
  - The system can maintain a stable ordered phase below the critical temperature. 
]


//#tblock(title: [The Caltech Rules@Brell_2016])[
//  A model is a D-dimensional self-correcting quantum memory under Caltech rules if:
//  - Finite Spins (avoiding expontial increase of resource consumption).
//  - Bounded local interactions preventing exansion of error.
//  - Nontrivial Codespace: Redundancy of decoding.
//  - Perturbative Stability: the topological symmetric structure can help to increase the fault-tolerance.
//  - Efficient Decoding. (polynomial time)
//  - Expontial Lifetime. The storage time of quantum information increases exponentially with the scale of the system to achieve long-term stability.
//]
== Self-correcting under 2D Quantum system
#tblock(title: [2D No-Go theorem])[
  - A self-correcting quantum memory cannot be built using stabilizer codes in 1D/2D@Bravyi_2009.
  - Spetial operation in 2D: 
  -- Toric-boson model@Hamma_2009

  -- entropic barriers@Brown_2014
  
]
== Self-correcting under 3D Quantum system
#tblock(title: [3D No-Go theorem])[
  - No local spin models in 2D or 3D are known to be fully self-correcting. But many approaches towards realizing some aspects of self-correction in 3D have also been found
  -- Haah code@lin2024proposals3dselfcorrectingquantum,@PhysRevA.83.042330@PhysRevLett.111.200501: 3D cubit code, self-correction in 3D cubic model.

  -- Welded codes: Combining two stabilizer codes for a new stabilizer code and then use it to construct solid codes.@michnicki20123dquantumstabilizercodes

  -- subsystem codes:encode information into a subsystem of a Hilbert space.@Bacon_2006
  
  - bosonic bat model: Locally coupling a 2D code to a 3D bath of bosons hopping on a cubic lattice.@Pedrocchi_2013
  - Four spatial dimensions can achieve self-correctihg(4D Toric code@dennis_topological_2002,@S1230161210000023).
]

== Self-correcting under 4D Quantum system
#tblock(title: [4D Self-correcting theorem])[
  - Four spatial dimensions can achieve self-correctihg: 4D Toric code(An example for 4D Caltech SCQM). @alicki2008thermalstabilitytopologicalqubit,@dennis_topological_2002,@S1230161210000023.
  $ H = -sum_l A_l - sum_c B_c (A_i = product_(j in i)X_j, b_k = product_(j in k)Z_j) $
  #figure(
    image("4DToriccode.png", width: 16%),
    caption: [4D Toric code.]
  )
]

== Past Works
- A proposal for self-correcting stabilizer quantum memory in 3D(or slightly less)@Brell_2016
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: center,
  table.header(
    [*Classical system*], [*Quantum system*],
  ),
  
  [1D Ising model],
  [2D Toric code ],
  [2D Ising model],
  [4D Toric code],
  [???],
  [3D quantum system]
)
- Inspired by classical Ising model on the Sierpinski carpet fractal, it can be defined on fractal subsets of a 4D hypercubic lattice with Hausdorff dimension less than 3.
#figure(
  image("Sierpinski.png", width: 100%),
  caption: [Sierpinski carpet fractal. Its dimension is less than 2.]
)

== Past Works
- Symmertic-protected Self-Correcting Quantum Memories@PhysRevX.10.031041

........

== Non-Perturbative Floquet Engineering of the Toric-code Hamitonian

#tblock(title: [Motivation])[
  - The realization of toric-code Hamitonian is promising in simple self-correction mechanism.
  - Simulating Toric-code Hamiltonian by realizing clean four-spin interactions under Continuous-driven Floquet engineering and trotterization in 2D square lattice. 
  - Through Floquet engineering in 2D lattice, the Toric-code Hamitonian can be realized and it is promising in the self-correcting machanism smaller than 4D quantum system.
]
== Model
#tblock(title: [Hamitonians of driven/target system])[
  - Driven system: $hat(H)(t) = hat(H)_1(t)+hat(H)_2(t)$, 
  $ hat(H)_1(t) = -g_(alpha beta) sum_(angle.l alpha, beta angle.r)(a_alpha^dagger a_beta + a_beta^dagger a_alpha)-> sum_(angle.l alpha, beta angle.r)g_(alpha beta)(hat(X)_alpha hat(X)_beta + hat(Y)_alpha hat(Y)_beta)   $
  (Sum over nearest-neighbor interactions)
  ($H_2$: Resonant single-qubit pulses)
  - Target system: Wen's plaquette model@Brown_2011(=Kitaev's model)@NUSSINOV2009977 on a square lattice
  $ hat(H)_omega = -J sum_(i,j)hat(P)_(i,j) $ 
  $ hat(P)_(i,j) = hat(X)_(i,j)hat(Z)_(i,j+1)hat(Z)_(i+1,j)hat(X)_(i+1,j+1) $
]

== Why simulating Wen's Model
- Wen's formulation is thought of a promising surface code dessign against biased noise@cite-key@acharya2022suppressingquantumerrorsscaling.
- Method: Finding control functions $g_(alpha beta)$ and $Omega_alpha$ for reproducing the target Hamiltonian as accurately as possible.

== Floquet engineering four-spin interactions
#tblock(title: [Central difficulty])[
  - Realizing clean four-spin interactions(cancelling single/two-spin terms) is crucial.
]

#tblock(title: [Floquet engineering])[
  - Considering a foundamental four-spin plaquette, the timestep $tau$ is a submultiple of Floquet period $T$. 
  - For a time step $tau$, effective Hamiltonian $H_(i,j)$ at $tau$ is derived through Magnus expansion.
  $ exp(-i hat(H)_(i,j) tau) = tau exp(-i integral_0^tau "dt"hat(H)(t)) $
  - Search for periodic $g_(alpha beta)(t)$, such that the relation $H_(i,j)approx -J P_(i,j)$ is satisfied.
]

== Single plaquette model
#tblock(title: [Single plaquette model])[
  - Introducing strong resonant X-drive: $hat(H)_2 = Omega_1hat(X)_1 + Omega_4hat(X)_4$,($Omega_(1,4)>>g_("kk'"(t))$). It may penalize the process induced by $hat(Y)hat(Y)$ coupling.
  #figure(
    image("../Toric code/drivingscheme.png", width: 40%),
    caption: [Sketch of the driving scheme for realizing a fourspin term in a single four-spin plaquette.]
  )
  - $ hat(H)(t) = Omega_1hat(X)_1 + Omega_4hat(X)_4 + sum_(angle.l k,k' angle.r)g_("kk'")(hat(X)_k hat(X)_k' + hat(Y)_k hat(Y)_k') $
]


#tblock(title: [Driving functions])[
  $ g_(13) = g_(13)cos(omega t) $
  $ g_(23) = g_(13)cos(2omega t) $
  $ g_(24) = g_(13)cos(2omega t) $
  $ omega = 2pi\/tau $
  - It is time symmetric : $g_("kk'")(t) =g_("kk'")(tau - t)$

]
== Single plaquette model
#tblock(title: [Effective Hamitonian])[
  - Recommended to inpect the possible operators through dynamical Lie algebra of the control system.
  - Effective Hamiltonian $ hat(H)_(i,j) = sum_(O in L)c_l hat(O)_l $
  - Challenge: Single out the desired term.
  

]

== single plaquette model
#tblock(title: [strong and clean 4-body-interaction])[
  - Method: Optimize $g_("kk'"), Omega_j$ via exact numerical simulation in single-plaquette model rather than high-frequency expansion.
  - The four-body interaction is the dominant term with the method mentioned above

  #figure(
    image("../Toric code/4body.png", width: 31%),
    caption: [Structure of the lattice.]
  )
]

== single plaquette model
#tblock(title: [Effective Hamiltonian])[
  - Effective Hamiltonian $ hat(H)_(i,j) = -J hat(P)_(i,j)+epsilon hat(V)_(i,j) $ The extra terms are contained in $hat(V)_"i,j"$ and $epsilon\/J = 1.5 dot 10^(-3)$.
  - Dissipation process: The decoherence and dissipation rates are not significantly impacted by the Floquet driving process.(Appendix C)

]

== single plaquette model
#tblock(title: [Ground state])[
  - Toric ground state for mixed boundary conditions: $ |G angle.r = 1/2(1+hat(Z)_1 hat(X)_2)(1+hat(X)_3 hat(Z)_4|-11-angle.r $

  #figure(
    image("../Toric code/mix.png", width: 14%),
    caption: [Two-by-two toric-code Hamiltonian with mixed boundary conditions.]
  )

]

== Full lattice sequence
#tblock(title: [first-order Floquet-Trotter sequence])[
  - Devide the Hamitonian as the sum of four parts:
  $ hat(H)_k = sum_((i,j) in G_k)hat(H)_(i,j) $
  - Consider one substep $tau$ rather than the whole period $T$.
  - The propogator: 
  $ hat(U)(T) = product_(k=1)^4 product_((i,j) in G_k)hat(U)_"ij"(tau) $
  where $U_"ij" (tau) = e^(-i tau hat(H)_(i,j))$ The product of propogators $hat(U)_k = e^(-i hat(H)_k tau)$ belonging to two different groups do not commute and can be estimated by expontial product formula. 
  $ product_k hat(U)_k = exp(-i tau sum_k hat(H)_k + tau^2/2 sum_(j<k)[hat(H)_j,hat(H)_k] + ...) $
  - In effective Hamitonian, the term $P_(i,j)$ commutes with each other, so the equation above is used to calculate error terms. $ hat(H)_"eff" = hat(H)_omega + hat("Err") $

  #figure(
    image("../Toric code/FTsequence.png", width: 60%),
    caption: [
       Trotter sequence to realize the Hamiltonian on the whole lattice.
    ],
  )
]

== Simulation in 5x5 lattice
- The boundary terms involving $hat(X)_alpha hat(Z)_beta$ terms are Floquet engineering with driving scheme:
$ g_(alpha beta)cos(omega t)(hat(X)_alpha hat(X)_beta + hat(Y)_alpha hat(Y)_beta) + tilde(g)sin(omega t)hat(Y)_beta $
- Mixed boundary condition.

#figure(
  image("../Toric code/55lattice.png", width: 70%),
  caption: [5x5 lattice with mixed boundary conditions.]
)

== Present of entanglement
- Calculation of topological entanglement entropy $S_"topo"$ with three subsystems A,B,C.
- $S_"topo" = S_A + S_B + S_C + S_"AB" + S_"BC" + S_"AC" + S_"ABC"$, where $S_X = tr rho_X log rho_X$ is von Neumann entropy.
- $S_"topo" = -"log"2$ is very close to the value of ideal toric code, characterizing the $Z_2$topological order.
== Reference
#bibliography("ref.bib")

