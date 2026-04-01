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

== background
#tblock(title: [Hamitonians of driven/target system])[
  - Driven system: $hat(H)(t) = Omega_1hat(X)_1 + Omega_4hat(X)_4 + g_13 (t) (hat(X)_1 hat(X)_3 + hat(Y)_1 hat(Y)_3) + g_23 (t) (hat(X)_2 hat(X)_3 + hat(Y)_2 hat(Y)_3) + g_24 (t) (hat(X)_2 hat(X)_4 + hat(Y)_2 hat(Y)_4)$
  
  #figure(
    image("drivingscheme.png", width: 55%),
  )

  - Target system: $hat(H)_omega = -J sum_(i,j)(hat(X)_(i,j)hat(Z)_(i,j+1)hat(Z)_(i+1,j)hat(X)_(i+1,j+1))$ 
]

#tblock(title: [Evolution process])[
  - Comparasion of state evolution in driven and target system:
  #figure(
    image("ZZ1.png", width: 50%),
  )
  #figure(
    image("ZZ2.png", width: 55%),
  )
  #figure(
    image("ZZ3.png", width: 55%),
  )
  #figure(
    image("ZZ4.png", width: 65%),
  )
]

#tblock(title: [Possible nested commutators of control operators])[
  - All operators in effective Hamiltonian $H_(i,j)$:
  $ exp(-i hat(H)_(i,j) tau) = Tau exp(-i integral_0^tau "dt"hat(H)(t)) $
  #figure(
    image("dla.png", width: 61%),
  )
]

== The Lie-algebra decoupling theorem
#tblock(title: [Lie-algebra decoupling theorem])[
  - For Hermitian time-dependent Hamitonian $hat(H)(t)$, the time-evolution operator is: $ hat(U)(t) = Tau exp(-i integral_0^tau "dt"hat(H)(t)) $
  and $H(t) = sum_(j=1)^m G_j(t)hat(H)_j$. It can be extended to larger set with $n gt.eq m$ elements by taking the commutator of the elements in ${hat(H)_j}$ and adding the result to the set of Hamiltonian terms. $U(t) = exp(-i*H_("eff")t)$ and $ H_("eff") = sum_(j=1)^n c_j hat(H)_j $
]
== Dynamical Lie Algebra
#tblock(title: [dynamical Lie algebras])[
  #figure(
    image("dynamiclie.png", width: 100%),
  )
 
]
== Dynamical Lie Algebra
#tblock(title: [dynamical Lie algebras])[
   - The Lie closure can be computed by the Pennylane library:
  ```python
      ops = [...] "All operators in driven Hamitonian"
      dla = qml.lie_closure(ops)
      print(dla)
  ```
  - Lie closure: all possible nested commutators of the generators $hat(G)_j$ in driven Hamitonian.
  #figure(
    image("result.png", width: 100%),
  )
]

#tblock(title: [dynamical Lie algebras])[
  - The table in page3 can be calculated with Dynamical Lie Algebra.(https://pennylane.ai/qml/demos/tutorial_liealgebra)
  Comutators1:
  #figure(
    image("c1.png", width: 100%),
  )
  commutator2:
  #figure(
    image("c2.png", width: 100%),
  )
  commutator3:
  #figure(
    image("c3.png", width: 80%),
  )
  commutator4:
  #figure(
    image("c4.png", width: 50%),
  )

  extracting effective Hamitonian and weights of operators
  #figure(
    image("c7.png", width: 50%),
  )
]

== Lie- Algebra decoupling theorem
#tblock(title: [Lie- algebra decoupling theorem])[
  - Originally outlined by Wei and Norman@10.10631.1703993.
  - the non-Gaussian character of quantum optomechanical systems evolving under the fully nonlinear optomechanical Hamiltonian.@Qvarfort_2019@Bruschi_2018 @PhysRevD.87.084062@10.10631.5121397@10.10631.5106409@PRXQuantum.6.010201
  - Floquet engineering of Lie algebraic quantum systems@PhysRevB.105.L020301
  - Floquet engineering with high frequency approximation.@article@Eckardt_2015@Arnal_2018
  - High-frequency expansions for time-periodic Lindblad generators@PhysRevB.104.165414
  - Lie-algebraic classical simulations for quantum computing@goh2025liealgebraicclassicalsimulationsquantum
]





== Reference
#bibliography("ref.bib")

