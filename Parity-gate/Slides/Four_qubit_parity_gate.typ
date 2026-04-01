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
    title: [Quantum Optimization via Four-Body Rydberg Gates],
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

== What is the main work?
- Implementing a four-qubit parity-controlled gate in a two-dimensional neutral-atom array.
#figure(
    image("parityencoding.png", width: 38%),
  )

== Why is it important?
- Problem: Long-range interactions in optimization problems($hat(H)_P$ for example).
#figure(
    image("hami1.png", width: 55%),
  )
//$ hat(H)_P = sum_i J_i hat(sigma)_z^((i)) + sum_(i<j) sigma_z^((i))sigma_z^((j)) + sum_(i<j<k)J_("ijk") hat(sigma)_z^((i))sigma_z^((j))sigma_z^((k)) + ... $
//== Solving combinatorial optimization problems:
//- QAOA: Finding the approximate solutions to CO problems.
//General N-spin problem Hamiltonian:
//$ hat(H)_P = sum_i J_i hat(sigma)_z^((i)) + sum_(i<j) sigma_z^((i))sigma_z^((j)) + sum_(i<j<k)J_("ijk") hat(sigma)_z^((i))sigma_z^((j))sigma_z^((k)) + ... $
//including local fields and long-ranged higehr-order interactions.

//- Limitations of QAOA in Rydberg atom arrays:
//-- binary nature of Rydberg interactions.

//-- polynomially decaying interaction strengths.

//-- Scalable implementation for very specific problems.
//== Parity encoding:
//- Difficulty in optimization problem: Long-range interactions in optimization problems.($hat(H)_P$ for example)
- Solution: introduction of ancella physical spin according to Lechner–Hauke–Zoller(LHZ) architecture@Lechner2015, for example, $sigma_z^((i)) = sigma_z^((mu)) sigma_z^((v))$. 

$ |arrow.t arrow.t angle.r, |arrow.b arrow.b angle.r -> |+angle.r $
$ |arrow.t arrow.b angle.r, |arrow.b arrow.t angle.r -> |-angle.r $

- Advantages:interaction energy of a pair of logical spins $->$ local field acting on a single physical spin.
- Constraint terms: Larger Hilbert space K for ancella qubits(only concerning neighbor spins), stabilizer constraints are required.

-- Three qubits: corresponding to triangular closed loop.

-- Four qubits: corresponding to square closed loop.

- Optimization problem in LHZ architecture:
#figure(
    image("hami2.png", width: 55%),
  )
//$ H_("parity") = sum_("all interaction terms")J_"ij" dot tau_"ij"^z + "singular terms" + "restraints" $
//- Most nontrivial part: many-body phase gate.
== Why is it important
- Requirements for QAOA: problem dependent single-qubit gates, problem independent multi-qubit phase gates acting on three or four qubits.
#figure(
    image("parityencoding.png", width: 38%),
  )
- QAOA can generate states with applying each hamiltonian p times
$ |Psi(bold(alpha), bold(beta), bold(gamma)) angle.r = product_(j=1)^p e^(-i alpha_j hat(H)_X)e^(-i beta_j hat(H)_Z)e^(-i gamma_j hat(H)_C)|plus angle.r^(times.circle K) $

- Essential: Implementation of most nontrivial part, many-body phase gate $e^(-i gamma H_C)$

== How to construct the gate@PhysRevLett.128.120503
- Target four-qubit parity phase gate: 
$ U_"plaquette" (gamma)|z_("odd")angle.r = e^(i gamma)|z_"odd" angle.r $
$ U_"plaquette" (gamma)|z_("even")angle.r = e^(- i gamma)|z_"even" angle.r $

- Hamiltonian for 2x2 plaquette:
$ hat(H)_("2x2") = sum_i [-Delta(t)|r_i angle.r angle.l r_i| + Omega(t)/2 |r_i angle.r angle.l arrow.b i| + H.c.] + sum_(i<j)V_("ij")|r_i r_j angle.r angle.l r_i r_j| $

