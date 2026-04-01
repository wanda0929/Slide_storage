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

#title-slide()
== Main Contents
- Background(Quantum error correction and Toric code)

- Non-Perturbative Floquet Engineering of the Toric-code Hamitonian

- Simulation in a larger system(PauliPropogation)

- Prospects(self-correctihg methods)
== Why Error Correction? 
- Avoiding randomized/lost information.
#tblock(title: [Error Sources in Quantum Computation])[
  - Errors in gate operations. 

  - Crosstalk between qubits.
  
  - Environmental deccoherence.
  
  - Thermal noise.
  
  - Initialization errors and qubit loss
  
  - Measurement errors.
]
- Helping preserving message.

== Error correction in classical subsystem
#tblock(title: [Classical Repetition code])[
  - Encode bits by repetition:
  $ 0_L -> 000, 1_L -> 111 $

  - Codewords after a single bit flip error:
  $ 0_L -> 100, 0_L -> 010, 0_L -> 001 $
  $ 1_L -> 011, 1_L -> 101, 1_L -> 110 $

  - Error detection: Bits in the string are not identical.

  - Error correction: A majority vote. $010 -> 0...$
]


== Quantum Error Correction
#tblock(title: [Barriers@Kitaev_2003@gottesman2009introductionquantumerrorcorrection])[
  - No-cloning theorem prevents repetition.

  - Measurement destroys superpositions
  
  - Correction of multiple types of errors
  -- e.g., bit flip and phase errors
  ]

== Quantum Error Correction
#tblock(title: [Methods])[
  - measure the error, not the data.
  - Redundancy instead of repetition.
  - Error-correcting codes@PhysRevA.52.R2493@aharonov1996faulttolerantquantumcomputation 
      
      -- Shor code@PhysRevA.52.R2493@Devitt_2013

    -- Steane code(a CSS code)@1996
  
   -- 5 qubit code@Knill_2001
  
   -- All CSS codes.@Calderbank_1996@1996
  
   -- Toric code@Kitaev_2003@Dennis_2002
  
   -- Planar surface code@freedman1998projectiveplaneplanarquantum
]

== Topological-protected Toric code@Kitaev_2003
#figure(
  image("Toric-code.png", width: 80%),
  caption: [Left: Two loops cannot be deformed to a point
or to each other. Right:square lattice with periodic boundary]
)
$ H = -sum_v A_v - sum_p B_p, (A_v = product_(j in "star"(v))Z_j, B_p = product_(j in "bdy"(v))X_j) $
== Topological-protected Toric code@Kitaev_2003
- Logical operators:
#figure(
  image("logical1.png", width: 17.6%),
)
- Ground state of Toric code:
#figure(
  image("Toric2.png", width: 60%),
)
== Topological-protected Toric code@Kitaev_2003
- Error detection with Toric code:

#figure(
  image("Toric1.png", width: 40%),
  caption: [Error correction with Toric code.]
)


//- The system size is too limited which cannot prevent the error from spreading.
//- The relationship between energy gap and temperature is $k_B T<<Delta$. Thus, the temperature is required to be very low. 
//- Self-correcting quantum memories currently exist in four and higher dimensions, with their existence in three dimensions being an open question.


//#tblock(title: [The Caltech Rules@Brell_2016])[
//  A model is a D-dimensional self-correcting quantum memory under Caltech rules if:
//  - Finite Spins (avoiding expontial increase of resource consumption).
//  - Bounded local interactions preventing exansion of error.
//  - Nontrivial Codespace: Redundancy of decoding.
//  - Perturbative Stability: the topological symmetric structure can help to increase the fault-tolerance.
//  - Efficient Decoding. (polynomial time)
//  - Expontial Lifetime. The storage time of quantum information increases exponentially with the scale of the system to achieve long-term stability.
//]

== Non-Perturbative Floquet Engineering of the Toric-code Hamitonian

#tblock(title: [Motivation])[
  - Realizing the Toric-code Hamiltonian in 2D lattice.
  -- Clean four-spin interactions.

  - Methods: 
  -- Floquet engineering.

  -- Trotterization.
  
  - It is promising in the self-correcting machanism smaller than 4D quantum system.
]
== Model
#tblock(title: [Hamitonians of driven/target system])[
  - Driven system: $hat(H)(t) = hat(H)_1(t)+hat(H)_2(t)$, 
  $ hat(H)_1(t) = -g_(alpha beta) sum_(angle.l alpha, beta angle.r)(a_alpha^dagger a_beta + a_beta^dagger a_alpha)-> sum_(angle.l alpha, beta angle.r)g_(alpha beta)(hat(X)_alpha hat(X)_beta + hat(Y)_alpha hat(Y)_beta)   $
  
  - Target system: Wen's plaquette model@Brown_2011(=Kitaev's model)@NUSSINOV2009977 on a square lattice
  $ hat(H)_omega = -J sum_(i,j)hat(P)_(i,j) $ 
  $ hat(P)_(i,j) = hat(X)_(i,j)hat(Z)_(i,j+1)hat(Z)_(i+1,j)hat(X)_(i+1,j+1) $
]

