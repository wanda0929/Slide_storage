#import "@preview/touying:0.6.1": *
#import "lib.typ": *
#import "@preview/muchpdf:0.1.1": muchpdf

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
    title: [Open Quantum System Dynamics and Lindblad Equation],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)
#let scr(it) = text(
  stylistic-set: 1,
  box($cal(it)$),
)
#title-slide()

//#outline-slide()

// Extract methods
#show strong: alert

== Open quantum models -- Realistic
- interacting with environment(decoherence and dissipation)
- Dynamical method: Lindblad master equation
$ (d rho)/(d t) = -i[H, rho] + sum_k (L_k rho L_k^dagger - 1/2 {L_k^dagger L_k, rho}) $
#figure(
  image("open_system.png", width:38%),
  caption: [Schematic of an open quantum system interacting with its environment.],
)

== Bottlenecks: expontential wall
- Square of dimensions $->$ exponential memory and computational crisis. For N qubits, dim=$2^N$, memory scales as $ O(4^N)$($<12$ qubits simulation)
#figure(
  image("exp_wall.png", width:50%),
  caption: [The Hilbert space of an N-qubit system grows exponentially with N, making simulations computationally intensive.],
)
== More efficient methods
- Lindbladian matrix: vectorization
$ dot(rho) = scr(L)(rho) $
with formal solution:
$ rho(t) = exp(scr(L) t) rho(0) $

- alternative: Expand the exponential with Tylor series and apply the action of $scr(L)$ on $rho$ iteratively:
$ rho(t) = sum_{n=0}^{infinity} (t^n)/(n!) scr(L)^n rho(0) $

#figure(
  image("tylor.png", width:90%),
  caption: [Conputation complexity comparison between direct matrix exponentiation and Taylor series expansion methods for simulating open quantum systems.],
)
== paradigm shift: unravelling the density matrix into trajectories
- New idea: Monte Carlo wavefunction method(MCWF), or quantum trajectories.
- Methods: Evolution of density matrix $rho$ $->$ evolution of pure quantum states $psi$ with stochastic quantum jumps. 
- Exact density matrix recovered by averaging over many trajectories.
$ rho(t) = (1/N) sum_{i=1}^{N} |psi_i (t)angle.r angle.l psi_i (t)| $
#figure(
  image("trajectory.png", width:90%),
  caption: [Schematic of the Monte Carlo wavefunction method, illustrating the evolution of pure states with stochastic jumps to recover the density matrix.],
)

== MCWF: Smooth evolution punctuated by random jumps
- Deterministic evolutions: state $|Psi angle.r$ evolves under non-Hermitian Hamiltonian:
$ H_"eff" = H - i/2 sum_k L_k^dagger L_k $
-- Norm decay: time evolution not unitary for the non-Hermitian Hamiltonian:
$ U(delta t) = exp(-i H_"eff"delta t\/planck)$
$ angle.l psi(t + delta t)|psi(t + delta t) angle.r = 1-delta p $
where $delta p$ just the probability of a jump occurring in time interval $delta t$:
$ delta p = delta t sum_k angle.l psi(t)| L_k^dagger L_k |psi(t) angle.r $
#figure(
  image("squarenorm.png", width:50%),
  caption: [Illustration of the Monte Carlo wavefunction method showing decay process under a non-Hermitian Hamiltonian.],
)
== MCWF: Smooth evolution punctuated by random jumps
- Stochastic jumps: at random times, state jumps according to jump operators $L_k$ with probability $delta p$
$ |psi angle.r -> (L_k |psi angle.r)/sqrt(angle.l psi| L_k^dagger L_k |psi angle.r) $

- Main process:
#figure(
  muchpdf(
    read("mcwf.pdf", encoding: none),
    width: 26cm,
    alt: "Experimental setup for holographic optical tweezers",
  ),
  caption: [Illustration of specific steps in Monte Carlo wavefunction method.
  ],
) 

