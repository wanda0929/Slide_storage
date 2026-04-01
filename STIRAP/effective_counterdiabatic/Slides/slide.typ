#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.4.5" as fletcher: node, edge
#import "@preview/touying:0.4.2": *
#import "@preview/touying:0.4.2": *
#import "@preview/touying-simpl-hkustgz:0.1.0" as hkustgz-theme
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
  title: [quantum control by effective counterdiabatic driving],
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

== Shortcuts to adiabaticity(STA)
- Achieving acceration of adiabatic evolutions.
#table(
  columns: 3,
  rows: 4,
  [],[adiabatic evolution@PhysRevA.101.062309], [shortcut to adiabaticity@RevModPhys.91.045001],
  [evolution time],[slow varying coefficients],[shorter time with external control field],[precision],[Strict adiabatic conditions are difficult to satisfy],[the adiabatic path can be accurately tracked with highly-accurate control],[Hamiltonians],[depends only on origional Hamiltonian $H_0(t)$],[modified hamiltonian $H_0(t)+H_"CD" (t)$],

)
- Challange: necessity of external degrees of freedom(Additional field, auxiliary energy level, non-local coupling) which is difficult to control.

== == Main Contents
- Providing systematic method to approximate counterdiabatic driving Hamiltonian with initially avaliable control Hamiltonian.@Petiziol2024QuantumCB
- Method: Floquet theory, periodic driving, high-frequency modulation of operators in original adiabatic Hamiltonian.
- Applications: 
  - Quantum state transfer(fmod-STIRAP)
  - Bell states in circuit QED
  - STIRAP quantum gates

== counterdiabatic driving
- Considering instantaneous energy $E_n(lambda)$, eigenstates $|n_lambda angle.r$($lambda = lambda(t)$): $ hat(H)_0(lambda)|n_lambda angle.r = E_n(lambda)|n_lambda angle.r $ and any quantum states can be written as $|psi(lambda) angle.r = sum_n a_n (lambda)|n_lambda angle.r$. The Schordinger equation $i partial/(partial t) |psi(lambda)angle.r = H(lambda)|psi(lambda)angle.r$ can be written as:
$ partial_lambda a_n(lambda) = -i[dot(lambda)^(-1)E_n (lambda)-i angle.l n_lambda|partial_lambda n_lambda angle.r]a_n(lambda)-sum_(m eq.not n)(angle.l n_lambda|partial_lambda hat(H)_0 (lambda)|m_lambda angle.r)/(E_m (lambda)-E_n (lambda))a_m (lambda) $
- During the adiabatic evolution, system will stay in one instantaneous eigenstates, but the phase will accumulate:
       - Dynamic phase: $gamma_n^d (t)= -1/planck.reduce integral_0^t E_n(lambda(t^prime)) d t^prime$
       - Geometric(Berry) phase: $gamma_n^g (t) = -i integral_lambda(0)^lambda(t) angle.l n_lambda|partial_lambda n_lambda angle.r d lambda$. where $i angle.l n_lambda|partial_lambda n_lambda angle.r $ is berry connection.
- For the Schordinger equation, the second term includes the nonadiabatic transitions among the instantaneous eigenstates, which should be eliminated to protect the adiabaticity.
   - Method: adding conterdiabatic driving Hamiltonian $H_"CD" (lambda)$ :$hat(H) = hat(H)_0(lambda) + H_"CD" (lambda)$
    $ hat(H)_"CD" = i dot(lambda) sum_(n,m eq.not n)(|n_lambda angle.r angle.l n_lambda|partial_lambda hat(H)_0 (lambda)|m_lambda angle.r angle.l m_lambda|)/(E_m (lambda)-E_n (lambda)) $
== Two-level system
- Driven Hamiltonian:
$ hat(H)_0(lambda) = lambda hat(sigma)_z + Omega hat(sigma)_x  $
- The calculated CD HamiltonianL 
$ H_"CD" = f(lambda) hat(sigma)_y $
There exists new operators which were not present in original Hamiltonian. And the direct implementation is challenging.

== effective counterdiabatic driving Hamiltonian
- Question: how to approximately achieve the effective shortcut to adiabaticity using control parameters at hand? (quantum control theory@PhysRevA.98.043436) 

- Method: 
  - The effective CD Hamiltonian $-i H_"CD" (lambda)$ belongs to the dynamic Lie algebra of the control systems@PhysRevA.98.043436. 
  - Desining suitable control function $c_i(t)$ generate the target evolution:
  $ hat(H)(t) = sum_(i=1)^N c_i(t) hat(H)_i $

== Construction of effective CD Hamiltonian
- target evolution:
$ hat(U)(t) = cal(T)exp(-i integral_0^t hat(H)(t^prime)d t^prime) $
- Floquet engineering@PhysRevX.4.031027@Bukov04032015@RevModPhys.89.011004: deviding time $tau$ to n time steps during which driven hamiltonian is approximately constant: $hat(H)_"CD"^([n]) = hat(H)_"CD" ("nT" + T/2)$
- $c_i (t)$ is parametrised as time-periodic with angular frequency $omega = 2pi\/T$ using truncated Fourier series with L harmonics of $omega$ for nth timestep@PhysRevLett.113.010501
$ c_i(t) = sum_(j=1)^L [A_"ij"^([n])sin(j omega t) + B_"ij"^([n])cos(j omega t)] $  
- Applying Floquet theory in each time step(due to the time periodicity of $c_i(t)$): decomposed $ hat(U)(t) = hat(K)(t)exp(-i hat(H)_F t) $
   - $hat(H)_F$: Floquet Hamiltonian
   - $hat(K)(t)$: periodic operator.

== Deriving Floquet Hamiltonian
- Magnus expansion: 
$ hat(H)_F^((0)) = 1/T integral_0^T hat(H)(t)"dt" $
$ hat(H)_F^((1)) = -i/2T integral_0^T integral_0^t [hat(H)(t),hat(H)(t^prime)]d t^prime"dt" $
- Periodic Hamiltonian $hat(H)(t)$: Fourier series expansion:
$ H(t) = sum_(n=-infinity)^(+infinity)H_n e^(i n omega t) $
Thus, 
#figure(
  image("ham.png", width: 70%),
)
imposing the matching condition $hat(H)_F^([n]) = hat(H)_"CD"^([n])$ to solve for coefficients $A_"ij"^([n])$ and $B_"ij"^([n])$.
#figure(
  image("effH.png", width: 70%),
)
== Application:frequency-modulated-STIRAP
- Due to selective rules(or some other reasons), the system cannot be directly transfered from state $|0 angle.r$ to $|2 angle.r$. The system can be transfered from $|0 angle.r$ to $|2 angle.r$ by using the intermediate state $|1 angle.r$ as a bridge.
- The exact CD fields is applied to realize the transition between $|0 angle.r$ and $|2 angle.r$.
#figure(
  image("sti.png", width: 50%),
)
- Effective CD Hamiltonian can be achieved through adding new Fourier components to the original Hamiltonian.(Pump and Stokes Rabi frequency).

== Application: acceration of CZ gate
 $ H(t) = H_d (t) times.circle I + I times.circle H_d (t) + V|"rr" angle.r angle.l "rr"| $

 $ H_d (t) = Omega(t)/2 (|r angle.r angle.l 1| + |1 angle.r angle.l r|) + Delta(t)|r angle.r angle.l r| $

 
#figure(
  image("CZgate.png", width: 40%),
)

- state involvement: 
$ |1 angle.r -> |r angle.r ->-|1 angle.r $
$ |11 angle.r -> |+ angle.r ->-|11 angle.r $

== Reference
#bibliography("ref.bib")