== Why simulating Wen's Model
- Wen's formulation: 
  
      -- a promising surface code dessign against biased noise@cite-key@acharya2022suppressingquantumerrorsscaling.

- Method: Finding control functions $g_(alpha beta)$ and $Omega_alpha$.
== Floquet engineering four-spin interactions
#tblock(title: [Central difficulty])[
  - clean four-spin interactions.
]

#tblock(title: [Floquet engineering])[
  - Considering a foundamental four-spin plaquette.
  
  - For a time step $tau$, effective Hamiltonian $H_(i,j)$ at $tau$ is derived through Magnus expansion.
  $ exp(-i hat(H)_(i,j) tau) = Tau exp(-i integral_0^tau "dt"hat(H)(t)) $
  - Search for periodic $g_(alpha beta)(t)$ $->$ $H_(i,j)approx -J P_(i,j)$.
]
== Single plaquette model
- Magnus expansion:
$ hat(H)_"i,j" = 1/tau sum_(k=1)^infinity hat(Omega)_k (t)  $
$ hat(Omega)_1(t) = integral_0^tau hat(H)(t)"dt" |  | hat(Omega)_2(t) = -1/2 integral_0^tau integral_0^t [hat(H)(t),hat(H)(t')]"dt'""dt"  $
$ hat(Omega)_3(t) = 1/6integral_0^tau "dt"_1integral_0^(t_1) "dt"_2integral_0^(t_3) "dt"_3[hat(H)(t_1),[hat(H)(t_2),hat(H)(t_3)]] $
$ hat(X)_1hat(Z)_2hat(Z)_3hat(X)_4 = [hat(X)_1hat(X)_2,[hat(X)_2hat(X)_3+hat(Y)_2hat(Y)_3,hat(X)_3hat(X)_4] $
#tblock(title: [Driving functions])[
  $ g_(13) = g_(13)cos(omega t) $
  $ g_(23) = g_(13)cos(2omega t) $
  $ g_(24) = g_(13)cos(2omega t) $
  $ omega = 2pi\/tau $
  - It is time symmetric : $g_("kk'")(t) =g_("kk'")(tau - t)$

]
== Single plaquette model
#tblock(title: [Single plaquette model])[
  - Strong resonant X-drive: $hat(H)_2 = Omega_1hat(X)_1 + Omega_4hat(X)_4$,($Omega_(1,4)>>g_("kk'"(t))$). 
  (Penalizing the process induced by $hat(Y)hat(Y)$ coupling.)
  #figure(
    image("../Toric code/drivingscheme.png", width: 37%),
    caption: [Sketch of the driving scheme for realizing a fourspin term in a single four-spin plaquette.]
  )
  - $ hat(H)(t) = Omega_1hat(X)_1 + Omega_4hat(X)_4 + sum_(angle.l k,k' angle.r)g_("kk'")(hat(X)_k hat(X)_k' + hat(Y)_k hat(Y)_k') $
]

- Eliminating YY term:
$ Omega_1hat(X)_1 + Omega_4hat(X)_4 +g_13 (t)(hat(X)_1hat(X)_3 + hat(Y)_1hat(Y)_3) + g_23 (t)(hat(X)_2hat(X)_3 + hat(Y)_2hat(Y)_3) + g_24 (t)(hat(X)_2hat(X)_4 + hat(Y)_2hat(Y)_4) $
$ Omega_1 = Omega_4 = M*omega $
- Moxing to rotating frame with respect to $X_1,X_4$ terms:
$ g_13 (t)(hat(X)_1hat(X)_3 + e^(i M omega t hat(X)_1)hat(Y)_1e^(-i M omega t hat(X)_1)hat(Y)_3) + g_23 (t)(hat(X)_2hat(X)_3 + hat(Y)_2hat(Y)_3) $
$ + g_24 (t)(hat(X)_2hat(X)_4 + hat(Y)_2e^(-i M omega t hat(X)_4)hat(Y)_4e^(-i M omega t hat(X)_4))  $
== Single plaquette model
#tblock(title: [Effective Hamitonian])[
  - All possible operators $<-$ dynamical Lie algebra of the control system.
  - Effective Hamiltonian $ hat(H)_(i,j) = sum_(O in L)c_l hat(O)_l $
  - Challenge: Single out the desired term.
  

]

== single plaquette model
#tblock(title: [Strong and clean 4-body-interaction])[
  - Method: Optimize $g_("kk'"), Omega_j$ via exact numerical simulation in single-plaquette model rather than high-frequency expansion.

  - The four-body interaction is the dominant term:

  #figure(
    image("../Toric code/4body.png", width: 30%),
    caption: [Structure of the lattice.]
  )
]

