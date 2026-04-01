// ═══════════════════════════════════════════════════════════════════
// Quimb Circuit Simulation — Feynman-Style Study Guide
// How Quimb maps quantum circuit simulation to tensor network contraction
// ═══════════════════════════════════════════════════════════════════

#set text(size: 11pt)
#set page(margin: 2cm)
#set heading(numbering: "1.1")

= Quimb Circuit Simulation: From State Vectors to Tensor Networks

*Goal:* Build a complete mental model of how Quimb simulates quantum circuits
by mapping them to tensor networks, and understand what determines runtime and
memory cost.

*Assumed knowledge:* Linear algebra basics (matrices, vectors, matrix
multiplication, SVD).

// ───────────────────────────────────────────────────────────────────
== Big Picture (What & Why)
// ───────────────────────────────────────────────────────────────────

A quantum circuit is a sequence of *gates* (small unitary matrices) applied to
*qubits* (two-level quantum systems). Simulating this circuit means computing
the final quantum state, sampling measurement outcomes, or evaluating specific
amplitudes/expectation values.

*The naïve approach* stores the full state vector: $N$ qubits require a vector
of $2^N$ complex numbers. At $N = 50$ that is $approx 8$ petabytes — hopeless.

*Quimb's insight:* Instead of multiplying everything into one giant vector, keep
every gate as a separate *tensor* and connect them into a *tensor network* (TN).
You never form the full state unless you have to. Depending on the circuit
structure, you can often compute answers (amplitudes, samples, expectation
values) at a cost that is *exponentially smaller* than $2^N$.

Quimb provides four simulation backends, all built on this TN idea:

#table(
  columns: (auto, auto, auto),
  [*Class*], [*Strategy*], [*Best for*],
  [`Circuit`], [Lazy TN — contract only when asked], [Exact amplitudes; medium-depth circuits],
  [`CircuitMPS`], [Eager MPS — compress after every gate], [Near-1D circuits; approximate sampling],
  [`CircuitPermMPS`], [MPS with lazy qubit permutation], [Non-local circuits handled via MPS],
  [`CircuitDense`], [Full dense state vector (wrapped in TN)], [Small circuits ($N lt.eq 25$)],
)

// ───────────────────────────────────────────────────────────────────
== Core Ideas
// ───────────────────────────────────────────────────────────────────

=== Definition: Tensor

A *tensor* is a multi-dimensional array of numbers. The number of dimensions is
called its *rank* (or *order*).

- Rank 0: a scalar (single number)
- Rank 1: a vector ($d$ entries)
- Rank 2: a matrix ($d_1 times d_2$)
- Rank 3+: a "cube" of numbers and beyond

Each dimension is labeled by an *index* (in Quimb, a string like `"k0"` or
`"_abc123"`). The size of each index is its *dimension* — for qubits this is
always 2.

In Quimb, a `Tensor` object has three attributes:
- `data`: the actual numerical array (NumPy, CuPy, JAX, etc.)
- `inds`: ordered tuple of index name strings, one per dimension
- `tags`: a set of label strings for identification and selection

=== Definition: Tensor Network

A *tensor network* (TN) is a collection of tensors whose indices are connected.
Two tensors sharing the same index name are implicitly connected by a *bond*.
*Contracting* a bond means summing over that shared index — this is the
generalization of matrix multiplication.

*Key insight:* The order in which you contract bonds drastically affects the
cost. Finding the optimal contraction order is NP-hard in general, but good
heuristic optimizers (like `cotengra`) can find near-optimal paths.

=== How Quimb Represents a Quantum Circuit as a TN

*Step 1 — Initial state:* The $|0 dots 0 angle.r$ state is represented as $N$
separate rank-1 tensors (vectors), one per qubit:

$ |0 angle.r = vec(1, 0) $

Each tensor has one *open index* (labeled `k0`, `k1`, ..., `kN-1`) of size 2.

*Step 2 — Gates become tensors:*

- *1-qubit gate* (e.g., Hadamard $H$): a $2 times 2$ unitary matrix #sym.arrow
  rank-2 tensor. It has one "incoming" index (connected to the qubit wire below)
  and one "outgoing" index (the new wire above). Applying it just inserts a new
  tensor that absorbs the old index and exposes a new one.

