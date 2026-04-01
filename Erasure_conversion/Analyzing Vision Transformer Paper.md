# **Erasure Conversion in Metastable Neutral Atom Qubits: A Pathway to High-Threshold Fault Tolerance**

## **Executive Summary**

The pursuit of Fault-Tolerant Quantum Computing (FTQC) is currently defined by a race to reduce physical error rates below the thresholds required for effective Quantum Error Correction (QEC). While the surface code has emerged as the leading architecture due to its high threshold and local geometric constraints, its standard implementation assumes a depolarizing noise model where errors are Pauli errors occurring at unknown locations. Under such models, the fault tolerance threshold typically hovers around 1%.

This report provides an exhaustive analysis of the research presented in arXiv:2201.03540, "Erasure conversion for fault-tolerant quantum computing in alkaline earth Rydberg atom arrays" (published as *Nature Communications* 13, 4657, 2022). The authors, led by the research group at Princeton University (J.D. Thompson et al.), propose a paradigm-shifting protocol for neutral atom quantum computing. By encoding qubits in the metastable electronic levels of alkaline-earth-like atoms (specifically Ytterbium-171), the dominant physical errors—such as spontaneous emission—can be converted into "erasure" errors: errors where the location is known, even if the Pauli nature is not.

The implications of this method are profound. The research demonstrates via circuit-level simulations that converting 98% of errors into erasures increases the fault tolerance threshold of the surface code from 0.937% to 4.15%.1 This four-fold increase brings fault tolerance within the reach of near-term experimental gate fidelities, potentially accelerating the timeline for scalable quantum processors. This report dissects the methodology, the underlying atomic physics, the error correction mechanics, and the strategic implications of this work for the broader quantum computing landscape.

## ---

**1\. Introduction: The Fault Tolerance Bottleneck**

### **1.1 The Challenge of Quantum Noise**

Quantum computers differ fundamentally from classical computers in their susceptibility to noise. In classical digital logic, a voltage threshold separates 0 from 1, providing inherent robustness against minor fluctuations. In quantum systems, information is encoded in continuous complex amplitudes, making qubits vulnerable to interaction with the environment (decoherence) and imperfect control operations (gate errors).

To perform long algorithms, quantum processors must employ Quantum Error Correction (QEC). QEC spreads logical quantum information across many entangled physical qubits. By measuring parity checks (syndromes), the system can detect and correct errors without collapsing the logical state. However, QEC only works if the physical error rate is below a specific value known as the **threshold**. If the physical error rate exceeds this threshold, adding more qubits increases the logical error rate rather than decreasing it.

### **1.2 The Dominance of the Surface Code**

Among QEC codes, the **surface code** (and its variant, the rotated planar code) is widely considered the most promising candidate for implementation. Its popularity stems from two key factors:

1. **High Threshold:** It can tolerate error rates up to ![][image1] under standard depolarizing noise models, which is significantly higher than older concatenated codes.  
2. **Locality:** It requires only nearest-neighbor interactions on a 2D grid, matching the geometric constraints of superconducting circuits and neutral atom arrays.

Despite these advantages, the ![][image1] threshold remains a daunting target for two-qubit gate fidelities in many platforms. Furthermore, operating "just below" the threshold is insufficient; to achieve arbitrarily low logical error rates with reasonable resource overheads, physical error rates must be significantly below the threshold (e.g., ![][image2] or lower).

### **1.3 The Limitation of Pauli Error Models**

Standard threshold calculations assume a "Pauli noise" model, where errors are random bit-flips (![][image3]), phase-flips (![][image4]), or combined flips (![][image5]) occurring at unknown locations in the lattice. The decoder (the classical algorithm interpreting syndromes) must deduce *which* qubits failed. This ambiguity is the primary limiter of the threshold. If the decoder knows *exactly* which qubit has failed (an "erasure" error), the correction becomes fundamentally easier.

The research analyzed in this report (arXiv:2201.03540) addresses this specific bottleneck. It proposes a physical encoding scheme where the dominant errors naturally manifest as erasures, thereby fundamentally altering the landscape of error correction for neutral atom platforms.1

## ---

**2\. Methodology: Metastable Qubit Encoding**

The core innovation of the work lies in the choice of the physical qubit encoding. In most neutral atom experiments, qubits are encoded in the ground state hyperfine levels of alkali atoms (like Rubidium or Cesium). The authors propose moving to alkaline-earth-like atoms (specifically Ytterbium-171) and encoding the qubit in a **metastable optical state**.

### **2.1 The Physics of Alkaline-Earth Atoms**

Alkaline-earth atoms (Group 2\) and atoms with similar electronic structures (like Ytterbium) possess two valence electrons. This structure gives rise to two separate spin manifolds:

* **Singlet states (![][image6]):** The ground state is typically a singlet (![][image7]).  
* **Triplet states (![][image8]):** Excited states where the electron spins are parallel.

Transitions between singlet and triplet states are "intercombination lines" and are forbidden by electric dipole selection rules. This results in extremely long lifetimes for the lowest triplet states, making them "metastable."

### **2.2 The Proposed Encoding: The Clock Transition**

The authors define the qubit using the nuclear spin levels within the metastable ![][image9] orbital of ![][image10].

* **The Manifold:** The ![][image9] state is extremely long-lived (lifetime ![][image11] seconds), effectively stable for the duration of quantum computations.  
* **The Qubit:** The qubit is encoded in the nuclear spin projection states ![][image12] within this metastable manifold.

This approach contrasts with standard "ground state" qubits. In ground state qubits, the dominant error source during Rydberg gates (the mechanism for entanglement) often leads to leakage out of the computational subspace or phase errors that are indistinguishable from valid states.

### **2.3 Mechanism of Erasure Conversion**

The genius of the metastable encoding lies in how errors manifest. The primary source of error in neutral atom gates typically involves decay from the highly excited Rydberg state used to mediate interactions.

#### **2.3.1 Rydberg State Decay**

To perform a two-qubit gate, atoms are temporarily excited from the qubit manifold (![][image9]) to a high-lying Rydberg state (![][image13]).

* **The Error:** The Rydberg state has a finite lifetime and can spontaneously decay.  
* **The Destination:** When a Rydberg atom decays, it does not simply scramble the qubit phase. Due to selection rules and branching ratios, the decay predominantly results in a transition to the **ground state** (![][image7]).

#### **2.3.2 Disjoint Subspaces**

This decay to the ground state (![][image7]) is the key. The qubit is encoded in the metastable state (![][image9]). The ground state is physically distinct and separated by an optical frequency gap (the "clock transition").

* **Computational Subspace:** ![][image9] (Metastable).  
* **Error Subspace:** ![][image7] (Ground).

Because these two subspaces are disjoint and coupled only by specific optical frequencies, an atom falling into the ground state effectively "disappears" from the perspective of the control lasers acting on the qubit.

### **2.4 Monitoring via Fluorescence**

