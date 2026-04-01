
#import "@preview/cetz:0.2.2": canvas, draw, tree, plot
#set cite(style:"apa")


// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Register university theme
// You can replace it with other themes and it can still work normally
#let s = hkustgz-theme.register()

// Set the numbering of section and subsection
#let s = (s.methods.numbering)(self: s, section: "1.", "1.1")

// Set the speaker notes configuration, you can show it by pympress
// #let s = (s.methods.show-notes-on-second-screen)(self: s, right)

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [Non-Perturbative Floquet Engineering of the Toric-code Hamitonian],
  //subtitle: [基于 Touying 的香港科技大学 Typst 幻灯片模板],
  author: [Han Wang],
  date: datetime.today(),
  institution: [香港科技大学],
  others: none
)

// Pdfpc configuration
#let s = (s.methods.append-preamble)(self: s, pdfpc.config(
  duration-minutes: 30,
  start-time: datetime(hour: 14, minute: 00, second: 0),
  end-time: datetime(hour: 14, minute: 30, second: 0),
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
  default-transition: (
    type: "push",
    duration-seconds: 2,
    angle: ltr,
    alignment: "vertical",
    direction: "inward",
  ),
))

// Extract methods
#let (init, slides, touying-outline, alert, speaker-note, tblock) = utils.methods(s)
#show: init.with(
  lang: "en",
  font: ("Linux Libertine", "Source Han Sans SC", "Source Han Sans"),
)

#show strong: alert

// Extract slide functions
#let (slide, empty-slide, title-slide, outline-slide, new-section-slide, ending-slide) = utils.slides(s)
#show: slides.with()

== Main Contents
- Background(Quantum error correction and Toric code)

- Non-Perturbative Floquet Engineering of the Toric-code Hamitonian

- Prospects(PauliPropagation for larger system and introduction of self-correction)
//== Quantum Error Correction: Origins & Growth

//- Peter Shor:
//-- Quantum error-correcting codes@Calderbank_1996

//-- Fault-tolerant syndrome measurement@shor1997faulttolerantquantumcomputation

//-- Fault-tolerant universal quantum gates@shor1997faulttolerantquantumcomputation

//- Alexei Yu. Kitaev
//-- Topological quantum codes@Kitaev_2003

//-- Physically protected quantum computing@Kitaev_2003

//-- Computing with nonabelian anyons@Kitaev_2003

== Topological quantum computation
- Microsoft unveils Majorana 1, the world’s first quantum processor powered by topological qubits
#figure(
  image("silicon.png", width: 40%),
  
)
- Fault-tolerant prototype (FTP) based on topological qubits
== QEC in neutral atoms array
- Logical qubits(k), physical qubits(n) and code distance(d)
#align(center, canvas(length:0.6cm, {
  import draw: *
  let s(it) = text(it, 10pt)
  content((3.5, 4.5), s[Physical space])
  circle((0, 0), radius: (3, 5))
  circle((0, 3), radius: 0.1, fill: black, stroke: none, name: "A")
  circle((0, -3), radius: 0.1, fill: black, stroke: none, name: "B")
  content((rel: (0, -1), to: "B"), s[Code space])
  content((rel: (0.6, 0), to: "A"), s[$|overline(0)angle.r$])
  content((rel: (0.6, 0), to: "B"), s[$|overline(1)angle.r$])
  line((-4, 0), (4, 0), stroke: (dash: "dashed"))
  let p0 = (anchor: 150deg, name: "B")
  let p1 = (rel: (-1.8, 1), to: "B")
  let p2 = (rel: (-1.5, 1.8), to: "B")
  line(p0, p1, mark: (end: "straight"), stroke: red)
  line(p1, p2, mark: (end: "straight"), stroke: red)
  line(p2, p0, mark: (end: "straight"), stroke: blue)
  content((-1.9, -0.7), text(blue, s[QEC algorithm $arrow.r$ Hamiltonian?]))
  content((-3.3, -2), text(red, s[Pauli error]))
  circle(p1, radius: 0.1, fill: red, stroke: none)
  circle(p2, radius: 0.1, fill: red, stroke: none)
  line("A", "B", mark: (end: "straight", start: "straight"))
  content((2.2, 1), s[Code distance: $d$])
}))
- We require a large code distance(d), Logical qubits(k) and small physical qubits(n) to achieve fault-tolerant quantum computation.
//- Avoiding randomized/lost information.
//#tblock(title: [Error Sources in Quantum Computation])[
//  - Errors in gate operations. 

//  - Crosstalk between qubits.
  
//  - Environmental deccoherence.
  
//  - Thermal noise.
  
//  - Initialization errors and qubit loss
  
//  - Measurement errors.
//]
//- Achieving low gate error rates@Gidney_2021@cite-key1.

//== Error correction in classical subsystem
//#tblock(title: [Classical Repetition code])[
  
//  - Encode bits by repetition:
//  $ 0_L -> 000, 1_L -> 111 $
//#figure(
//    image("classical.png", width: 30%),
//  )

//  - Error detection: Bits in the string are not identical.

//  - Error correction: A majority vote. $010 -> 0...$
//]