- *2-qubit gate* (e.g., CNOT): a $4 times 4$ unitary matrix #sym.arrow reshaped
  to a rank-4 tensor with shape $(2, 2, 2, 2)$. The four indices are: two
  "incoming" (one per qubit, from below) and two "outgoing" (one per qubit,
  going up).

*Step 3 — Connecting the network:* Each gate tensor's "incoming" indices are
identified with the "outgoing" indices of whatever tensor last touched that
qubit wire. The result is a 2D-ish network where time flows upward and qubit
wires flow left-to-right.

*Step 4 — Default gate splitting:* By default
(`contract='auto-split-gate'`), Quimb decomposes each 2-qubit gate tensor via
SVD into *two* tensors connected by a bond. This keeps the TN "thin" (every
tensor touches at most one qubit wire), which helps contraction optimizers find
better paths.

#block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  [*Socratic Checkpoint 1:* If I give you a 3-qubit circuit that applies $H$
  to qubit 0, then CNOT on qubits 0-1, then CNOT on qubits 1-2 — how many
  tensors are in the TN (with default gate splitting)? What are their ranks?

  _Think about it before reading on._

  Answer: 3 initial-state tensors (rank 1 each) + 1 $H$ tensor (rank 2) + 2
  CNOT gates × 2 tensors each after splitting (rank 3 each) = *8 tensors*.
  Ranks: three rank-1, one rank-2, four rank-3.],
)

=== Definition: Contraction Width

The *contraction width* $w$ of a tensor network (given a contraction ordering)
is $log_2$ of the size of the largest intermediate tensor produced during
contraction.

- *Memory* required scales as $O(2^w)$
- *Time* scales at least as $O(2^w)$ (often more, as $O(2^c)$ where $c$ is the
  "contraction cost" combining FLOPs and intermediate sizes)

You can check this in Quimb with:
```python
width = tn.contraction_width(optimize='random-greedy')
```

=== Definition: Bond Dimension ($chi$)

In MPS-based simulation, the *bond dimension* $chi$ is the size of the indices
connecting neighboring tensors in the chain. It controls:

- *Memory:* $O(N chi^2)$ for $N$ qubits
- *Time per gate:* $O(chi^3)$ for an SVD-based gate application
- *Accuracy:* Larger $chi$ captures more entanglement; truncating to a fixed
  $chi$ introduces approximation error tracked by `fidelity_estimate()`

=== Definition: Entanglement & Why It Matters

*Entanglement entropy* $S$ across a cut of the qubit chain determines how large
$chi$ must be for an exact MPS representation: $chi gt.eq 2^S$.

Highly entangling circuits (random circuits, many non-local gates) need
exponentially large $chi$ for exact MPS simulation. This is exactly when the
lazy TN approach (`Circuit`) with exact contraction may be the better choice —
or when approximation is necessary.

// ───────────────────────────────────────────────────────────────────
== Quimb's Two Main Simulation Paths
// ───────────────────────────────────────────────────────────────────

=== Path A: Lazy Tensor Network (`Circuit`)

```python
import quimb.tensor as qtn

# 1. Build the circuit
circ = qtn.Circuit(N=10)
for i in range(10):
    circ.apply_gate('H', i, gate_round=0)
for r in range(1, 5):
    for i in range(0, 10, 2):
        circ.apply_gate('CNOT', i, i + 1, gate_round=r)
    for i in range(10):
        circ.apply_gate('RY', 1.234, i, gate_round=r)

# 2. The TN is stored lazily — nothing contracted yet
print(circ)
# <Circuit(n=10, num_gates=..., ...)>

# 3. Access the state TN
tn = circ.psi  # a TensorNetwork object, not yet contracted

# 4. Compute an amplitude (contracts the full network)
bitstring = '0' * 10
amplitude = circ.amplitude(bitstring)
print(f"|<{bitstring}|psi>|^2 = {abs(amplitude)**2:.6f}")
```

*What happens under the hood:*