Crucially, the population in the ground state can be detected without disturbing the qubit state in the metastable manifold.

* **The Probe:** The authors propose using a "cycling transition" connected to the ground state (e.g., ![][image14]) to induce fluorescence.  
* **Selective Measurement:** Because the probe laser is off-resonant from the metastable state (![][image9]), it does not interact with valid qubits. It only scatters photons if the atom has decayed to the ground state.  
* **Real-Time Detection:** By collecting this fluorescence on a camera or photodetector during the computation, the control system can identify *exactly* which atom has suffered a decay error.

This process converts the error from a "Pauli error at unknown location" to an "Erasure error at known location".2 The snippet 1 estimates that **98% of errors** can be converted into erasures using this protocol.

## ---

**3\. Theoretical Advantages of Erasure Noise**

To understand why converting errors to erasures is valuable, we must examine the decoding properties of the surface code.

### **3.1 Decoding Pauli Errors vs. Erasures**

In the standard surface code with code distance ![][image15]:

* **Pauli Errors:** The code can correct up to ![][image16] errors. If errors occur at unknown locations, the decoder must solve a matching problem (typically Minimum Weight Perfect Matching) to find the most likely error chain consistent with the syndromes. The ambiguity of error location reduces the effective distance.  
* **Erasure Errors:** If the locations of errors are known (erasures), the code can correct up to ![][image17] erasures. The decoder effectively "removes" the erased qubits from the lattice and renormalizes the stabilizer checks. Because the location is known, there is no ambiguity about *which* qubit failed, only *how* it affects the parity.

### **3.2 Threshold Implications**

This theoretical difference manifests as a dramatic increase in the fault tolerance threshold.

* **Standard Threshold:** For depolarizing noise, the surface code threshold is ![][image18].  
* **Erasure Threshold:** For pure erasure noise, the threshold can be as high as ![][image19] (in ideal cases for some codes), though for the surface code under realistic circuit assumptions, it is significantly higher than the Pauli threshold.

The authors' simulations, which account for the specific circuit-level details of the neutral atom platform (including the 2% of errors that *cannot* be converted to erasures), yield a new threshold of **4.15%**. This is a **4.4-fold increase** over the standard baseline.1

## ---

**4\. Performance Analysis and Simulation Results**

The report relies on circuit-level simulations to quantify the benefits of the proposed scheme. These simulations differ from abstract phenomenological models by incorporating the specific gate sequences, noise biases, and detector capabilities of the hardware.

### **4.1 Threshold Improvement**

The primary metric of success is the increase in the threshold.

| Error Model | Threshold (pth​) |
| :---- | :---- |
| Standard Depolarizing | 0.937% |
| **Erasure Conversion (Proposed)** | **4.15%** |

This improvement is critical because current experimental gate fidelities for neutral atoms are often in the range of 99% to 99.5% (i.e., error rates of 0.5% to 1.0%).

* Under the standard model (0.937% threshold), a gate fidelity of 99.5% is barely above the threshold, meaning error correction would yield little to no benefit.  
* Under the erasure model (4.15% threshold), a gate fidelity of 99.5% is deep within the distinctive "below-threshold" regime, allowing for exponential suppression of logical errors as the code distance increases.

### **4.2 Logical Error Rate Scaling**

The snippet 1 notes that the authors observe a "larger code distance near the threshold." In QEC, the effective distance determines the slope of the logical error rate curve (![][image20]). By converting errors to erasures, the system preserves the code distance more effectively. For the same number of physical qubits, the erasure-converted code achieves a lower logical error rate than a standard code would, even if the physical error rates were identical. This "steeper scaling" is vital for near-term implementations where qubit counts are limited 3, as it allows meaningful logical protection without requiring massive lattice sizes.

### **4.3 Overhead Reduction for Magic States**

Beyond the surface code memory, the authors highlight implications for **magic state distillation**. Universal quantum computing requires non-Clifford states ("magic states") which are typically noisy and must be purified.

* **Standard Scaling:** The error rate of distilled states scales as ![][image21].  
* **Erasure Scaling:** With erasure conversion, detecting an erasure allows the protocol to reject the faulty state immediately rather than attempting to purify it. This changes the scaling to ![][image22], where ![][image23] is the erasure conversion fraction.  
* **Result:** With 98% erasure conversion, the authors predict over an **order of magnitude reduction in the infidelity of raw magic states**, leading to a large reduction in the hardware overhead required for distillation.1

## ---

**5\. Strategic Implications for Quantum Hardware**

### **5.1 Neutral Atoms vs. Other Platforms**

The erasure conversion protocol is uniquely suited to **neutral atom** and **trapped ion** platforms, where qubits are defined in atomic levels that have well-defined selection rules.

* **Superconducting Circuits:** While "leakage" to non-computational states exists in superconducting transmons, detecting it usually requires complex readout circuitry that may disturb the system. Furthermore, the noise in solid-state systems is often dominated by ![][image24] and ![][image25] processes that do not manifest as erasures.  
* **Neutral Atoms Advantage:** The "metastable vs. ground" separation is a natural physical property of alkaline-earth atoms. The ability to check for errors using light (fluorescence) without decohering the qubit (which is dark to that light) is a distinct advantage of atomic physics.

### **5.2 Enabling Near-Term Fault Tolerance**

The abstract mentions that this approach brings the threshold "within the range of current experimental gate fidelities".1 This is a crucial observation. It implies that the hardware does not need to improve by another order of magnitude before QEC becomes viable. Instead, by changing the *encoding* and the *control software* (to handle erasures), existing or near-term hardware can demonstrate fault tolerance.

### **5.3 Hardware Requirements**

Implementing this protocol requires specific hardware capabilities:

1. **Yb-171 or Sr-87 Arrays:** The experiment requires alkaline-earth(-like) atoms. This is a shift from the Rubidium/Cesium dominance of early atom arrays, though groups like Atom Computing and various academic labs are already working with these species.2  
2. **Dual-Wavelength Control:** The system needs lasers to trap and manipulate the metastable state (![][image9]) and separate lasers to probe the ground state (![][image7]).  
3. **Fast Imaging:** To utilize the erasure information, the system requires high-speed low-latency imaging to detect fluorescence and feed that information to the decoder in real-time.

## ---

**6\. Broader Context: The "Erasure" Trend in QEC**

The work in 2201.03540 is part of a broader emerging trend in Quantum Error Correction: **Bias-Tailored QEC**.

* **Biased Noise:** In superconducting cat-codes 1, noise is biased towards phase flips (![][image4] errors). Codes are designed to handle this asymmetry.  
* **Erasure Noise:** This is the extreme limit of biased noise, where the bias is towards a "known location" error.

The paper argues that "Erasure conversion should benefit any error correcting code".1 While the authors demonstrate it on the surface code, the principle applies to Low-Density Parity-Check (LDPC) codes and color codes. This universality suggests that "erasure engineering"—designing physical qubits specifically to facilitate error detection—may become a standard design principle for future quantum processors.

