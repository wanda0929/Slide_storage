#import "lib.typ": conf, part
#import "@preview/physica:0.9.4": *

#show: doc => conf(
  title: [Notes on the MPS and PEPS],
  authors: (
    (
      name: "Han Wang",
      email: "hwang924@connect.hkust-gz.edu.cn",
    ),
    (
      name: "Jin-Guo Liu",
      email: "jinguoliu@hkust-gz.edu.cn",
    ),
  ),
  doc,
)
== Introduction

- A parity-controlled gate: 由控制比特的奇偶性（是否为偶数个1）来决定是否施加操作。（可用于error correction当中检测比特翻转）

- method: spin-exchange dipolar interactions between Rydberg atoms.

== Model
- 2D square array composed of control atom C and target atom T(Perpendicular to quantization axis z). 