- `circ.psi` returns the full TN (initial state tensors + all gate tensors)
- `circ.amplitude(b)` creates a *closed* TN by adding bra tensors
  $angle.l b |$ at the top, then contracts everything
- The contraction order is found by an optimizer (default: `'auto'` which tries
  several strategies; for serious work use `cotengra`)

=== Path B: MPS Simulation (`CircuitMPS`)

```python
import quimb.tensor as qtn

# 1. Build the circuit with MPS backend
circ = qtn.CircuitMPS(N=20, max_bond=64, cutoff=1e-10)
for i in range(20):
    circ.apply_gate('H', i)
for r in range(5):
    for i in range(0, 19, 2):
        circ.apply_gate('CNOT', i, i + 1)
    for i in range(1, 19, 2):
        circ.apply_gate('CZ', i, i + 1)

# 2. State is always an MPS — compressed after every 2-qubit gate
print(f"Max bond dimension: {circ.psi.max_bond()}")
print(f"Estimated fidelity: {circ.fidelity_estimate():.8f}")
print(f"Estimated error:    {circ.error_estimate():.2e}")

# 3. Sample bitstrings (very efficient for MPS)
for b in circ.sample(5, seed=42):
    print(b)
```

*What happens under the hood:*

- The state starts as an MPS with bond dimension 1 (product state $|0...0 angle.r$)
- Each 2-qubit gate is applied by contracting the gate tensor with the two
  relevant MPS site tensors, then doing an SVD to split them back, truncating
  to `max_bond`
- Non-nearest-neighbor gates: Quimb inserts SWAP gates to bring qubits adjacent,
  applies the gate, then swaps back (or uses `CircuitPermMPS` to avoid swapping
  back, lazily tracking the permutation)
- The norm tracks accumulated truncation error #sym.arrow `fidelity_estimate()`

#block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  [*Socratic Checkpoint 2:* You have a 50-qubit random circuit with many
  long-range gates. Would you pick `Circuit` or `CircuitMPS`? Why?

  _Hint: Think about what "random" and "long-range" imply for entanglement
  and contraction width._

  Answer: It depends on your goal. For exact amplitudes, use `Circuit` with
  `cotengra` — though it may still be intractable if contraction width is too
  high. `CircuitMPS` would give fast approximate results but with potentially
  large error (high entanglement #sym.arrow needs huge $chi$). Often for random
  circuits the TN approach with bond cutting is the practical choice.],
)

// ───────────────────────────────────────────────────────────────────
== What Determines Runtime & Memory
// ───────────────────────────────────────────────────────────────────