## ---

**7\. Deep Dive: The Mechanism of Threshold Increase**

To fully appreciate the 4.15% threshold, one must understand the statistical mechanics of the surface code decoding graph.

### **7.1 The Matching Graph**

In the surface code, errors create "defects" (unexpected syndrome values) at the endpoints of error chains. The decoder's job is to pair these defects up to minimize the total weight of the correction chain.

* **Random Noise:** The graph is weighted uniformly. A chain of errors can be confused easily with a logical operator if the error density is high.  
* **Erasure Information:** When an erasure is detected, the decoder essentially assigns a **zero weight** (or very low cost) to the edges corresponding to the erased qubit in the matching graph. It knows an error *likely* occurred there.  
* **Percolation Theory:** The threshold of the surface code is related to the bond percolation threshold of the lattice. For random bond removal (erasures), the lattice remains connected (logical information preserved) up to 50% loss. For random bond flipping (Pauli errors), the threshold is much lower (\~10.9% for hashing, \~1% for practical matching).

The 4.15% figure derived by the authors accounts for the reality that not all errors are erasures. 2% of errors remain as standard Pauli errors. The threshold is thus a weighted average of the high erasure threshold and the low Pauli threshold.

### **7.2 The Role of Leakage**

Standard QEC codes often fail in the presence of leakage (qubits leaving the computational subspace). Leakage acts as a "permanent" error that spreads over time.

The proposed protocol turns leakage into a feature. By "leaking" to the ground state, the atom signals its failure. The system can then reset that atom (using optical pumping) and re-initialize it, or simply treat it as an erasure for the remainder of the cycle. This transforms a dangerous, spreading leakage error into a contained, correctable erasure.

## ---

**8\. Conclusion**

The research paper "Erasure conversion for fault-tolerant quantum computing in alkaline earth Rydberg atom arrays" (arXiv:2201.03540) represents a pivotal contribution to the field of quantum computing. By leveraging the specific atomic physics of Ytterbium-171, the authors propose a method to convert the vast majority (98%) of quantum errors into erasures.

**Key Findings:**

1. **Encoding:** Using metastable states allows for non-destructive error monitoring via fluorescence from the ground state.  
2. **Threshold:** This conversion raises the surface code threshold from \~0.9% to \~4.1%, a transformative increase that aligns QEC requirements with current experimental capabilities.  
3. **Scalability:** The method improves the scaling of logical error rates and drastically reduces overheads for magic state distillation.

This work suggests that the path to Fault-Tolerant Quantum Computing may not require waiting for gate fidelities to reach 99.99%. Instead, by cleverly engineering the physics of the qubit to expose its errors, we can achieve fault tolerance with the noisy, intermediate-scale devices (NISQ) emerging today. It redefines the hardware-software co-design interface, advocating for physical layers that don't just minimize errors, but *flag* them for the correction layer.

## ---

**9\. Future Outlook and Recommendations**

Based on the insights from this report, the following developments can be anticipated in the field:

* **Adoption of Yb/Sr:** We expect a strategic pivot in the neutral atom community towards alkaline-earth species (![][image10], ![][image26]) to leverage this erasure conversion capability.  
* **New Decoder Architectures:** Classical control stacks will need to evolve to handle real-time "soft information" (erasure flags) from the fluorescence detectors, requiring tight integration between image processing and syndrome decoding.  
* **Hybrid Codes:** Future research may explore codes specifically optimized for mixed erasure/Pauli noise, potentially yielding even higher thresholds than the surface code.

The "Erasure Conversion" protocol stands as a prime example of how deep physical insights can solve algorithmic bottlenecks, offering a tangible pathway to the era of large-scale, error-corrected quantum computation.

---

**References used in analysis:**

* 1 arXiv:2201.03540 "Erasure conversion for fault-tolerant quantum computing in alkaline earth Rydberg atom arrays".  
* 3 Contextual information on neutral atom array scaling (Atom Computing).  
* 5 Excluded (Irrelevant subject matter).

#### **Works cited**

