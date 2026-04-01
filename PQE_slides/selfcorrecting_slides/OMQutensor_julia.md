# OMQuTensor.jl - Quantum Circuit Simulation with Tensor Networks

## Overview

OMQuTensor.jl is a Julia package for simulating quantum systems using tensor network methods. It provides two main simulation paradigms:

1. **Closed System**: Quantum circuit simulation with MPS + Local TDVP
2. **Open System**: Tensor Jump Method (TJM) with stochastic trajectories

## Architecture

```
OMQuTensor.jl
├── Core/
│   ├── MPS.jl           # Matrix Product State data structure
│   ├── MPO.jl           # Matrix Product Operator
│   ├── canonical/       # Canonical form transformations
│   └── operations.jl    # MPS operations (fidelity, norm, etc.)
├── Algorithms/
│   ├── tdvp.jl          # TDVP1 and TDVP2 implementations
│   └── krylov.jl        # Lanczos iteration and expmv
├── ClosedSystem/
│   ├── circuit.jl       # QuantumCircuit representation
│   ├── local_tdvp.jl    # Local TDVP for gate application
│   └── generators.jl    # Generator type for N-qubit gates
├── OpenSystem/
│   ├── trajectory.jl    # Trajectory simulation
│   └── sampling.jl      # Ensemble sampling
└── ToricCode/           # Toric code ground state and verification
```

---

## Core Data Structures

### 1. Matrix Product State (MPS)

**File**: `src/Core/MPS.jl`

```julia
mutable struct MPS{T<:Number, A<:AbstractArray{T,3}}
    tensors::Vector{A}        # Rank-3 tensors: (χ_left, d, χ_right)
    physical_dims::Vector{Int} # Local Hilbert space dimensions
    center_left::Int          # Left site of orthogonality center
    center_right::Int         # Right site of orthogonality center
end
```

**Key Features**:
- Type-stable two-field orthogonality center tracking
- Supports both CPU (`Array`) and GPU (`CuArray`) tensors
- Canonical form semantics:
  - `(0, 0)`: Not canonicalized
  - `(i, i)`: Single-site canonical at site i (for 1TDVP)
  - `(i, i+1)`: Two-site canonical spanning bond (for 2TDVP)

### 2. Generator Type

**File**: `src/ClosedSystem/generators.jl`

```julia
struct Generator{N,T}
    operators::NTuple{N,Matrix{T}}  # Generator matrices for each site
    sites::NTuple{N,Int}            # Site indices
end
```

A Generator represents the tensor-product decomposition of an N-qubit gate's Hamiltonian:
```
U = exp(-i * G₁ ⊗ G₂ ⊗ ... ⊗ Gₙ)
```

---

## Simulation Mechanism

### Gate Application Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    simulate(circuit, mps)                        │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │   For each gate in circuit:   │
              └───────────────────────────────┘
                              │
              ┌───────────────┴───────────────┐
              │                               │
              ▼                               ▼
    ┌─────────────────┐           ┌─────────────────────┐
    │ Single-qubit    │           │ Multi-qubit (N≥2)   │
    │ gate            │           │ gate                │
    └─────────────────┘           └─────────────────────┘
              │                               │
              ▼                               ▼
    ┌─────────────────┐           ┌─────────────────────┐
    │ Direct tensor   │           │ Local TDVP          │
    │ contraction     │           │ (windowed TDVP2)    │
    │ ein"adb,dc->acb"│           │                     │
    └─────────────────┘           └─────────────────────┘
```

### Single-Qubit Gate Application

**File**: `src/ClosedSystem/local_tdvp.jl:142-148`

```julia
function _apply_single_qubit_gate!(mps::MPS{T,A}, gate_mat::AbstractMatrix, site::Int) where {T,A}
    gate_converted = _convert_to_array_type(A, T, gate_mat)
    mps.tensors[site] = ein"adb,dc->acb"(mps.tensors[site], gate_converted)
    return mps