#table(
  columns: (auto, auto, auto),
  [*Factor*], [*Affects*], [*How*],
  [Contraction width $w$],
    [Exact TN contraction],
    [Memory $approx 2^w$; time $gt.eq 2^w$],
  [Bond dimension $chi$],
    [MPS simulation],
    [Memory $approx N chi^2$; time/gate $approx chi^3$],
  [Entanglement],
    [Both],
    [High $S$ #sym.arrow large $chi$ or large $w$],
  [Gate layout / connectivity],
    [Both],
    [1D-local #sym.arrow small $chi$; all-to-all #sym.arrow bad for MPS],
  [Circuit depth],
    [Both],
    [More gates #sym.arrow more tensors #sym.arrow harder contraction],
  [Contraction ordering],
    [Exact TN],
    [Bad order: $2^N$; good order: possibly $2^(N slash 2)$ or less],
  [Simplification],
    [Exact TN],
    [`rank_simplify`, `compress_simplify` reduce tensor count],
)

*Rule of thumb:* If the circuit is "near-1D" (gates mostly between neighbors)
and entanglement stays bounded, use `CircuitMPS`. For arbitrary connectivity
or when exact amplitudes are needed, use `Circuit` with a good optimizer.

// ───────────────────────────────────────────────────────────────────
== Contraction Strategies in Practice
// ───────────────────────────────────────────────────────────────────

=== Choosing an Optimizer

```python
import cotengra as ctg

# High-quality reusable optimizer (caches results)
opt = ctg.ReusableHyperOptimizer(
    minimize="combo",      # balance flops and memory
    reconf_opts={},        # enable subtree reconfiguration
    parallel=True,         # search in parallel
    max_time="rate:1e8",   # spend time proportional to problem size
    directory=True,        # cache to disk
    progbar=True,          # show progress
)

# Quick estimate with random-greedy (good for rough checks)
import quimb.tensor as qtn
circ = qtn.Circuit(30)
# ... add gates ...
width_estimate = circ.psi.contraction_width(optimize='random-greedy')
print(f"Contraction width ~ {width_estimate}")

# Rehearse: estimate cost without actually contracting
info = circ.amplitude_rehearse(optimize=opt)
print(info)  # shows flops, width, size
```

=== TN Simplification Before Contraction

```python
# Get the amplitude TN (closed network, unsimplified)
tn = circ.amplitude_tn(simplify_sequence="")

# Rank simplification: absorbs all rank-1 and rank-2 tensors
# Single-qubit gates are "free" in this sense — never increase width
tn_simple = tn.rank_simplify()

print(f"Tensors: {tn.num_tensors} -> {tn_simple.num_tensors}")
print(f"Width:   {tn.contraction_width(optimize='random-greedy')}"
      f" -> {tn_simple.contraction_width(optimize='random-greedy')}")
```

=== Advanced: Bond Cutting for Large Circuits

For circuits too large for direct contraction, Quimb supports *bond cutting*:
slice a few bonds to decompose one hard contraction into many easier ones
(trading time for memory):

```python
# Identify bonds to cut
import quimb.tensor as qtn
bonds_to_cut = qtn.bonds(tn[site_a], tn[site_b])

# Each cut bond of dimension d multiplies work by d
# but reduces contraction width
total = 0
for tn_slice in tn.cut_iter(*bonds_to_cut):
    total += tn_slice.contract(all, optimize='random-greedy')
```

// ───────────────────────────────────────────────────────────────────
== Worked Example: GHZ Circuit
// ───────────────────────────────────────────────────────────────────

The GHZ state is $1 / sqrt(2) (|0 dots 0 angle.r + |1 dots 1 angle.r)$.
It has bond dimension *exactly 2* at every bipartition, making it a perfect
test case.

```python
import quimb.tensor as qtn

N = 20

# ── Exact TN approach ──
circ = qtn.Circuit(N)
circ.apply_gate('H', 0)
for i in range(N - 1):
    circ.apply_gate('CNOT', i, i + 1)

amp_0 = circ.amplitude('0' * N)
amp_1 = circ.amplitude('1' * N)
print(f"|<{'0'*N}|psi>|^2 = {abs(amp_0)**2:.6f}")  # ~ 0.5
print(f"|<{'1'*N}|psi>|^2 = {abs(amp_1)**2:.6f}")  # ~ 0.5

# ── MPS approach (exact for this 1D circuit) ──
circ_mps = qtn.CircuitMPS(N)
circ_mps.apply_gate('H', 0)
for i in range(N - 1):
    circ_mps.apply_gate('CNOT', i, i + 1)

print(f"MPS max bond: {circ_mps.psi.max_bond()}")     # 2
print(f"Fidelity:     {circ_mps.fidelity_estimate():.8f}")  # 1.0

for b in circ_mps.sample(10, seed=42):
    print(b)  # all-0s or all-1s only
```

*Why this works perfectly with MPS:* The GHZ state has entanglement entropy
$S = 1$ (one bit) across any cut. So $chi = 2^1 = 2$ suffices — the MPS is
exact.

#block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  [*Socratic Checkpoint 3:* What happens to `max_bond()` if you replace the
  CNOT-chain in the GHZ circuit with random 2-qubit unitary gates?

  Answer: The bond dimension grows exponentially (up to `max_bond` if capped),
  because random unitaries generate near-maximal entanglement. For exact MPS,
  $chi$ would grow as $2^(min(n, N - n))$ where $n$ is the partition size.],
)

// ───────────────────────────────────────────────────────────────────
== Worked Example: Overlap with a Projector-Defined State (Toric Code)
// ───────────────────────────────────────────────────────────────────

*Your goal:* compute the overlap with the toric code ground state:
$|angle.l psi_{"toric"} | psi angle.r|^2$.