== Next bottleneck: state vector itself is still exponentially large
New limit: the computational complexity per trajectory step is still $O(2^N)$ for N qubits.($<20$ qubits simulation)
#figure(
  image("wall.png", width:30%),
  caption: [The Hilbert space of an N-qubit system grows exponentially with N, making simulations computationally intensive.],
)

== Breakthrough: compressing the state vector with tensor networks
- MPS: $2^n$ parameters $->$ $O(n chi^2)$ parameters with bond dimension $chi$.(polynomial scaling)
// $ |psi angle.r = sum_(sigma_1, ..., sigma_L=1)^d psi_(sigma_1, ..., sigma_L)|sigma_1, ..., sigma_L angle.r $

$ |psi angle.r = sum_(sigma_1, ..., sigma_L=1)^d M_1^(sigma_1)... M_L^(sigma_L)|sigma_1, ..., sigma_L angle.r $


#figure(
  image("mps.png", width:80%),
  caption: [Matrix Product State (MPS) representation of a quantum state, illustrating the decomposition into local tensors connected by bond dimensions.],
) 

== TJM: Tensor jump method: 
#figure(
  image("tjm.png", width:99%),
)

== Mechanism of TJM
#figure(
  image("tjm_method.png", width:99%),
)
== Three pillars of TJM
TJM overcomes the limitations of previous methods through three key innovations:
- Compressing Reality: Stochastic Quantum Trajectories meet Matrix Product States (MPS) to efficiently represent quantum states.
- Evolving with Precision: Implementing Dynamic time-dependent Variational Principle (TDVP) for optimal, error-controlled evolution of MPS.
- Guaranteeing Accuracy: Higher-order time splitting methods to minimize errors during time evolution as well as keep approximately unchanged computational cost.


== Benchmarking TJM: Convergence reliability
- Solid line: TJM converges at the expected Monte Carlo rate of $1\/sqrt(N_"trajectories")$. And keep convergence as we increase the time step $delta t$.
#figure(
  image("convergence.png", width:40%),
  caption: [Benchmarking results demonstrating the convergence and reliability of the Tensor Jump Method (TJM) for simulating open quantum systems.],
)

== Benchmarking TJM: Effect of Bond Dimension & Time
#figure(
  image("bond.png", width:50%),
  caption: [Impact of bond dimension and evolution time on the accuracy of the Tensor Jump Method (TJM). The trajectories are vital to the accuracy and the bond dimension are not so sensitive.],
)

== Benchmarking TJM: 30 sites VS MPO

- 30-sites XXX Heisenberg chain in open system. Comparing with MPO method(`LindbladMPO`).
#figure(
  image("30sites.png", width:66%),
  caption: [Comparison between the Tensor Jump Method (TJM)[5min] and Matrix Product Operator (MPO)[$>24$hours] methods for simulating a 30-site Heisenberg chain in an open quantum system.],
) 
== Benchmarking TJM: 100 sites Analytical Check
- 100-site edge-driven XXX chain.
- Comparing simulation results with analytical solutions for steady-state currents.

#figure(
  image("100sites.png", width:50%),
  caption: [Validation of the Tensor Jump Method (TJM) through comparison with analytical solutions for a 100-site edge-driven Heisenberg chain.],
)

== Benchmarking TJM: 1000 sites
- 1000 qubit Heisenberg XXX chain in an open system with consumergrade CPU.
#figure(
  image("1000sites.png", width:60%),
  caption: [Simulation of a 1000-site Heisenberg XXX chain in an open quantum system using the Tensor Jump Method (TJM) on a consumer-grade CPU.],
)
== Trial: simulation on Transverse field Ising model
$ H_0 = -J sum_(i=1)^(L-1) sigma_i^z sigma_(i+1)^z - g sum_(i=1)^L sigma_i^x $
#figure(
  image("nas_heatmap.png", width:50%),
  caption: [Preliminary results of simulating the Transverse Field Ising Model using the Tensor Jump Method (TJM).],
)

// == Reference
// #bibliography("ref.bib")

