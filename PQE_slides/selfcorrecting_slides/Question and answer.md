
Q&A
1.	"Have you calculated the fault-tolerance threshold for the proposed measurement-free error correction scheme?"
2.	"What motivated the chosen MPS geometry? Why was it preferred over a snake-like arrangement? Why not using PEPS for calculation?"
3.	"When performing SVD truncation, have you quantified the truncation error introduced into the simulation?"

**Answer:** In our TEBD simulations using quimb, there are two main sources of error: Trotter error (from time discretization) and SVD truncation error. Quimb's `_err` attribute only tracks Trotter error, not SVD truncation error explicitly.

For truncation, we use the default `'rsum2'` mode (cutoff_mode=4), which controls the relative sum of squared discarded singular values:

```
Truncation Criterion: Σ(s_discarded²) / Σ(s_all²) < cutoff
Relative Error: ε_rel ≈ √cutoff
```

With our cutoff setting of 1e-10, this bounds the relative truncation error to approximately √(1e-10) ≈ 3.16×10⁻⁶ per truncation step.

To quantify truncation error, we monitor:
1. **Bond dimension evolution** - tracking `tebd.pt.max_bond()` as a proxy for truncation effects
2. **State normalization** - using `renorm=True` to preserve norm after truncation
3. **Fidelity-based estimation** - comparing with higher bond dimension simulations when feasible

The truncation error can be calculated manually from singular values as:
```python
error = np.sqrt(np.sum(s_discarded**2)) / np.sqrt(np.sum(s_full**2))
```

We use conservative settings (`cutoff=1e-10`, `max_bond=256`) to balance accuracy against computational cost while keeping truncation error well-controlled.