*Your setup (from our discussion):*
- You prepare a circuit state by applying Hadamards on all qubits, then apply
  3-qubit classical-style gates (CCNOT / OR-like) with a *many-to-one* pattern:
  the controls are near each other but the target is long-ranged.
- You (correctly) expect these gates to increase entanglement.

=== First principles: “projector construction” for toric code

In the *standard* square-lattice toric code (qubits on edges), the stabilizers are:
- Star operators: $A_s$ is the product of $X$ on the four data qubits adjacent to the vertex (star) $s$.
- Plaquette operators: $B_p$ is the product of $Z$ on the four data qubits around the plaquette $p$.

*Implementation note (your code):* In
`OMQuTensor_quimb/src/omqutensor_quimb/gates_and_circuits/Toric_code_ground.py`
the “toric code” is implemented on a 4x4 torus with *data qubits on vertices*.
Each stabilizer still acts on 4 nearby data qubits, found via
`nth_nearest_neighbors(..., periodic_width=4.0, periodic_height=4.0)`.

The ground space is the simultaneous $+1$ eigenspace of all $A_s$ and $B_p$.
One way to define a (not yet normalized) ground state is via a projector:

$P = ∏_(s) ((I + A_s) / 2) ⋅ ∏_(p) ((I + B_p) / 2)$

Then choose a simple reference state $|phi_0 angle.r$ and project:
$|psi'_{"toric"} angle.r = P |phi_0 angle.r$,
and normalize it (divide by its norm) to get $|psi_{"toric"} angle.r$.

Common choices:
- If you start from the product state $|+ dots + angle.r$ (all Hadamards), then all star
  constraints ($A_s=+1$) already hold, and the plaquette projectors enforce
  the $B_p=+1$ constraints.
- If you start from the product state $|0 dots 0 angle.r$, then all plaquette constraints
  ($B_p=+1$) already hold, and the star projectors enforce $A_s=+1$.

=== How this becomes a Quimb computation

In Quimb, the overlap of two tensor networks is a *single scalar contraction*.
If you can represent both kets as tensor networks with the same outer indices
(one physical index per qubit), you can compute:

```python
ov = psi.overlap(phi, optimize=opt)   # computes <phi|psi>
prob = abs(ov) ** 2
```

Under the hood, `TensorNetwork.overlap()` forms the network corresponding to
$angle.l phi | psi angle.r$ and contracts it.

=== Practical advice for your specific circuit (many-to-one long-range CCNOT/OR)

1. *Your “OR gate” must be reversible/unitary.* A literal OR is not unitary.
   In practice you implement OR into a target/ancilla and possibly uncompute
   garbage. Quimb simulates unitary gates.

2. *Prefer `CircuitPermMPS` for your long-range pattern.*
   `CircuitMPS` can handle multi-qubit nonlocal gates (CCNOT, etc.) via an
   MPO-based method, but long-range, repeated interactions with one far target
   tend to drive up bond dimensions and/or SWAP overhead.
   `CircuitPermMPS` often helps because it tracks permutations lazily rather
   than swapping qubits back after each long-range interaction.

3. *Choose a good 1D ordering of qubits (MPS site order).*
   If one target interacts with many controls, place that target *near* the
   control block in the MPS ordering. This reduces the number of bonds a gate
   crosses, which reduces both cost and entanglement across the MPS cuts.

=== Skeleton code: circuit state + toric-code TN overlap

```python
import quimb.tensor as qtn

# Import your projector-built toric ground state (returns an MPS)
from omqutensor_quimb.gates_and_circuits.Toric_code_ground import (
    prepare_toric_ground_state,
    N_TOTAL,
)

# 1) Prepare your circuit state approximately as an MPS
#    (choose CircuitPermMPS for lots of long-range interactions)
circ = qtn.CircuitPermMPS(N=N_TOTAL, max_bond=256, cutoff=1e-10)

for i in range(N_TOTAL):
    circ.apply_gate('H', i)

# apply your CCNOT / reversible-OR gates here ...

psi = circ.psi  # the state as a tensor network (often an MPS-like TN)

# 2) Prepare the toric code ground state MPS via your projector construction
phi = prepare_toric_ground_state(bond_dim=256, verbose=False)

# 3) Overlap
ov = psi.overlap(phi)  # MPS ⟂ MPS overlap is an efficient TN contraction
print('overlap =', ov)
print('|overlap|^2 =', abs(ov) ** 2)
```