1. arXiv:2201.03540v1 \[quant-ph\] 10 Jan 2022, accessed on February 7, 2026, [https://arxiv.org/pdf/2201.03540](https://arxiv.org/pdf/2201.03540)  
2. Erasure conversion for fault-tolerant quantum computing in alkaline earth Rydberg atom arrays \- PubMed, accessed on February 7, 2026, [https://pubmed.ncbi.nlm.nih.gov/35945218/](https://pubmed.ncbi.nlm.nih.gov/35945218/)  
3. Logical computation demonstrated with a neutral atom quantum processor \- arXiv, accessed on February 7, 2026, [https://arxiv.org/html/2411.11822v1](https://arxiv.org/html/2411.11822v1)  
4. \[2201.03540\] Erasure conversion for fault-tolerant quantum computing in alkaline earth Rydberg atom arrays \- arXiv, accessed on February 7, 2026, [https://arxiv.org/abs/2201.03540](https://arxiv.org/abs/2201.03540)  
5. \[2201.03545\] A ConvNet for the 2020s \- ar5iv \- arXiv, accessed on February 7, 2026, [https://ar5iv.labs.arxiv.org/html/2201.03545](https://ar5iv.labs.arxiv.org/html/2201.03545)

[image1]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAXCAYAAAB0zH1SAAABY0lEQVR4Xu2UMShFURjHPwNlUbIpshODUsoimRjtRpl5xWCnjCKb3SDZTETZlEgWFgMmmWTB93XPfe9//vd27n3Fecr91b9zvv/3nc7/vjpPpOJ/0slGDt1stJov1Y1bB/yWxwcbMThhw7HulGLhTduqHtUIeNGYUW1J+GLze6G+c+uUak+1qlpSXaQDMXmVcHBkjWrjjI1YFAXvgvoU9sYl1VEJBd9QHUONc/ZgF6COTii4Yb1pSeYmwX+DfRB7AOlDMrX5bY9QEKYoeB6fsLcc56oXVTv4dR5gPybJZf3gIddsBGg2+K7qAGo7W1N1uL3HPhvSCM/cqibYDNBscJ7F2v4aPXgYeZek/+zWWb9dSDPBn6helOxZ+0HrLGORw7DqUDXOjRKUDT6neiRvR7Jn56n+NcoGv2dDGZXs2dwH+pPYhXkawiHHERsABr+CfcvZVK2wCfRJ46MHqVdRUfHX+AYXJ18gfLGWqgAAAABJRU5ErkJggg==>

[image2]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACkAAAAXCAYAAACWEGYrAAABx0lEQVR4Xu2VzysFURTHD0mUDTbETuIPUORnWdhRNkoWsmFLWZAsZKks2JCVbGwUXiSRhQVrZaEU5S+QDUWcM/fe9858Z+68eQtFzae+Ned7zrtz5s55d4gy/icVaPw1+lkvrAdWJ+Q0H2ggG6xv1hMmUjLLOkKTGSazrkOuRXusJlYb6856A6oughQ82+sqG9fls356WatUuHEunA74pHCT+2R2s4u1wlpmNbIeVU2EeYpu8zaFFy7GEvmbdA/gGGFtqlgoei8pOAav2/ppKaVJGatxFR+y1lUciywgr0xTY/0+8H0kNRk3k5o1iCNUk/nRAvhl1p8C30dSk8I9a5I1yJpR/qu69tJKZvE5TJDxt9D04Jo8wUQCb6wOFZ+RWUPeYohmm5A/DyI+DrgP1+QpJhKQY8cxTWZWBRwHqrTmIvjl1pfjIQ2uSdmNNFxDrBubYO2qOEAKdsBrsX4D+D5ck+eYiOGGTL1jiKK7h3Fg3II3av20uCYvMBHDO8QyangvjPNfGI3EaTyHa/IKEwB+NIR6iq6LccAXFZ6wnUxRbSEdENek8+KEyHxfomnR9fI2xlQcQc7H3+IADcA9XA8mMjIySuQHnaaAj3S3dGQAAAAASUVORK5CYII=>

[image3]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAAXCAYAAAAGAx/kAAAAnUlEQVR4XmNgGAXkgP9YsCBUbg8WOYIAl0KQ2FJ0QXwAm0HWQJyPJkYQVDJADNoH5V8F4k0IadIAzFVzgFgGTY4kUM8AMegnugSpQJ8Be1iRBIQZSIxmbIARiG9D2e4MEIPuI6SJAwkMmGHymwFimCSaOF6AzRswVz1AE0cBLEAcDsSfGCCKFzJAvAYD3EBcDpUDYU8gVkaSHwWjAACDvS2iUOTV7wAAAABJRU5ErkJggg==>

[image4]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAYCAYAAAAlBadpAAAAkElEQVR4XmNgGAUg0A7E/wngeXDVaACmYB8Qm+KQwwlAknzogkDwhwEix44ugQwWowsAwUsGiEYFNHEUEIQuAASrGCAa09ElCIEcBojGZegShMArBojG5+gShAAHA0QjKJBIAnkMuJ36Al0AHeCLS390ARgg5FRcBoIBPhsfMeCWY/jCgNCMC5+Eqx4FQw0AAPwjMuvqM6TXAAAAAElFTkSuQmCC>

[image5]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAXCAYAAAAC9s/ZAAAAgklEQVR4XmNgGAUgEAjE/7FgdEBInmESA0RiD7oEFAgy4NCIDHCazgARV0EXRAfnGCAKi9HE36Hx8QJ0V4DYwkh8ggDZgGggdkBIEQc+M0AMANEr0OSIAp4MEAPuoUsQC9Yz4I4JogB6IJIMyDbAEIhzGSCa/wCxARCzoqgYBcMVAADXACbJkO6H2wAAAABJRU5ErkJggg==>

[image6]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAYCAYAAAC8/X7cAAABaklEQVR4Xu2UPS9EQRSGXx/RKLbRqaipRSQKGh2NQsUPEHoSBdlGRCLED6CU0NFJFCqdQqVCRBQkggiCc5y5u3Pfe3dDM9PMk7zJvc85k5m5OztAIpEoo0vyLXmTvLtn5aXWEZ4+yZyklQvMOGzBLZ5rcy7bSGgOJHeSKdgarvLlPNrQzhLmH1kG4BnFD6cb2CT3yxCKzRk3knmWAdD1XJAbdb7ADqwwzQVhhkUgdD3b5LIjPUAeE66gOUFJQwR0LSssYX6WpfKB+iayvOY6GnOL4thm+bJhDemG9S1wAeb1xJTSITlDfrIY9MLmXuQCzB+yLKMKa+7hQgCys77MBZjf8sWD/+LRiXi/gKJzb7CE+UlfXPsvHmv4+waWJEf/yK4Na4rOfU5u2PkaYyw81J+yDEjZf3BPcu8LvXkGYY165kck6+693+uLxSfqN5F+TN4QLr1nvZqeJPuSiudjcwzbyCoXEolEIh4/gRJtPis9Z5wAAAAASUVORK5CYII=>

[image7]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABsAAAAYCAYAAAALQIb7AAABLElEQVR4XmNgGEBggi5AC/AHiCcB8X90CVoBPYZBalk3A0TtOSD+DsTvoeLE6ifasjdA/BuIWZDEmhggercjieEFxFhmw4BbDUicFV0QFyDGsp9AvAZdEAquoQvgA8RYBpIHYUZ0CSCIQhfABaoZIJENMggU/kGo0nDwjwFh4UkgZkOVpj6AWYaMnVBUUBmYA/EhBlQL0UEcAwkJhliQxwCxzADKFwdiHygbFB0voGySgCK6ABQwMUAsY4by7yDJgQA2X+MFE4FYDF0QCkqB+BsSH91wdD5BAEqFK9AFoQBkGHLcoBuOzicIQBr2Q+lUINYC4kYo3xpJHQigG47Oxwv0gdgWyhYF4iMMEAN2wlWgAnTD0flUBYvR+DS1DATOQumLQNyFLDEKhhYAAG76SXx5MTG1AAAAAElFTkSuQmCC>

[image8]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAYCAYAAAC8/X7cAAABMUlEQVR4XmNgGAWjYBRgAyJA/B+IfwDxLygbBL7CVQwcEEAXQAf+DBAHMyKJMUPFYB4ZCJDJALHfFV0CHYAUsaALMkDE36ML0gHsAuIJUDbIDS5IchjAmgF3KD8B4nx0QToDgh5YxABRFI8uAQQJ6AIDAAh6IIABkdYPArE5qvSAA4IeAIHfDAhPwPA3FBW4wTMGTL348D+INqIBSA/BTAwCbEB8mgHVssEAQO5wRxckBFoZIBoV0SUGAIDc4YkuCAPv0AWggJthcMWAN7ogDDxGF4CCHgbiPVAHxNtJwIsh2ogGIHf4oguCgAcDbkeCxI+iCw4QALkF1FLAAKCSx5IBogCU5p2AuA/K10VSNxDgOgNqYYKM4eAOEhtUmX0C4nVAzI8kPgpGwSgYBaMAAwAA0E5akUpVOBwAAAAASUVORK5CYII=>

[image9]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAYCAYAAADpnJ2CAAABIklEQVR4Xu2UsWoCQRRFH0gqsbIN2Asp0lmm19T6AX6C2PsRSQrb/ICdhNQGkkAaGyuxsZYUYmUyj5lh71zYGTZmTJMDF/a9+2avuzOryB9ya3TDzVx80XUf6ixw4AfU2cFwZiTWL9O6GE2zkXgY4gNq0OsYHVy/Af0kuuCJm4TOzLjp8D8mSguuUwsGYv1rNhyp9TKRcCC1IOZ3xXorNhgOrEPNxAKPUu79GB/YdtLDMnW9V5j7NfTGO6MXo4XRs9F9MGG5ErvfJ/EgNrDJBsFbdAF1JWL757mUcObNaA51JfRG79wklhIG+v2tzFDswh4bxKeEAXdUJ9lK8SpRZeg3iL4eqNj8yehfHgY8Up0FDNgbjaHOgh4s/ylkf7p/zss3lxhbloToRGkAAAAASUVORK5CYII=>

[image10]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC8AAAAXCAYAAACbDhZsAAABUklEQVR4Xu2Uu0oEQRBFL5gZirHgguIXmBv6AaayGBuKCIIsmImhkUabGwkKhmJi6g+IfoGGis8uqgfLO1WzE7jtgzlQ7PSpqe47LDPAP2Ka1jO09phnUZr3VCf51zLMztZU7j1BZ6R+nAXUw9/T+pHWMvNrw1veWCAOv436P+bt7fV53YpR4ZdZIA5fsYjRQaTXc1zTTI2m8A8sMjJzypLoQ/d9JS/cpTpiiW8OH3mZOWPpEIXxnBDdHxKFX4PvBZk5Z+mwCt3j2bgbc83Y8EupjqF7uGyluoIODFKtmN5B9oy8lDIjX6DB15bLC3QfCTGbryOq8FIbqeag5zQ98NixoZqI7ol8EeSllcPXuUFEIeVz7fkiXKDd4VH4W/i+CH86/CXaHR6Fj3wRrqGHT3KDqEJOOH6T3Ng5xGcgWxHS24d+XndT7WW3Y2/q6OjoKMMHqQZ+Sq+C4zYAAAAASUVORK5CYII=>

[image11]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAXCAYAAAB50g0VAAABOklEQVR4Xu2UvUoDURCFR4xiYZ03UCxMI4KIFhHBxsJSsBXsbFKqpQ9g4TNo6yPY6AMIKr6CjWAp/s1xRl3OZnY3lwQL7wcHdr/Z5Z7kJlckk/kfXLIgzjQfmjsejJJNzanYwkgEZtd+3fb71u949DxJXPBCc0/uSoLnIc9ZDoGqgvAH5Pbch3x/gikeJBIVnBbz+CkUWXKP7a7kVfPMMoGo4IaY75Kfd79CPuRQ7IV1HjQkKrgr5pfJz7jvka/lVuzFcR7UEBXcEfOr5Ofc75NvxKL0X6yKqCB2BH6NfMf9NvmQCbED9EbSzqeoIIDHVhfZct+II827lLdhEOoKnpDDmtHzXyxo3jTHPEikquCslGe4fyH3A87AB80kDxLAQv2CY6QI3KNfd/2+9EccE/vm/hJ0yGQyg/IJpzVUm3FWq2IAAAAASUVORK5CYII=>

[image12]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGIAAAAYCAYAAAABHCipAAACLUlEQVR4Xu2YPUscURSGT2IM+BECNipiIQpCGm3SRNJaBQvBQhGLpImiqQQrkRQmhUH9DykSJIIIopW2dlrYJFiZJhj8IFEwosZzmDt4553jzozL7CzOfeBlZ54ze2e4Z3b27hI5HA6HI0f8R+EIU40iBgMoIuhEwVRy3nKasZBXPqIoQBNnn5Ld4XMomGPyxrgyr4fBcj7RJgp5yfnMaSRv4pI0Ao/9DvtC0jHvJfMoIkgyaW8438Bp79dc7kizEdpxJxT2e8a12fId58wUhD7Opdk/NW7U7Ce5qHIlzUbsoriF0JjyDb5ttkNFsy9NsZGmrYMrlmEKNjpOopBVyqISmSx0fjTinq8HRQFC87rFaee8MMWndtG4I8VpjTggbzWgJSueK/mqOD8acRshN2gclqjAeH9IL4qrUVwdOB+pfQA3C/tZk8ajqYXi3XCyjD1HaaOd7LXiphVnI7UqcL2wnzVpNEKWqF0ogSec3ygROdGy4jYV51/UpF1gHlDwgv9Z21G0clYT5q6k0Yio+ifODjj1F7YM1KG4bsWtWds2svqSVdYK54LzK1guG9JoxAgKQOZliLy/SgbJm6sfgSNIfwT1K04Q98W8PlRqtWb7FeeZVcsC+R77qeSv4vz41NNNAzDIBgoA33/rWBWcBpTMGAryHj+y1NSwB8ZP0n0mNKFZMk5ldkElYoYzhTIrJujml/h78v6xzAt5vPnKkgUUjtLzmPMIpcPhKJZrvjLIFYpjpKoAAAAASUVORK5CYII=>

[image13]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAAYCAYAAAD3Va0xAAAAyklEQVR4XmNgGAW0Av+RMMXgJQOVDKKai0CGvEMXJAeADDJAF8wE4h8MCKeGAvFfKP8NTBEScGDA4i0VIN4PZWPzN4i/HE3sOwMWC44xQAwzY4Bo4keVBoutwCKWiyYGBx8YMF3DDBUD0TBgBxXDCbB5aw4Wsb1YxFAASHITFjEXJDaMhrHfQmkUAJLUR+J7QsVgoBRKg8Q+IrFRQBIWQVaoWAKUhgFQsvjHAIk5NiRxMAAFpgS6IBCwAHEAuiAQBAMxE7rgKBhqAABNWzpFXOButQAAAABJRU5ErkJggg==>

[image14]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFkAAAAYCAYAAACRD1FmAAACe0lEQVR4Xu2YzUsWURTGT0aEuKhQjBaakBFmILpspYgLF+7Cjbjxg4ToLwhp4c6gjeCivf+AC6MMIQgEo00tbJERgqIiiKKk2IfncO/43nmYO3Nv887L+DY/eHjnPufM/Ti8w70zRAUVpwON/4ARNLLiN+sl6y8Gqpg91keq8JrvUoUHzAFzVOE1+xT5OancL/r3mNWsry8SLkU+IJVj00IpNRnXIm+w/oA3Rure7+DnHZciCzWk8rbBH9X+KfhWXIrcSfYc8VvQzDmuRR4nlXcPAxqJHaIZhUuRpaN3aGqS7vVB/jlxSPwymv+Aa5F/kD2vjlTMFg/hUuSgs6gFDqKRgp9oROD8iMbgWuS4In4jFevDAPKMtUIqeYo1FA6f84tKA06zasPhsnCJ7AsykbmkYZJ1RGosuW4Kh0PYiix/NvHXMJCWYEBTw6GMdEQtxsYmGhkhc3rLamM9YHWzPmh/opRWXrpIHdvMQiNPWNfQTGCddQXNGF6xdtEsM/JUy/o+s5ZJFfcNqfVF0Y9GOcAif2LN6Ot61oARsyH/EHw6fPWQsiHoP45HrFVSea8h5sV9NDRfKTwJnBC2bQS7tA+95H+PL9K/6yabqsgvWLfR1EjH5ssJLhrbSUi+y4Yqm45s0lkSvGwknhw0qYosO/k8mhrp+Dq0TbCdRCNrH80IttDIABnDZ/6piiw3y+4qv49Z7aReoaMmgB62XZCvY3HcpAyOTQYy5yglEdTJGzmy9OjrG6z3pDp7ep4RBieDbRduoQG0su6gmQNkrYtoZoEMZB7ddozrakfWvoRmFshxJvhYMsu6asSqlQYqff49IfUGXVBQUFCQQ84AudK//0RuecwAAAAASUVORK5CYII=>

[image15]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAYCAYAAADDLGwtAAAAmElEQVR4XmNgGNrAAYj/I2GCAKToD7ogNgBS6I8uiA5kGIi09i4Q/0MXBIFABogJH4G4FcqegqICKvgLiX8cKoYC3KGCvEhi06FiKAAkcA2LGIpCG6iAJ7IgVAxFYQi6ABSAxKKAmAeIr4AEBKGCyCAXSWwNEJvDJIKA+D0Qu0EVyEPpSiA+AVMEA5JAXILEZwfiLCT+CAQAOWkoofvPyFQAAAAASUVORK5CYII=>

[image16]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAF8AAAAYCAYAAACcESEhAAAC0ElEQVR4Xu2Yz6tNURTH1wRFfkwYyUAxe4owkiJJSSa8euVnkvKjMDEwURj5A6QYmZr7UX4+JDJgSFEKpTCQAfJjrbf3vrbvXXut8+6799x7cz717b7z3fusvff3nHd+ETU0NDT0letoFJjH2obmkLCEtRrNCtxEY5L8RAN5gobCGOsLmgrfWL+jrkFbXaxBI/KYNY6mg6wDmcbawVqIDQra/v9QJXy3SMZsCv3XYkOPWUnh4Ftn62TWcZ51FLwDFGq8iL9ePa/dDf8w6ziaBvupwqBd5AjrEmsWhXGt8OXy8xLNArgGCfwQeD8o9JNLsgbWaMML3y0AvKUwqX7ghS9UXc9l2NbO9BXRK42J/duwwt9NFQoA0n8TmjVhBZGQPhfRBE6jwXwlPQvtoCRKfgsr/EfkF7hC4a4u/ZbH335RNXxvjl57YjuFvg+wIeLWscL3Jipte2Db6t9rZOxbaAJvyJ6jPE7fRrOA1LEusdY4E3Qa/mdqf461+teBjH0HTeAu2XP8zpqDpsJVsusIXrsb/js0mRMU2haAL95T8JDN9PcgeXof96mK7HMPTeAC2aF8QENhGYXHWg9rnAm88LUC6WUKEW8rmjUi499HE7hB+twTq9AA5pK9f47br5PwNV/e+pInZ//MrK0uZPyHaAIfqX3uiU9oKDyD7aWs5+AlSuO0sMIvTVTCRV/+G37Fv7GtLmRceUKz0E6cRMlPyPp2UfjcIiebvFC+Yp3JO2V49czw5aiWCrxmnWPtpPBitZhC372s+Vm/XiNBpEBRGuKfRZPCd58taGZg7VxyKdIozaGFFb5gFdjI2pdtj7BGs+1BpLSekj8V3Jpe+Oup+mfnQecg6xiakZNodIEphy+4RYaE0jo2oNElSuO1qBK+PM+7hQYcuVnK87lGr9bm1pXw8QaisY61CM0hYTrrFJqRGaS/SHZC+sblZdnQ8J/xB3EH4IKSvypaAAAAAElFTkSuQmCC>

[image17]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACsAAAAYCAYAAABjswTDAAAA+klEQVR4Xu2UzwoBURSH71ZWslFib02SZCVPgJdQJFYWnsF7WNnJA3gIeQSkKHacX3Onzhwyf2rule5Xv2bud850zmJmlHI4/oce5clig6wUYWDRo5QpM1Le3KoshJHooYRsKUt9H3summ29ArGXvVBuUhoidNmB8pqulKm+nwc6zPF1WRTv7LzXzhaYXZMSVJRXzDC30s4WmF2XEqBw/uCiLOv3RUkc0N+QMqcLE+HhHsKZBPObUvoflQSuQylTNqJmAsxvSZnXBc6CuR2lxGqmwPy2lKBPOVG6ymsq6OuYsmZ9aXNQ7++5nwBFyoyd8WcYsrPD4XD8CC8Mnkk/HVG5hgAAAABJRU5ErkJggg==>

[image18]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFEAAAAXCAYAAABzjqNHAAAC40lEQVR4Xu2XTahOURSGl/8JRRJuJkL+ld8kRpQyUIYGUpjJHYiBGDAwFWEidUvdIhEDzNyYyIBSRKGuTCghg0vkZ713nX3v+t5v7XO/1D0p+6m376x37b3POfvv20ekUCj8e4xnI6CTMv8lM1W/VfdVXyjneak6y+Zos1Ds4aCtlBuJk6qfYnUnUy6xRtUvVuZua2qQzWK57ap1quWqpaollRIoM626Th36XbVANV11u/JOV2UaA52AGydw/d7FdfSpnrgYdfe6GEwQ68CJYkvsk1g5v9zw0mkQIyX8NThe/R5R9ahWqj4MZRsED9YVeJPIY9Ls8ywKPO6IyENbR1WrVIvFZtZ81TuxQQYzpL2d1xR/VK0nb9RZJu0PBuCdYpPgjkjAm0Mxl2OP8wl0iofLXaL4GcWN8EjaHwzwS0bkysB7yqZjl1iZnZwgcm1jzwTYRz1R+UbIdcSAxL4nVxcelmfEWLH8HU4Qr1Tn2FQui9XnbeOe6oSLR+ShDL9A9BKeX2wQuTbS5l/HD2kvc6jy2AdnVA/EclMpx0T1c2Bgjrk4dTA6NgtGKbFBrMJs53n62CByL4wzWOR7poiVGeO81B46OMcWsTL7OFGBP5hbbNbwzV3jOJSee5tqlssNcY0NZaPEL/xGWs9YEZipUd2vEvvMCrFyOPuhDkCMw3AducED8HezmQEzELM7gbrPXRwed3I3Bjh0Io8zHn43taZDeiRus+4l6xgnVs+vDDzPXBeDXPu5CZGDBwt1/dIO2zrIBrFadUO1lhMZ5kl8I3hX2CQwC9+S1y2t7d2sYr5H5IFUvhOiEwDqHqa4EXAjvwljBvPN8R0Kr9d5/ZXnQXzBxWmQ8NXiyXVizmdeqPawKVb3PMWNsF/sZvgsA7h+PJwe5EDl+6WCTyx4+MrAcv2suu7yiYtih+YdYmc77MMQlj7TaSeGe53YH6I/Xl111wVH7gyawHd0p4NRKBQKhcLf8we7JeFcA3To/QAAAABJRU5ErkJggg==>

[image19]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACMAAAAXCAYAAACBMvbiAAABrElEQVR4Xu2VvStGYRjGb5GPMPgYZJGSLDYWBpOykAwWkkIZxchgIOUPUFLKooRksZAsFoONLEqJiaJ8DBL3c57zONe5znPeN8Or1Purq/e5rvs+59xvz/kQyfP3FHHgoYqDXPCuulV9qdqphnxy4NhS1YKfEX/zmNj8RbVINUOf6hi8GchoQ1WjaoEsFdeAaoh1iDSGeUno71RTUTnADNoPfif87VCtq+ZUQ6rLnw4PJ6pd1ZqqOV4KKBf/vzHZBHncmgFYOy44YJY4IPYkfRizZei7wa/A2nBA3ku2YdL2mXNzz9yDx9qhagF8KmaYfYlO3hMvJy7q8OXGj6iuVeOQf8A6I8/k+SLsHS6v5gLxSv5I9agqo9wLX5y9w+WVXACmVefgTf+yqjBcZ+VBfjdMJriOHp/EAN8Jbyjz9RjScscZ+V5J9neh8Z3QvLww2yTv8B3raFW9UTYryf5JNKuqUgzEHuC7qTvBF4RZ2kcR3z+OOkkOU0E+aBgV+8K6Uj3FqpZ6sX1NqmKxj+pwrCNiXuywPnCYU1jnhEHVNoeA+WC67W2jWp48/5Nv9QR+3YFN+vAAAAAASUVORK5CYII=>

[image20]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIIAAAAYCAYAAAA2/iXYAAAEZUlEQVR4Xu2ZR6gVSRSGjzkM5oWiDjwxJ1AUV+pG0HFEEcaN6CzMAQwrI0YQzM5C0HGY4aG4MIwBxMUsRnAUXSiYQAQXKqiImAPomM5PVb177rlVHe5r77tif3Dorv9UnaqurtsVLlFOTs43zWdrOd85CygfCLG0ZZumxXpQqQ5PU88jtvNazBL3yfHZJ7auhaxVyRS2t1qsB9fZhmjxKxI1GFqQ8b+x1x+K3dmzmUxFvwitNdtRq+8TerUR1ZHlkHW8OE6xvdci050KbWkm7r8q7gvgI8rX0MxnW6HFejJHCxXA17/QBon0RXEf4gEVxxrAdpbtZ6FFgsLPtGip5oGQdbtmaaFC/Ma2R2ny2TA4x4t0CN0fqdYUmGMRYKh2WKp1IEyn7NuVdbw06Lpl2t3/b6/H2DqzPbFpsJHtJttgm15KphyuibhBpY1wrCbjG6sdZfAPFQaVr77FVPD9qnw+MNp9ccAlMj7MvU3ZPrC9tFqIEWy3tch8JLMYPW7TiHHfXpu7TBmg24b0j2xP2Z6ztWFbwracbS+ZgXCuLjfRMrYZIg10zEhc52M+6s82jG220LMAi9COIo2BhdjXbBovLu1nOdS+9WTWDngO+GuFb7jVfPh0dH4Tew+/nD6xyPOVKRfE+kmLHkJ1YsBKxrFtV1okrkMvWDtD5iEbyUxkfrHYTqIz3HYmKb68rt4x9poWV17jtIPi3jHQozneaYE5aa+9qbTcEY8mwbwOv+8r4wN58YuPYwOZaRwD9KrQdVsOs/VRWiQIIAPGoStMwhUtWDCwyokHUA6HLCF8AwVzq9ZADzJ79hB3qXSLp+PvptJf5Q4ysZOAWH9pMSFr2LaKNKYP33MGmUqmwGTtCDCPUq5EyXTwaS1aOpCp/0/tSIB+ERr44l6e45YWFCizyaPJWLjfKdJAD4woUH6dFhOAPvxdafiBYWpMjH6YOJAXB01pCdUBHYuhkD+KuLbDh3nS0c1qNUIDcYc1NeT3Q8NB20wq7N8fU/E87/LgxewSug/knaTFSoHK047acrisBTJbHbf4inupPtDpoTI1ZHzthPbKappDbAu1KKil0nJ/kHm5Ep1ngtK0XxPnzxycNrmOl9ZJZvIwl/yNbamFACiLUy5ME7gfVeyu297Bkmwfe5K/PeAemS0j/DiIwaf/RFGOAqEYDtlHmEoR90VRDvN/jF6hIx8WrI6oevCVjfJXFQ+ptLFRCywf6DB0ZmjwYF++iq2LdgTQ7XFA32LvsdvpJ3wafaKnQSy8VJxHYI3k++MHc3R7paFcL5HGFyzESra1WqxW8GByZRr1i6wUo9n+VVpfSt6ubVrwgFgTtajw1Se1/9gakxlIPnzlqw78JYsBgMZi5GMfe8Cm94t8DYXuxL89Woi4fDiujcsDcPLYioqnjDviHqe32Pe7AzQJvlxJ6siJAWsb15G4SlvkMnnAlhmHLiF0LHfCmDVYNOdkxEgyU1UaXpOZ9xuSqHVDTk5OToX4AuRBRNTEVeDhAAAAAElFTkSuQmCC>

[image21]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAYCAYAAACIhL/AAAAB2klEQVR4Xu2Wuy9EQRSHj1eChEJNRISIRq1BISqVRjQS/gCJUCiVdDQ6IhEdUQmil4hGIaGgVVBIxCsRj/MzM+7s7567azer2y85yc53zjzu3Dv3rkiFCkXzplHPsgBfLP7CnbiOexq7/vdLTkWaMxZF8MEiixZxi1kjX+v9PvnAnJS4E557jSuWTL+4SXo5EYH8BktxvpFlkeS9wCZxBbid+UCNNZDliuVcY5xlIGtixqq71lggVwodkh77h/B8mUnCqkO7gVzgVZJ67A4OGtrzvxW58Ng/4NWAxBgnDLIWaBH8o/+NAxjntqJ2AD71mrImtZgWV4cJY6y+NZK8lpBfinLBWf3g+ixpFTNWHa6WXUzWc2WNBeAmLWkVxyyLq1kkD/L13ZR0vsq7dfIAfpAlvgBIZD3oAHk88Ba8gBjr4i8NF4BvZlntEyec8DxrPLGMQF/sigUvEJuAdnvkYrIWLsPikhcabRo9GsfejUZ1FjiN1u0C6L+jsaox5dvdORUJIxrvLJkDcbfyRmOWclm0anyyVDol2ZEhjYkkZXKkMcCyXGAhPPit/P1fSvhY/BuHkl4MJlwhl8WpxgPLcjOj0aVRJ8nh4ENigd3bZvlfFFqMhfX8VigL37tNiNTezOSrAAAAAElFTkSuQmCC>

[image22]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAG8AAAAYCAYAAAD04qMZAAADjElEQVR4Xu2ZS8hNURTHF0JSpESJibeJCckASd7JyEAGSHlEeZQ+mcgjGSkjpZRMPEoeA3lMvBKJiZS8BpRQnpG82f/23n37/O/a5+5zXee7vu/8anXP/a+191n77Hv264pUVFRUVHQwv1kIGG9sOIudlFHGJrFYkPfSYB2vxXbESWe4/piJqOUDCwEHjN1lMWCYsX4slsxpse2M2aL20CRuGbvGYkFQR28WYwwUm+g+0lEB9OOke84a+8RiQN4buU6sfyo7OgjfWZ7uxhYqegpF4zWS6pgiNnA0OwLg38ui5N/ghLEJLBouGlvvrlu58zyrJd7+GBg+H7FYkF9Spw4MWUjsKDsIrWEDjD0jLYTjNVqt856zKHY0gu8mO+qQ0v48MFzn1qF1ioYWh+8TSfMcktp4jVbpvCVicxnJDtHbngLKHGSxINH79pT0xLQ4/h7yQ/L9nlbpvIei59tXrP6YHQloz+yd054YG+Suv7lPDejqSv2rWCcm5XpwIn4hEwM+JFoPxE1jsQPw7WPDirtRMKWEz+iKsTHG2py+NPBtE9sfDOrYwSLgDomxUWxcOB9gcZNXFr47LCogbjqLJTNEbB4rAq2H054GWlHQWeEz8tcvSQebFQ2gjmMsgtTO0+LmK1oIfEdYVEDcDBYj+DxS7JwrkwKGRK0tp0TXU8EeVyvvcwzBdos1gDruswi0Spj9YmPw9oWMcHoM+G6wqIC4mSyWTOw5+AOLRsGWSCsP7bKiYWvAoI7zLAIMayiUt5OHP3bCoiXmgU8bwxnEzWaxZGKdF9MBDjXwsH+yI+CN6OWh9Qm+L3dat0DzoI49LAKcIKDQVXY4vog9Z4uhJebJa3gIYuayWDLI4RWLUtuGF+5zl2R/0LH8uTzAvMqaFueBjkWOyhyxATh/HGpsnLFLTpsVxGlgAbOYRccqiSf0QNoTZisLnIDwvfn+352GxctkY/OcDm2lscPG3jpNA3G7Fe2e+1wg9lx4SyYiC+ekckHsm4bJewP5YiwzdpvFgKQbtzhbjX2W7LyT2i4tDpp/KdYYGxz4GGyhtDqaBirHRlZjp9jGdzZ4/6qtltca20QaOqtIZyCW62gqmFAxDMYokuz/AtrUX2ynxf4O09pddPVaJLZhzhjrxaLD/2PRlcAqFH9Ah+AZhDY2665B2zb8M/I6CBMyzlG7AvgRb2exINfl7+uoqKhoKn8AprgsjFGR5n0AAAAASUVORK5CYII=>

[image23]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAAYCAYAAAD+vg1LAAAA90lEQVR4Xu2RMQ4BURCGJ4io3ECnEhEXcAA1jU4jEdEKR3AElUYl0TkArUZFo5IoNKIVDeZl3ktm/2zW2w3R+JI/2f3+t5PZXaI/v+AZkak6l4gxyaCGcnXrTPLKx8INCCOqe4t58ILSknhwk+TBMhZMj6TbYOHDjsI3ypH4Exa+uFfFLDlpdS42+A1TnDvnrFwizNAFShI/R+lLi2RABQsSf0DpC34Gx4zET7BgMpw1Sd8ONApTXlEyN5JuZO+LqtOLBJYyh9ymOpqqdVt7/bDeuA5nSPKDC9bHYsA5clbK4QIfAwf34T4xXU6Jk+XsObVg/eebvACp/kqXVvYLIQAAAABJRU5ErkJggg==>

[image24]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAYCAYAAAAYl8YPAAAAo0lEQVR4XmNgGAWUgL9E4M9A/BSmARcIAuL/QLwaiN2A2BrKB2FXIDYAYlsgvgIVwwuwKYAZhg6wicEBGxD/QRdkINMwUBiwoIlJM0A0taOJgwBew7CB2QwQTTzoEuQAXF4kC4AMOokuiAZk0AWwgTkMEMP40CWgACTXCKUJAmK9SIyaQWYYzABsGBfAJ0cyGHyGlQDxVgaIYaDsloMqPQpIAQCqYTz6fXTvGAAAAABJRU5ErkJggg==>

[image25]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAYCAYAAAAYl8YPAAAAzUlEQVR4XmNgGAWUgL9E4M9A/BSmARcIAuL/QLwaiN2A2BrKB2FXIDYAYlsgvgIVwwuwKYAZhg6wicEBGxD/QRdkINMwUBiwoIlJM0A0taOJgwBew7CB2QwQTTzoEuQAXF4kC4AMOokuiATsgTgWXRAbmMMAMYwPXQIKfiOxQerakPgYAJ8XORlQ5UAJGZdaMMBnGAjwI7EJqSWsAAmA1OVhE8SFcYFzQMyMLkgOmAzEpVC2ILIEqcAeic3OgN/1eAEXA2YwECySRgFuAAAbNUL+9oT+iAAAAABJRU5ErkJggg==>

[image26]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAXCAYAAACFxybfAAABZklEQVR4Xu2UvytGURjHnxQxMLIok6KwSDaTTTLJj0EpSgaDzR9gMMrgDzBI2QwWw2uzKeVPsIsQCd/nvc/pPu/3PVfd7lGG+6lv73m+33PPfd5z7r0i/4wBaJq8Iar/lDs3vocmbHwCfZP6LEuOLh4Yha5s/Oh85YPqpGgTz1CHjWN8seHQaw6gQfvVuWeS/aFShO3u4sCYZcN4g+bIW5RsrVJN6C4ok5Jd3MijJk9UB8aleOcOpUQTC9Clq5ekfWGuA2tSnPVKiSY2oWvy/MKaF91ICce4zoFjBFqGjiQ7uhXouGUGeIA6bfwC9btMJ//WREPyRlTv0LCfAG4sU+1A+5I9vEnftnCELMb789CMy5Khu7kn+c1WW+OmV/SQJ6dH4ruh9QV5ldmS/OvK7Eq8iXPyKrMt7TcK6APImdan5FUmNKHfGkb97oiX/DhCE/rp/oQ2oDHzXt28W/O8plxeU1MT5Qcv4GEU9+RWcQAAAABJRU5ErkJggg==>