== single plaquette model
#tblock(title: [Effective Hamiltonian])[
  - Effective Hamiltonian $ hat(H)_(i,j) = -J hat(P)_(i,j)+epsilon hat(V)_(i,j) $ The extra terms are contained in $hat(V)_"i,j"$ and $epsilon\/J = 1.5 dot 10^(-3)$.
  
  //- Dissipation process: The decoherence and dissipation rates are not significantly impacted by the Floquet driving process.(Appendix C)

]

//== single plaquette model
//#tblock(title: [Ground state])[
//  - Toric ground state for mixed boundary conditions: $ |G angle.r = 1/2(1+hat(Z)_1 hat(X)_2)(1+hat(X)_3 hat(Z)_4|-11-angle.r $

//  #figure(
//    image("../Toric code/mix.png", width: 14%),
//    caption: [Two-by-two toric-code Hamiltonian with mixed boundary conditions.]
//  )

//]

== Full lattice sequence

#tblock(title: [first-order Floquet-Trotter sequence])[
  - Devide the Hamitonian as the sum of four parts:
  $ hat(H)_k = sum_((i,j) in G_k)hat(H)_(i,j) $
  #figure(
    image("../Toric code/FTsequence.png", width: 50%),
    caption: [
       Trotter sequence to realize the Hamiltonian on the whole lattice.
    ],
  )
  //- Consider one substep $tau$ rather than the whole period $T$.
  
  - The propogator: 
  $ hat(U)(T) = product_(k=1)^4 product_((i,j) in G_k)hat(U)_"ij"(tau) $
  where $U_"ij" (tau) = e^(-i tau hat(H)_(i,j))$ The product of propogators $hat(U)_k = e^(-i hat(H)_k tau)$ belonging to two different groups do not commute and can be estimated by expontial product formula. 
  $ product_k hat(U)_k = exp(-i tau sum_k hat(H)_k + tau^2/2 sum_(j<k)[hat(H)_j,hat(H)_k] + ...) $
  - In effective Hamitonian, the term $P_(i,j)$ commutes with each other, so the equation above is used to calculate error terms. $->hat(H)_"eff" = hat(H)_omega + hat("Err")$

  
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

== Prospects
- Main target: Proving the self-correcting mechanism in the system.

- Method: Simulation of lager system with noise for exponitial scaling decay.

- package: PauliPropogation.jl(https://github.com/MSRudolph/PauliPropagation.jl/tree/main)


== Why Self-correcting in Quantum computation?
- No-cloning theorem.
- Self-correction.
- Crucial mechanism@Brown_2016:
    
     -- topological protection.

     -- energy barriers. 

     -- energy cost for local error in system.

== Self-correcting in classical system
#tblock(title: [2D Ising model@Brell_2016@Peierls_1936])[
  
  $ H = -sum_(i,j)Z_i Z_j $
  -- 2-fold degenerate, Extensive distance, Finite temperature ordered phase, Expontential memory lifetime.
  #figure(
    image("2D Ising.png", width: 18%),
    caption: [2D Ising model.]
  )

]
== Self-correcting in quantum system
- fluctuations@PhysRevB.77.064302@PhysRevB.76.184442@Alicki_2009:

 -- external thermal fluctuations.

 -- quantum fluctuations.
- Non-local entanglement.

- Method:  

  -- topological order.

  -- energy gap.
== Self-correcting Quantum Memory
#tblock(title: [Core Requirements: The Caltech rules@Landon_Cardinal_2015@Brell_2016])[
  - Expontential lifetime.
  - finite spins and bounded local interactions
  - perturbative stability
  - nontrivial codespace
  - efficient decoding
]

== Self-correcting under 2D Quantum system
#tblock(title: [2D No-Go theorem])[
  - A self-correcting quantum memory cannot be built using stabilizer codes in 1D/2D@Bravyi_2009.
  - Spetial operation in 2D: 
  -- Toric-boson model@Hamma_2009

  -- entropic barriers@Brown_2014
  
]
== Self-correcting under 3D Quantum system
#tblock(title: [3D No-Go theorem])[
  - No local spin models in 2D or 3D are known to be fully self-correcting. But many approaches towards realizing some aspects of self-correction in 3D have also been found@PhysRevX.10.031041
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

== Relevant works(For example)
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
- Inspiration: 
-- classical Ising model on the Sierpinski carpet fractal. 

- Quantum-system dimension: 
-- on fractal subsets of a 4D hypercubic lattice with Hausdorff dimension less than 3.
#figure(
  image("Sierpinski.png", width: 100%),
  caption: [Sierpinski carpet fractal. Its dimension is less than 2.]
)

== Reference
#bibliography("ref.bib")