end
```

- **Complexity**: O(χ² × d²) - exact, no truncation needed
- **Method**: Direct tensor contraction using OMEinsum

### Multi-Qubit Gate Application (Local TDVP)

**File**: `src/ClosedSystem/local_tdvp.jl:183-228`

The Local TDVP algorithm for N-qubit gates:

```julia
function _apply_multi_qubit_gate!(mps::MPS{T,A}, gen::Generator{N}, params::LocalTDVPParams)
    # 1. Compute window boundaries
    start_site, end_site = _compute_window(gen, L, params.window_size)

    # 2. Canonicalize MPS at window start
    mixed_canonicalize!(mps, start_site)

    # 3. Convert generator to windowed MPO
    H_mpo = generator_to_mpo(gen, window_length, start_site)

    # 4. Apply TDVP2 evolution on window
    tdvp2_window!(mps, H_mpo, start_site, end_site; ...)

    # 5. Normalize if requested
    if params.normalize
        scale!(mps, 1/norm(mps))
    end
end
```

---

## TDVP Algorithm Details

### TDVP2 (Two-Site TDVP)

**File**: `src/Algorithms/tdvp.jl:296-325`

TDVP2 performs adaptive bond dimension evolution:

```julia
function tdvp2_step!(mps::MPS, H::MPO, dt::Number; max_bond_dim, cutoff, ...)
    # Initialize environments once
    envs = initialize_environments(H, mps)

    # Right sweep with dt/2
    _tdvp2_sweep_right_cached!(mps, H, envs, dt/2; ...)

    # Left sweep with dt/2
    _tdvp2_sweep_left_cached!(mps, H, envs, dt/2; ...)
end
```

### Right Sweep (Two-Site Evolution)

**File**: `src/Algorithms/tdvp.jl:330-384`

```julia
function _tdvp2_sweep_right_cached!(mps, H, envs, dt; ...)
    for j in 1:(L-1)
        # 1. Combine two adjacent tensors
        combined = ein"abc,cde->abde"(A1, A2)

        # 2. Build effective Hamiltonian
        H_eff = make_apply_H_eff_two_site(envs.left[j], envs.right[j+1], W1, W2)

        # 3. Time evolution via Lanczos
        new_vec = expmv(H_eff, combined_vec, -im * dt; ...)

        # 4. SVD and truncate
        U, S, Vt = svd(mat)
        n_keep = compute_n_keep(S, cutoff, CUTOFF_SUM2)
        n_keep = min(n_keep, max_bond_dim)

        # 5. Update tensors
        mps.tensors[j] = reshape(U_trunc, D_left, d1, n_keep)

        # 6. Update environment for next iteration
        envs.left[j+1] = _update_left_env(envs.left[j], mps.tensors[j], H.tensors[j])

        # 7. Backward single-site evolution (if not at boundary)
        if j < L - 1
            M_new_vec = expmv(H_eff_single, M_vec, +im * dt; ...)
        end
    end
end
```

### Lanczos-Based Matrix Exponential

**File**: `src/Algorithms/krylov.jl:89-115`

```julia
function expmv(A_mul_v::Function, v::AbstractVector, t::Number;
               tol=1e-12, maxiter=25)
    # 1. Build Krylov basis via Lanczos iteration
    V, α, β = lanczos(A_mul_v, v_unit, maxiter; tol=tol)

    # 2. Eigendecomposition of tridiagonal matrix
    T_mat = SymTridiagonal(α, β)
    λ, U = eigen(T_mat)

    # 3. Compute exp(t*T) * e1
    coeffs = exp.(t .* λ) .* U[1, :]
    y = U * coeffs

    # 4. Transform back to original space
    result = V * y * v_norm