//== Quantum Error Correction
//#tblock(title: [Barriers@Kitaev_2003@gottesman2009introductionquantumerrorcorrection])[
//  - No-cloning theorem prevents repetition.
//#figure(
//  image("Non-cloning.png", width: 30%),
//)
//  - Measurement destroys superpositions

//  - Correction of multiple types of errors $->$ e.g., bit flip and phase errors
//  ]

//== Quantum Error Correction
//#tblock(title: [Methods])[
//  - Redundancy instead of repetition.

//  - Measure the error, not the data.
//  #figure(
//  image("quanmeasure.png", width: 27%),
//)
//]

== Topological-protected Toric code@Kitaev_2003
#figure(
  image("Toric-code.png", width: 73%),
  caption: [Left: Two loops cannot be deformed to a point
or to each other. Right:square lattice with periodic boundary]
)
$ H = -sum_v A_v - sum_p B_p, (A_v = product_(j in "star"(v))Z_j, B_p = product_(j in "bdy"(v))X_j) $
$ [A_i,A_j] = [A_i,B_j] = [B_i,B_j] = 0 $
== Topological-protected Toric code@Kitaev_2003
- Logical operators:
#figure(
  image("logical1.png", width: 32%),
)
//- Ground state of Toric code:/
//#figure(
//  image("/Toric-code/Toric code/Toric2.png", width: 60%),
//)
//== Topological-protected Toric code@Kitaev_2003
//- Error detection with Toric code:

//#figure(
//  image("/Toric-code/Toric code/Toric1.png", width: 40%),
//  caption: [Error correction with Toric code.]
//)
// 
== Construction of XZZX code@petiziol2023nonperturbativefloquetengineeringtoriccode
arXiv:2211.09724

#figure(
  image("abs.png", width: 70%),
)

== Wen's model, the XZZX surface code@acharya2022suppressingquantumerrorsscaling
$ H_omega = -J sum_(i,j)hat(P)_(i,j) ( hat(P)_(i,j) = hat(X)_(i,j)hat(Z)_(i,j+1)hat(Z)_(i+1,j)hat(X)_(i+1,j+1)) $
- Standard surface code + Hardmard the qubit shown in green circle = the XZZX code. 
//$ hat(U) = product_(i+j="even/odd")1/sqrt(2)(hat(X)_("ij") + hat(Z)_("ij")), i+j="even", hat(U) hat(W)_("ij")hat(U)^dagger = hat(A)_(i,j); i+j="odd", hat(U) hat(W)_("ij")hat(U)^dagger = hat(B)_(i,j) $
#figure(
    image("formXZZX.png", width: 57%),
    caption: [
       XZZX code
    ],
  )
  
 == Surface code@PhysRevA.76.012305@Kitaev_2003
- Formation of rotated surface code:@cite-key4#link("https://example.com")[
  [surfacecode]
]
#figure(
  image("surfacecode.png", width: 70%),
  caption: [Surface code.]
)
- logical operators: vertical Z chain and horizontal X chain.
== XZZX code
- Single-qubit Pauli noise channel(Biased)
$ epsilon(rho) = (1-p)rho + p_x X rho X + p_y Y rho Y + p_z Z rho Z $
//- bias coefficient: 
//$ eta = p_z/(P_x+P_y) $
- Dominant noise type: dephasing (Z errors)@Grimm584@jarryd489
-- XZZX code: "every single stabilizer in the new code can detect odd parity of Z errors nearby".

-- Original code: "Only half the X stabilizers could detect Z errors".
== Wen's model, the XZZX surface code@acharya2022suppressingquantumerrorsscaling

- threshold for the XZZX code(left) and the CSS code(right)@PhysRevLett.124.130501
#figure(
  image("threshold.png", width: 70%),
  caption: [Optimal code-capacity thresholds over all single-qubit Pauli channels]
)

//Considering the Pauli errors, the probability of X,Y,Z errors is different.

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
#figure(
  image("model.png", width: 50%),
  caption: [Realizing the Toric-code Hamiltonian in 2D lattice through Floquet engineering and trotterization.]
)
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

- Method: Finding control functions $g_(alpha beta)$.
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
- Magnus expansion@Bukov04032015:
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
- Rotating frame with respect to $X_1,X_4$ terms:
$ g_13 (t)(hat(X)_1hat(X)_3 + e^(i M omega t hat(X)_1)hat(Y)_1e^(-i M omega t hat(X)_1)hat(Y)_3) + g_23 (t)(hat(X)_2hat(X)_3 + hat(Y)_2hat(Y)_3) $
$ + g_24 (t)(hat(X)_2hat(X)_4 + hat(Y)_2e^(i M omega t hat(X)_4)hat(Y)_4e^(-i M omega t hat(X)_4))  $
== Single plaquette model
#tblock(title: [Effective Hamitonian])[
  - All possible operators $<-$ dynamical Lie algebra of the control system(Appendix B3)@dalessandro2007.
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
//- The boundary terms involving $hat(X)_alpha hat(Z)_beta$ terms are Floquet engineering with driving scheme:
//$ g_(alpha beta)cos(omega t)(hat(X)_alpha hat(X)_beta + hat(Y)_alpha hat(Y)_beta) + tilde(g)sin(omega t)hat(Y)_beta $
//- Mixed boundary condition.