#block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  [*Socratic Checkpoint 4:* In MPS terms, why does a repeated long-range CCNOT
  (controls near each other, target far away) tend to increase the required
  bond dimension across many cuts?

  _Hint: Each time the gate entangles a far site with a local block, it can
  increase the Schmidt rank across every cut between them._

  Answer: Because the operator correlates degrees of freedom separated by many
  MPS bonds. Unless the resulting correlations are very low-rank, the Schmidt
  spectrum across those bonds broadens, so $chi$ must grow (or you truncate and
  lose fidelity).],
)

// ───────────────────────────────────────────────────────────────────
== Common Questions / Confusions
// ───────────────────────────────────────────────────────────────────

*Q: Why does Quimb split 2-qubit gates by default?*\
Because an unsplit rank-4 gate tensor connects two qubit wires. After splitting
(via SVD), you get two rank-3 tensors — one per qubit — connected by a small
bond. This keeps the TN "locally tree-like" which makes contraction path
finding much more effective.

*Q: Are single-qubit gates "free"?*\
Yes, in the contraction-width sense. Contracting a rank-2 tensor into the
network never increases the contraction width. `rank_simplify()` absorbs them.

*Q: When should I use `CircuitMPS` vs `Circuit`?*
- Use `CircuitMPS` when: gates are mostly local (1D-ish); you want fast
  approximate sampling; $N$ is large but entanglement is bounded.
- Use `Circuit` when: you need exact amplitudes; circuit has arbitrary
  connectivity; you have access to `cotengra` for path optimization.

*Q: What is `cotengra` and why do I need it?*\
`cotengra` is a separate library (by the same author, jcmgray) that finds
near-optimal contraction orderings for tensor networks. For circuits beyond
$approx 20$ qubits, the default optimizer is too slow/poor — `cotengra` uses
hyper-optimization and subtree reconfiguration to find vastly better paths.
Install with `pip install cotengra`.

*Q: What does `gate_contract` do in the Circuit constructors?*\
It controls how gates interact with the TN:
- `False` / `'split-gate'` / `'auto-split-gate'`: keep gates as separate
  tensors (lazy — default for `Circuit`)
- `True`: eagerly contract each gate into the state (for `CircuitDense`)
- `'swap+split'`: for `CircuitMPS`, handle non-local gates via SWAP insertion
  then SVD-split

*Q: How does Quimb apply 3+ qubit gates (e.g. CCNOT / multi-control gates) in `CircuitMPS`?*\
In the MPS backends, the default gate contraction mode is effectively
"auto-mps": 2-qubit nonlocal gates are handled by swapping sites together then
splitting, while 3+ qubit gates are applied with an MPO-based routine (often
exposed as `MatrixProductState.gate_nonlocal`). This avoids explicitly swapping
many qubits into a contiguous block, but the cost can still grow quickly if the
gate links far-separated sites and generates strong entanglement.

*Q: What is `CircuitPermMPS` for?*\
Standard `CircuitMPS` applies SWAP gates to bring distant qubits adjacent,
applies the gate, then swaps them back. `CircuitPermMPS` skips the "swap back",
instead tracking a qubit permutation lazily. This avoids unnecessary SVDs and
can be faster for circuits with no spatial locality.

// ───────────────────────────────────────────────────────────────────
== Quick Check (Self-Test Questions)
// ───────────────────────────────────────────────────────────────────

+ A 2-qubit gate (like CNOT) is stored as a tensor of what rank in Quimb?
  What shape does it have?\
  _Answer: Rank 4, shape $(2, 2, 2, 2)$. After default splitting: two rank-3
  tensors connected by a bond._

+ If a `CircuitMPS` simulation with `max_bond=128` reports
  `fidelity_estimate() = 0.85`, what does this mean?\
  _Answer: About 15% of the state's norm has been truncated away. The simulated
  state has $approx 85%$ overlap-squared with the true state._