end
```

---

## Truncation Strategy

**File**: `src/Core/canonical/truncation.jl`

OMQuTensor uses **discarded weight truncation** (CUTOFF_SUM2), matching YAQS:

```julia
# Keep singular values while Σ(discarded s²) ≤ cutoff
n_keep = compute_n_keep(S, cutoff, CUTOFF_SUM2)
n_keep = min(n_keep, max_bond_dim)
```

**Default Parameters** (from `src/Parameters/params.jl`):
- `max_bond_dim = 64`
- `cutoff = 1e-9`
- `lanczos_iters = 25`
- `lanczos_tol = 1e-12`

---

## Comparison with OMQuTensor_quimb (Python)

| Feature | OMQuTensor.jl (Julia) | OMQuTensor_quimb (Python) |
|---------|----------------------|---------------------------|
| Gate Application | Local TDVP | TEBD-style `gate_split_()` |
| Multi-qubit Gates | Generator → MPO → TDVP2 | Direct SVD truncation |
| Truncation | CUTOFF_SUM2 (discarded weight) | cutoff + max_bond |
| Time Evolution | Lanczos expmv | Direct gate application |
| Complexity per 2-qubit gate | O(χ³ × d² × k) | O(χ³ × d²) |

Where:
- χ = bond dimension
- d = physical dimension (2 for qubits)
- k = Lanczos iterations (default 25)

---

## Why Simulations in the Example Folder Are Slow

### Root Cause Analysis

The simulations in `example/ground_xerror_reset.jl` and `example/lattice_circuit_correction_X.jl` are slow due to several compounding factors:

### 1. **Local TDVP vs TEBD: Algorithmic Complexity**

**TEBD (quimb)**: Direct gate application with SVD
```python
# quimb's gate_split_() - O(χ³ × d²)
def gate_split_(self, G, where, ...):
    # Contract gate with two tensors
    # Single SVD decomposition
    # Truncate and update
```

**Local TDVP (OMQuTensor.jl)**: Variational time evolution
```julia
# Local TDVP - O(χ³ × d² × k × sweeps)
function tdvp2_window!(mps, H_mpo, start, end; lanczos_iters=25, ...)
    # Right sweep: L-1 two-site evolutions
    # Left sweep: L-1 two-site evolutions
    # Each evolution: k Lanczos iterations
```

**Code Proof** (`src/Algorithms/tdvp.jl:560-594`):
```julia
function tdvp2_window!(mps, H_window, start_site, end_site; ...)
    half_dt = 0.5

    # Right sweep - (window_length - 1) iterations
    _tdvp2_window_sweep_right!(mps, H_window, envs, start_site, end_site, half_dt; ...)

    # Rebuild right environments
    for i in (window_length-1):-1:1
        envs.right[i] = _update_right_env(...)  # Additional O(χ³) operations
    end

    # Left sweep - (window_length - 1) iterations
    _tdvp2_window_sweep_left!(mps, H_window, envs, start_site, end_site, half_dt; ...)
end
```

### 2. **Lanczos Iterations Per Gate**

Each two-site evolution requires Lanczos iterations:

**Code Proof** (`src/Algorithms/tdvp.jl:617-619`):
```julia
# Two-site evolution via Lanczos
new_vec = expmv(x -> vec(H_eff(reshape(x, size(combined)))), combined_vec, -im * dt;
                tol=lanczos_tol, maxiter=lanczos_iters)  # Default: 25 iterations
```

**Cost per Lanczos iteration** (`src/Algorithms/krylov.jl:37-56`):
```julia
for j in 2:k
    # Matrix-vector product: O(χ⁴ × d⁴) for two-site effective Hamiltonian
    w = A_mul_v(V[:, j])

    # Reorthogonalization: O(n × k) where n = χ² × d²
    for i in 1:j
        w = w - dot(V[:, i], w) * V[:, i]
    end
end
```

### 3. **Three-Qubit Gates (CCX, OR) Decomposition**

The examples use CCX (Toffoli) and OR gates extensively:

**Code Proof** (`src/ClosedSystem/local_tdvp.jl:417-437`):
```julia
function apply_or_gate!(mps::MPS, sites::NTuple{3,Int}, params::LocalTDVPParams)
    c1, c2, t = sites

    # Apply CNOT(c1, t) - Full Local TDVP
    mps, info1 = apply_gate!(mps, CNOT, (c1, t), params)

    # Apply CNOT(c2, t) - Full Local TDVP
    mps, info2 = apply_gate!(mps, CNOT, (c2, t), params)

    # Apply CCX(c1, c2, t) - Full Local TDVP for 3-qubit gate
    mps, info3 = apply_gate!(mps, CCX, (c1, c2, t), params)
end
```

**OR gate = 3 × Local TDVP operations!**

### 4. **Circuit Complexity in Examples**

**From `example/ground_xerror_reset.jl:83-137`**:
```julia
qc = QuantumCircuit(n_qubits)  # 32 qubits