#figure(
  image("../Toric code/55lattice.png", width: 70%),
  caption: [5x5 lattice with mixed boundary conditions.]
)

//== Present of entanglement
//- Calculation of topological entanglement entropy $S_"topo"$ with three subsystems A,B,C.

//- $S_"topo" = S_A + S_B + S_C + S_"AB" + S_"BC" + S_"AC" + S_"ABC"$, where $S_X = tr rho_X log rho_X$ is von Neumann entropy.

//- $S_"topo" = -"log"2$ is very close to the value of ideal toric code, characterizing the $Z_2$topological order.

== Prospects
- Main target: Proving the scaling performance of the Floquet engineering XZZX code. 

- Method: Simulation of lager system with PauliPropogation.jl package.

- package: PauliPropogation.jl(https://github.com/MSRudolph/PauliPropagation.jl/tree/main)


//== Why Self-correcting in Quantum computation?
//- No-cloning theorem.
//- Self-correction.
//- Crucial mechanism@Brown_2016:
    
//     -- topological protection.

//     -- energy barriers. 

//     -- energy cost for local error in system.

//== Self-correcting in classical system
//#tblock(title: [2D Ising model@Brell_2016@Peierls_1936])[
  
  //$ H = -sum_(i,j)Z_i Z_j $
//  -- 2-fold degenerate, Extensive distance, Finite temperature ordered phase, Expontential memory lifetime.
//  #figure(
  //  image("2D Ising.png", width: 18%),
  //  caption: [2D Ising model.]
//  )

//]
//== Self-correcting in quantum system
//- fluctuations@PhysRevB.77.064302@PhysRevB.76.184442@Alicki_2009:

// -- external thermal fluctuations.

// -- quantum fluctuations.
//- Non-local entanglement.

//- Method:  

//  -- topological order.

//  -- energy gap.
//== Self-correcting Quantum Memory
//#tblock(title: [Core Requirements: The Caltech rules@Landon_Cardinal_2015@Brell_2016])[
//  - Expontential lifetime.
//  - finite spins and bounded local interactions
//  - perturbative stability
//  - nontrivial codespace
//  - efficient decoding
//]

//== Self-correcting under 2D Quantum system
//#tblock(title: [2D No-Go theorem])[
//  - A self-correcting quantum memory cannot be built using stabilizer codes in 1D/2D@Bravyi_2009.
//  - Spetial operation in 2D: 
//  -- Toric-boson model@Hamma_2009

//  -- entropic barriers@Brown_2014
  
//]
//== Self-correcting under 3D Quantum system
//#tblock(title: [3D No-Go theorem])[
//  - No local spin models in 2D or 3D are known to be fully self-correcting. But many approaches towards realizing some aspects of self-correction in 3D have also been found@PhysRevX.10.031041
//  -- Haah code@lin2024proposals3dselfcorrectingquantum,@PhysRevA.83.042330@PhysRevLett.111.200501: 3D cubit code, self-correction in 3D cubic model.

//  -- Welded codes: Combining two stabilizer codes for a new stabilizer code and then use it to construct solid codes.@michnicki20123dquantumstabilizercodes

//  -- subsystem codes:encode information into a subsystem of a Hilbert space.@Bacon_2006
  
//  - bosonic bat model: Locally coupling a 2D code to a 3D bath of bosons hopping on a cubic lattice.@Pedrocchi_2013
//  - Four spatial dimensions can achieve self-correctihg(4D Toric code@dennis_topological_2002,@S1230161210000023).
//]

//== Self-correcting under 4D Quantum system
//#tblock(title: [4D Self-correcting theorem])[
//  - Four spatial dimensions can achieve self-correctihg: 4D Toric code(An example for 4D Caltech SCQM). @alicki2008thermalstabilitytopologicalqubit,@dennis_topological_2002,@S1230161210000023.
//  $ H = -sum_l A_l - sum_c B_c (A_i = product_(j in i)X_j, b_k = product_(j in k)Z_j) $
//  #figure(
//    image("4DToriccode.png", width: 16%),
//    caption: [4D Toric code.]
//  )
//]

//== Relevant works(For example)
//- A proposal for self-correcting stabilizer quantum memory in 3D(or slightly less)@Brell_2016
//#table(
  //columns: (auto, auto),
  //inset: 10pt,
  //align: center,
  //table.header(
  //  [*Classical system*], [*Quantum system*],
  //),
  
 // [1D Ising model],
 // [2D Toric code ],
 // [2D Ising model],
 // [4D Toric code],
 /// [???],
  //[3D quantum system]
//)
//- Inspiration: 
//-- classical Ising model on the Sierpinski carpet fractal. 

//- Quantum-system dimension: 
//-- on fractal subsets of a 4D hypercubic lattice with Hausdorff dimension less than 3.
//#figure(
//  image("Sierpinski.png", width: 100%),
//  caption: [Sierpinski carpet fractal. Its dimension is less than 2.]
//)

== Reference
#bibliography("ref.bib")