== Construction of the parity-controlled gate
- Through exact diagonalization, we can obtain the eigenstates and eigenvalues of the Hamiltonian.
#figure(
    image("phasegate.png", width: 78%),
  )
- dashedlines($Omega = 0$), solid lines($Omega > 0$) with anti-crossings. 

== How to engineer the pulse?
- Target: adiabatically connecting the initial state and many-body eigenstates(determined by initial detuning value).


== Two pause protocol
- Adiabatic trajectory:
$ (0,Delta_"start")->(Omega_A,Delta_A)->"pause"->(Omega_B, Delta_B)->"pause"->(0,Delta_"end") $

- Adjusting the pause duration $t_"A,B"$ for realizing arbitrary phase $gamma$ instead of reoptimizing the whole trajectory.
- The $(Omega_A,Delta_A), (Omega_B, Delta_B)$ can be optimized globally in the beginning.
- Advantage: After the global optimization, executing QAOA with changing holding times.
== Optimizing ramp parameters
- Based on quantum adiabatic branchistochrones.@PhysRevLett.103.080502

#figure(
    image("adiabaticoptimize.png", width: 55%),
  )

== QAOA simulations




== Technique details: Two-pause protocol
- Symbolic representation of phase difference:

$ delta Phi_a = Phi_0 + Phi_4 - Phi_1-Phi_3 $

$ delta Phi_b = 2 * Phi_2 - Phi_1-Phi_3 $


- The pause shape:

-- (i) ramp $(0, Delta_"start")-> (Omega_A, Delta_A)$--[$delta Phi_"a,b"^((1))$]

-- (ii) hold at ($Omega_A, Delta_A$) for time $T_A$--[$delta Phi_"a,b"^((2))$]

-- (iii) ramp $(Omega_A, Delta_A)->(Omega_B, Delta_B)$--[$delta Phi_"a,b"^((3))$]

-- (iv) hold at ($Omega_B, Delta_B$) for time $T_B$--[$delta Phi_"a,b"^((4))$]

-- (v) ramp $(Omega_B, Delta_B)->(0, Delta_"end")$--[$delta Phi_"a,b"^((5))$]

- Total phase difference: 

$ delta Phi_"a,b" = sum_(v=1)^5 delta Phi_"a,b"^((v)) $

- The laser parameters:

$ bold(Omega) = (Omega_A,Omega_B) $

$ bold(Delta) = (Delta_"start", Delta_A,Delta_B, Delta_"end") $

-- The parameter in ramp process are avaliable, and the corresponding energy is known.

-- The only variables are the holding times $T_A$ and $T_B$.
== Technique details: Two-pause protocol
- The linear equations:
$ T_A * delta E_a (Omega_A, Delta_A) + T_B * delta E_a (Omega_B, Delta_B) + delta Phi_a^"ramps" = delta Phi_a + 2pi m_a $

$ T_A * delta E_b (Omega_A, Delta_A) + T_B * delta E_b (Omega_B, Delta_B) + delta Phi_b^"ramps" = delta Phi_b + 2pi m_b $

- From which, we can obtain the shortest non-negative holding times depending on $m_"a,b" in Z$
#figure(
    image("shortesttime.png", width: 78%),
  )

- Now, computing worst-case holding times for given laser-parameters:
#figure(
    image("hold1.png", width: 48%),
  )

== Technique details: Two-pause protocol
- the corresponding gate time is $2(T_"ramps" + T_"hold"^"worst")$ which can be used to find the optimal laser parameters ($bold(Omega)^*, bold(Delta)^*$)
#figure(
    image("hold2.png", width: 58%),
  )

== Technique details: Time-optimal adiabatic ramps.
- Target: Finding the time-optimal adiabatic ramps in the unshaded region.

#figure(
    image("twopause.png", width: 54%),
  )