# Layer 1: 32 Hadamard gates (fast - single qubit)
for i in 1:n_qubits
    add_gate!(qc, H, i)
end

# Layer 2: 16 OR gates (SLOW - each OR = 3 Local TDVP operations)
for site in o_sites  # 16 data sites
    add_gate!(qc, OR, z_anc1, z_anc2, data_idx)
end

# Layer 3: 16 CCX gates (SLOW - 3-qubit Local TDVP)
for site in o_sites
    add_gate!(qc, CCX, z_anc1, z_anc2, data_idx)
end

# Layer 4: 32 Hadamard gates (fast)
# Layer 5: 16 CCX gates (SLOW)
```

**Total expensive operations per circuit**:
- 16 OR gates × 3 TDVP = 48 Local TDVP operations
- 32 CCX gates × 1 TDVP = 32 Local TDVP operations
- **Total: 80 Local TDVP operations**

### 5. **Environment Computation Overhead**

Each Local TDVP window requires environment initialization:

**Code Proof** (`src/Algorithms/tdvp.jl:493-531`):
```julia
function _initialize_window_environments(mps, H_window, start_site, end_site)
    # Build right environments from right to left within window
    for i in (window_length-1):-1:1
        # O(χ³ × d²) tensor contraction per site
        right[i] = _update_right_env(right[rel_site], mps.tensors[abs_site], H_window.tensors[rel_site])
    end
end
```

### 6. **Canonicalization Before Each Gate**

**Code Proof** (`src/ClosedSystem/local_tdvp.jl:196`):
```julia
# Put MPS in mixed canonical form centered at start of window
mixed_canonicalize!(mps, start_site)
```

This requires O(L × χ³) operations to sweep through the MPS.

---

## Quantitative Performance Analysis

### Per-Gate Cost Comparison

| Operation | TEBD (quimb) | Local TDVP (OMQuTensor.jl) |
|-----------|--------------|---------------------------|
| Single-qubit | O(χ² × d²) | O(χ² × d²) |
| Two-qubit | O(χ³ × d²) | O(χ³ × d² × k × 2) |
| Three-qubit (CCX) | O(χ³ × d³) | O(χ³ × d² × k × 2 × window) |

Where:
- k = Lanczos iterations (25)
- window = window_size × 2 + gate_sites (typically 4-5 sites)
- Factor of 2 = right sweep + left sweep

### Estimated Slowdown Factor

For a typical two-qubit gate:
```
Slowdown ≈ (2 sweeps) × (k iterations) × (environment overhead)
         ≈ 2 × 25 × 1.5
         ≈ 75x slower than TEBD
```

For the example circuit (80 expensive operations on 32 qubits):
```
Expected time ≈ 80 × (TDVP cost per gate) × (bond dimension scaling)
```

---

## Recommendations for Faster Simulation

### 1. **Reduce Lanczos Iterations**
```julia
params = LocalTDVPParams(
    lanczos_iters = 15,  # Reduced from 25
    lanczos_tol = 1e-8   # Relaxed tolerance
)
```

### 2. **Use Smaller Bond Dimension**
```julia
params = LocalTDVPParams(
    max_bond_dim = 32,   # Reduced from 64-200
    cutoff = 1e-8        # Relaxed cutoff
)
```

### 3. **Consider Alternative Implementations**
- For circuits dominated by Clifford gates: Use stabilizer simulation
- For shallow circuits: Use state vector simulation
- For TEBD-style evolution: Use quimb's CircuitMPS

### 4. **GPU Acceleration**
The package supports GPU via CUDA.jl, but the overhead of Local TDVP may limit speedup:
```julia
using CUDA
psi_gpu = to_gpu(psi)
```

---

## Summary

OMQuTensor.jl uses **Local TDVP** for multi-qubit gate application, which is mathematically rigorous but computationally expensive compared to TEBD-style direct gate application. The key performance bottlenecks are:

1. **Lanczos iterations** (25 per two-site evolution)
2. **Double sweep** (right + left) per gate
3. **Environment recomputation** for each window
4. **Three-qubit gate decomposition** (OR = 3 operations)

For the Toric Code error correction examples, these factors compound to make simulation significantly slower than equivalent quimb implementations.