+ You have a 50-qubit random circuit.
  `contraction_width(optimize='random-greedy')` returns 43. Can you contract
  this on a laptop with 16 GB RAM?\
  _Answer: No. $2^43 times 16$ bytes $approx 140$ TB. You need bond cutting, a
  better optimizer to lower the width, or switch to approximate MPS._

// ───────────────────────────────────────────────────────────────────
== Summary / Cheat Sheet
// ───────────────────────────────────────────────────────────────────

- *Tensor* = multi-dimensional array; *rank* = number of dimensions
- *Tensor Network* = tensors connected by shared indices; contracting = summing
  over shared indices (generalized matrix multiplication)
- *Quimb `Circuit`* builds a lazy TN: initial state ($N$ rank-1 vectors) + gate
  tensors (rank 2 for 1-qubit, rank 4 for 2-qubit)
- 2-qubit gates are *SVD-split by default* into two rank-3 tensors #sym.arrow
  keeps TN thin #sym.arrow better contraction paths
- *Contraction width* $w$ determines cost: memory $tilde 2^w$, time $gt.eq 2^w$
- *`cotengra`* finds near-optimal contraction orderings (critical for $N > 20$)
- *`CircuitMPS`* keeps state as MPS; SVD-compresses after every 2-qubit gate;
  cost per gate $tilde chi^3$
- *Bond dimension $chi$* must grow as $2^S$ (entanglement entropy $S$) for
  exact results; truncation gives approximate results tracked by
  `fidelity_estimate()`
- *Runtime drivers:* contraction width, bond dimension, entanglement, gate
  connectivity, circuit depth, contraction order, TN simplification

// ───────────────────────────────────────────────────────────────────
== Exercises
// ───────────────────────────────────────────────────────────────────

+ *Starter:* Install quimb (`pip install quimb`). Run the GHZ example. Verify
  that only all-zeros and all-ones bitstrings are sampled.

+ *Scaling:* Increase $N$ in the GHZ example from 20 to 40 to 80. Compare
  `CircuitMPS` runtime and `max_bond()`. Does bond dimension change? Why not?

+ *Random circuit stress test:* Build a 20-qubit circuit with 10 layers of
  random nearest-neighbor CNOT gates + random single-qubit rotations. Compare
  `Circuit.amplitude('0'*20)` time vs `CircuitMPS` with `max_bond=32` vs
  `max_bond=256`. How does fidelity degrade?

+ *Contraction exploration:* For the random circuit above, try
  `circ.amplitude_rehearse(optimize='random-greedy')` vs
  `circ.amplitude_rehearse(optimize='auto')`. Compare the reported flops and
  width.

// ───────────────────────────────────────────────────────────────────
== Next Step
// ───────────────────────────────────────────────────────────────────

*Action:* Install `quimb` and `cotengra`, run the GHZ example, then build a
random circuit and watch how `contraction_width()` and `max_bond()` scale with
$N$ and depth. Try the sampling methods: `circ.sample()` for MPS,
`circ.sample_gate_by_gate()` for the TN approach.

// ───────────────────────────────────────────────────────────────────
== Sources
// ───────────────────────────────────────────────────────────────────

- Quimb documentation: #link("https://quimb.readthedocs.io/")
- Quimb source (`circuit.py`, 5101 lines):
  #link("https://github.com/jcmgray/quimb/blob/main/quimb/tensor/circuit.py")
- Cotengra (contraction optimizer):
  #link("https://github.com/jcmgray/cotengra")
- Quimb circuit example notebook:
  #link("https://notebook.community/jcmgray/quijy/docs/examples/ex_quantum_circuit")
- Circuit sampling exploration:
  #link("https://quimb.readthedocs.io/en/latest/examples/ex_tn_circuit_sample_explore.html")
- PennyLane DefaultTensor tutorial (uses Quimb):
  #link("https://pennylane.ai/qml/demos/tutorial_How_to_simulate_quantum_circuits_with_tensor_networks")

// ───────────────────────────────────────────────────────────────────
== Errata
// ───────────────────────────────────────────────────────────────────

_(No corrections needed so far.)_