== Technique details: Time-optimal adiabatic ramps(example)
- Example: Ramps $(Omega_0, Delta_0) -> (Omega_1, Delta_1)$ Intention for preparing single target eigenstate of $H(Omega_1, Delta_1)$. 
- Arbitrary continuous path $(f_Omega (s), f_Delta (s))$ with $s in [0,1]$.
$ (f_Omega (0), f_Delta (0)) = (Omega(0), Delta(0)) $
$ (f_Omega (1), f_Delta (1)) = (Omega(1), Delta(1)) $
$ Omega_(f_Omega , T) (t) = f_Omega (t\/T) $
$ Delta_(f_Delta , T) (t) = f_Delta (t\/T) $
- Fidelity: $F_T [f_Omega, f_Delta] = |angle.l psi(T)|E_"targ" (T)|^2$
- We intend for a minimum time under the constraint of fidelity.
== Technique details: Time-optimal adiabatic ramps(example)
- Comparing among different paths:
-- Linear path

-- third order spline interpolation to generate the paths.
#figure(
    image("path.png", width: 78%),
  )

== Quantum search by local adiabatic evolution@PhysRevA.65.042308
#tblock(title: [Adiabatic theorem])[
- system state: 
$ i d/"dt" |Psi(t) angle.r = H(t)|Psi(t) angle.r $

- Eigenstate of H(t):
$ H(t)|E_k; t angle.r = E_k (t)|E_k;t angle.r $

- minimum energy gap:
$ g_"min" = min_(t in [0,T]) [E_1 (t) - E_0 (t)| $
- maximum value of the matrix element of dH/dt between the two corresponding eigenstates:
$ D_"max" = max_(t in [0,T]) |angle.l "dH"/"dt" angle.r_(1,0)| = max_(t in [0,T]) |angle.l E_1;t|"dH"\/"dt"|E_0; t angle.r| $

- Fidelity condition:
$ F_T = |angle.l E_0;T|Psi(T) angle.r|^2 >> 1 - epsilon^2 $

- Adiabatic condition:
$ D_"max"/g_"min"^2 <= epsilon $
]

#tblock(title: [global adiabatic-search algorithm])[
- target: prepare the system in ground state of easily-built Hamiltonian and change progressively this Hamiltonian into the other one in order to get.

- System: n qubits, Hilbert space $N = 2^n$. Basis state: $|i angle.r (i = 0, ..., N-1)$. Intention to search for the target state $|m angle.r$.
--initial state: $|psi_0 angle.r = 1/sqrt(N) sum_(i=1)^(N-1)|i angle.r$.

-- initial Hamiltonian: $H_0 = I-|psi_0 angle.r angle.l psi_0| $ with ground state $|psi_0 angle.r$.

-- Target Hamiltonian: $H_T = I - |m angle.r angle.l m|$ with ground state $|m angle.r$.

-- time-dependent Hamiltonian:
$H(t) = (1-s) H_0 + s * H_T$ for $s = t/T, t in [0,T]$.

- Eigenvalues:(n=64)
#figure(
    image("eigen.png", width:50%),
  )
- The energy gap $g(s) = sqrt(1-4(1-1/N)s(1-s))$ with minimum value $g_"min" = 1/sqrt(N)$ at s=0.5. Under the adiabatic condition, the computation time is $T>=N/epsilon$ of order N, which is no advantage over classical algorithms.
]
#tblock(title: [Optimizing: local adiabatic-search algorithm])[
- target: Limit is only severe around the minimum energy gap.

- Dividing T into infinitesimal time intervals dt and applying the adiabaticity condition locally to each of these intervals. 

- The evolution rate is varied continuously in time and speedup the evolution. The linear evolution function s(t) should be replaced by adapting the evolution rate ds/dt to the local adiabaticity condition.

#figure(
    image("condition.png", width: 70%),
  )
#figure(
    image("s.png", width: 60%),
  )
#figure(
    image("improve.png", width: 65%),
)
]









== Reference
#bibliography("reference.bib")

