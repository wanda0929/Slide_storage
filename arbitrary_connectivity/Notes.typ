#import "lib.typ": conf, part
#import "@preview/physica:0.9.4": *

#show: doc => conf(
  title: [Notes on arbitrary connectivity],
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

#v(2em)
#part("Quantum feature maps for graph machine learning on a neutral atom quantum processor", [
  1. 在包含32 qubits的中性原子的quantum processor上面完成了machine learning tasks on graph-structured data.
  2. 由于Graph在manipulating complex data 方面优势明显，所以能够create efficient machine learning models来有效的学习以及从graph-structured data中提取信息变得很重要。其中如果想要高效分析graph data，很多人会利用Graph Embedding Techniques，这个方法可以高效的把高维，稀疏的graph转换为低维稠密向量，节省储存和计算资源。其中也保留了node之间的连接模式。
  3. 也可以用超级大的Hilbert space来产生graph embedding。（geometric quantum machine learning），将graph- structured data encode到quantum states当中来进行相关操作。
  4. Quantum evolution kernel（QEK）也是将graph编码到量子态及相互作用上面，让他们根据哈密顿量进行演化。（Kernal可以衡量两幅图的相似度）。
  4. 文章当中格外关注graph- structured data的QEK-type quantum feature maps。并且在32 qubits的中性原子quantum processing unit上面实验性的探究了很多问题。
  5. 工作：在具体的工作当中，展示了上面提到的map可以帮助我们区分两个graphs，他们locally equivalent but nonisomorphic。并且通过QEK on real-world classification task来证明在分子数据当中预测雌性小鼠毒性激发。并且将自己的方法的性能与经典方法进行了比较。
  #figure(
    image("touying-simpl-hkustgz/examples/data operation.png", width: 85%),
  )
])

#part("Hardness of the maximum-independent-set problem on unit-disk graphs and prospects for quantum speedups",[
  1. 基于之前的289 qubits的实验（通过将stimulated annealing视为绝热算法的经典模拟，来对量子变分算法进行基准测试），作者聚焦于用更加广泛的classical solver来解决MIS on unit-disk graphs的问题。同时，他们assess problem hardness。他们用了精确方式（结果好）和hubristic方式（时间短）分别进行了解答
  2. 他们找了一个准平面的例子，是Union-Jack-like的连通线条，他可以在分钟水平上解出上千个nodes。
  #figure(
    image("touying-simpl-hkustgz/examples/UnionJack.png", width: 75%),
    caption: "Union-Jack-like的连通线条，解MIS",
  )
  3. perform a scaling analysis，通过将束缚弛豫到经典simulated annealing algorithms，这个操作与量子算法不相上下。（因为原版的stimulated annealing是必须按照固定路线，每次只能尝试一条路，探索有限空间，所以算法运行慢，容易陷入局部最优解。但是如果放松约束的话，就允许同时分几队去探索不同路线，那么如果有死胡同，可以更快调整方向，虽然不如量子叠加高效，但是通过优化整体可以将速度提升到量子水平）。
  4. 如果问题的连接点多，结构混乱，解题时间可能暴涨成百上千倍，于是我们专门设计了一套方法，专门生成地狱难度的问题来测试量子计算机（比如里德堡原子阵列）的极限--这些问题能让传统计算机直接卡死。
  4. Proposing protocols to system来调整问题的hardness，对更困难的问题设计实验求解。
  6. 研究了MIS on unit-disk graphs的问题，使用了大量的exact and heuristic classical algorithms。
  7. 在研究MIS过程中，他们使用了exact sweeping line algorithm（SLA）来解决问题，这个方法会完全列举，并扫一个通过二维平面的虚拟的线。
  #figure(
    image("touying-simpl-hkustgz/examples/SLA.png", width: 75%),
    caption: "Sweeping line algorithm",
  )
])

#part("Randomized Benchmarking Using Nondestructive Readout in a Two-Dimensional Atom Array",[
  1. 问题：高保真度门以及low-loss readout method能够应用的中性原子平台上的原子数量有限。一般来讲，未来的fault- tolerant scaling需要使gate operation below the error threshold以及能够perform scalable and high- fidelity nondestructive readout（NDRO） 来抑制测量误差。
  2. 本文做了一个随机基准测试，包括NDRO，能够不损害的情况下扫描量子比特的状态，以及扫描时不仅能得知他的状态，还能同时确认他是否在场，最后只保留在场的量子比特对应的数据，排除因故障丢失的结果，提高最终计算的准确性。
  3. 它实现了高保真度的单比特门操作，通过perform randomized benchmarking of global microwave pulses on an array with 225 sites using 传统destructive detection。又进一步陈述了perform NDRO的方法（在49qubits array上）。
  3. 在实验当中，用1064nm的光镊囚禁原子，NDRO是通过一对沿着quantization axis，相向的laserbeams实现的。微波通过horn antenna来emit，实现全局的单比特rotations。实验中使用的是133Cs原子，施加$sigma+$的laser，诱导原子发生$Delta m = +1$的跃迁，通过heating，将F=4的态blow away，只保留F=3的态。（？？）
  #figure(
    image("touying-simpl-hkustgz/examples/NDRO.png", width: 75%),
    caption: "Experimental setup for randomized benchmarking and NDRO",
  )
])

#part("Extending relax-and-round combinatorial optimization solvers with quantum correlations",[
  这篇文章将经典的松弛-四舍五入（quantum Relax-and-Round QRR）技术与量子近似优化算法（QAOA）结合，为了更高效的求解组合优化问题，相当于先用经典方法“软化”问题，再用量子算法优化，最后回归实际解。相当于将离散问题转化成连续的优化问题，找到最优解之后在连续解转换为离散分组。松弛是为了快速缩小搜索范围，避免量子算法盲目搜索，而优化是为了利用量子并行性精细调整，突破经典，局部最优。
  2. 将其应用于很多问题，包括p=1情况下的Sherrington-Kirkpatrick spin glasses，这和其经典对应一样精确，且maintains the infinite-depth optimal performance guarantee of the QAOA. 同时也用一个不同的round scheme来证明这个方式也可以解决Goemans-Williamson MAX-CUT问题。
  2.1 GW max-cut problem：将一张图的顶点分为两组，使得连接两组的边数最多。GW算法当中，他们将顶点映射到高维空间，每个顶点看成高维空间的一个单位向量，为了让相连顶点的向量尽可能方向相反（对应边被切割），将上述优化问题转化为半正定规划问题，利用数学工具找到最优向量配置。在高维空间当中随机选择一个超平面，根据向量在超平面哪一侧，将顶点分成红组和蓝组。
  3. SK问题：Sherrington-Kirkpatrick（SK）模型是一个理论上的“混乱人际关系模拟器”，用来研究当一堆小磁针（自旋）之间的相互作用完全随机（有的互相吸引，有的互相排斥）时，整个系统会如何“集体崩溃”或找到某种平衡。 SK模型是自旋玻璃中最经典的数学模型，它有两个关键设定：完全随机互动：每一个磁针都和其他所有磁针有随机设定的互动规则（正或负）。比如1000个磁针，每对之间的规则都是抛硬币随机决定的；完全连接：每个磁针都能影响所有其他磁针，没有“邻居”的概念。我们希望在这个混乱系统当中可以找到能量最低的稳定状态
  #figure(
    image("touying-simpl-hkustgz/examples/SK_optimal.png", width: 75%),
    caption: "Relax-and-Round",
  )
  4. “Our approach can embed other algorithms than the QAOA and directly applies to higher-order problems and those with one-body terms”(我们的方法可以嵌入除QAOA之外的其他算法，并直接应用于高阶问题和那些具有一元项的问题)考虑到用quantum annealing来解决MIS问题，在大部分的处理思路当中，“A penalty disfavors invalid solutions but will not prevent them outside the p → +∞ limit”。在这里，可以使用QRR算法，作为启发式方法，后处理硬约束，来解决这个问题。用“量子计算结果”指导“经典贪心算法”，通过概率提示一步步调整答案，确保最终结果符合硬性约束条件。
  5. 量子计算生成“概率提示”：通过量子算法（如QAOA）计算得到一个矩阵，反映不同变量（如用户）之间的关联强度。将矩阵分解为多个“特征向量”，每个向量代表一种潜在的分组模式。每个特征向量中的数值平方，可以看作是变量被分到某组（如+1组或-1组）的概率。例子：若用户A对应的数值平方是0.8，意味着它有80%的概率被归入+1组。 2. 贪心后处理解决约束问题：量子计算给出的初步解可能不满足硬性约束（比如选出的用户中有好友关系）。贪心策略：按概率排序：将变量按概率从高到低排序（如用户A概率0.8，用户B概率0.6，用户C概率0.3）。逐个确认分组：先选概率最高的用户A加入独立集。排除所有与A有冲突的用户（如A的好友）。接着在剩余用户中选概率最高的用户B，重复直到无法继续。结果：得到一个满足所有约束的解（如最大独立集）。

])

#part("Design and execution of quantum circuits using tens of superconducting qubits and thousands of gates for dense Ising optimization problems",[
  This work developed a hardware-efficient ansatz for variational optimization. 一般来讲，在noisy intermediate-scale quantum环境当中，量子优化需要输出具有挑战性的组合问题实例的高质量解决方案，初步的部分实验很大问题在于没有明确的途径在解决噪声和其他的硬件限制（比如连接性和native gate sets）。在本篇工作中，作者假定在一个真实世界的device with limited qubits，connectivity and gate primitives，如何在这个基础上有效的解决优化问题？

  因而本文的算法牺牲理论上的完美性但是利用更少的量子资源以及更简单的操作来完成任务。努力让量子算法更加适配硬件特性。

  传统算法的困境： 许多量子算法需要大量逻辑层，（即多次量子门操作的串联），但由于硬件噪声，层数越多结果越不可靠（保真度下降）。本文设计“极简”量子电路，减少层数和资源消耗，但需要更多参数调整。比如算法结构优化：根据具体问题的结构设计更紧凑的量子电路，（比如原版QAOA需要对所有边进行耦合操作，改进后仅对关键边操作，减少量子门数量）。
])

#part("Circumventing superexponential runtimes for hard instances of quantum adiabatic optimization",[
本篇文章以MIS问题为例子，传统是量子绝热算法，让系统从简单的初始态平滑过渡到目标及态。这个演化时间取决于系统能隙（要么系统会卡住），对于很复杂的特定MIS图，其能隙随着原子数量增加而超指数缩小，那么系统会在演化初期陷入与正确解差异很大的状态，这个时候quantum quench可以帮忙。此时，我们不再缓慢调整参数而是突然改变系统规则让系统跳出错误状态。那么quench之后可能会更接近目标态。如果能够通过quench出发scar state（可以抗拒环境干扰的退相干，长时间保持与基态的强关联性），那么有可能西戎绕过能隙陷阱，直接逼近解。
#figure(
  image("touying-simpl-hkustgz/examples/MISadi.png", width: 75%),
  caption: "Quantum optimization with arbitrary connectivity using Rydberg atom arrays with adiabatic evolution",
)
#figure(
  image("touying-simpl-hkustgz/examples/quench.png", width: 75%),
  caption: "Quantum many-body scars as an algorithmic tool: instead of slow adiabatic evolution, the system is driven to the S state. Then, after quenching to δ = 0, the readout is timed such that the probability to obtain the desired MIS state is maximized.",
)
])

#part("Rydberg-Blockade-Based Parity Quantum Optimization",[
  In order to extend the calsses of problems that can be efficiently encoded in Rydberg arrays, they constructed a mapping from a wide class of problems to maximum-weighted independent set problems that is encodable in Rydberg arrays on unit-disk graphs, with at most a quadratic overhead in the number of qubits.

  The introduced copy and crossing gadgets allow the encoding of any unweighted Quadratic Unconstrained Binary Optimization (QUBO) problem into a weighted Maximum-Weight Independent Set (MWIS) problem.
])

#part("Rydberg-Blockade-Based Parity Quantum Optimization",[
  本篇文章主要是解决higher-order constrained binary optimization（HCBO）也就是高阶约束二进制优化，他包括多个变量之间的高阶相互作用约束（比如三个或者更多变量的乘积项），传统量子or经典方法处理他的复杂度很高，但是本文提出通过中性原子量子器件based on Rydberg Blockade来高效求解。

  首先是通过Parity encoding来将任意高阶约束的HCBO问题转化成QUBO问题再映射为MWIS问题（引入辅助变量简化问题）。那么这就可以encode到Rydberg array上面了。具体的architecture是是架构了小的MWIS模块，（problem-independent building blocks--模块化构建）将大的问题分解成小的独立模块，每个模块在硬件上独立处理，最后将结果合并得到全局最优。
  #figure(
    image("touying-simpl-hkustgz/examples/MWIS.png", width: 80%),
    caption: "Rydberg parity MWIS protocol？？？",
  )
])

#part("Universal Quantum Optimization with Cold Atoms in an Optical Cavity",[
  本篇文章主要提出来atom cavity is universal for quantum optimization with arbitrary connectivity. 工作当中考虑了一个单模cavity，主要通过Raman coupling进行调控。（同时通过发射/吸收腔模光子还能够间接与其他原子耦合，实现长程相互作用）。他们首先是在上面通过对原子Hamiltonian进行engineer来encode number partitioning问题（将一组数字分成两个自集，让子集之和的差最小。可以让每个数字对应一个原子，原子的态暗示该数字属于A还是B，之后$H = (sum_i a_i Z_i)^2$,$a_i$可以当作数字的值，那么当H最小的时候，能够实现差最小，也就是说我们要找到基态）。这个问题通过adiabatic quantum computing可以实现。

  同时，他们也construct explicit mapping for 3-SAT问题（判断布尔公式是否可以满足）及Vertex Cover问题（选择最少的顶点，使每条边至少有一个端点被选中）。然后这种atom cavity encoding可以进一步延伸到QUBO问题。

  优势：光子媒介允许原子间天然的全联接，并且原子数随着问题规模是线性增长的，适合大规模优化。

  个人认为，光子寿命有限，需要高Q值的cavity降低损耗；光镊导致的address误差会影响到coupling strength；能隙小的时候会有长时间演化的问题。
  #figure(
    image("touying-simpl-hkustgz/examples/CavityQED.png", width: 80%),
    caption: "Cavity QED setup for solving number partition problem, the fig(c)means the diagram of the resonant 4-photon process ",
  )
  在本文的具体问题当中，这个需要求基态的Hamiltonian是$H_("NPP") = (sum_(i=1)^n lambda_i sigma_i^x)^2$,需要对coupling过程进行设计来通过基态求解。

])

#part("Floquet engineering of interactions and entanglement in periodically driven Rydberg chains",[
  In this work, thry performed Machine-learning tasks on graph-structured data on neutral atom quantum processor containing 32 qubits.
])

#part("Iterative Quantum Algorithms for Maximum Independent Set: A Tale of Low-Depth Quantum Algorithms
",[
  该研究的具体工作与贡献

研究者提出并分析了一类新型混合量子优化算法——迭代量子算法（Iterative Quantum Algorithms），旨在提升组合优化问题（尤其是含硬约束的问题）的求解效率。以下是具体内容：

1. 算法框架：迭代量子算法

核心思想：将经典优化策略（如贪心算法）与量子近似优化算法（QAOA）结合，形成迭代式混合优化流程。
递归推广：扩展了 递归量子近似优化算法（RQAOA），通过逐步缩小问题规模（递归分解）逼近最优解。
硬约束整合：在量子电路设计中直接编码问题约束（如最大独立集的无相邻顶点条件），避免松弛方法引入额外误差。
2. 最大独立集（MIS）问题的应用

问题定义

在图中选择最多的顶点集合，使得任意两顶点不相邻（无共边）。

量子与经典算法的对比

当QAOA深度 
p
=
1
p=1：
算法操作与经典贪心算法完全一致——每次选择度数最低的顶点加入独立集，并移除其邻居。
意义：在浅层量子电路中，量子优势未显现，但验证了混合算法的正确性。
当QAOA深度 
p
>
1
p>1：
引入更深量子电路：通过多层参数化量子门（如旋转、纠缠）增强表达能力。
算法改进：调整哈密顿量设计或优化策略，使量子演化捕捉更复杂的关联性。
实验结果：性能超越经典贪心算法，且无法被经典方法简单模拟。
3. 关键技术创新

混合优化策略

经典步骤：利用贪心算法确定局部决策，缩小问题规模。
量子步骤：在剩余子问题上应用QAOA进行全局优化，避免陷入局部最优。
迭代流程：交替执行经典选择与量子优化，逐步逼近全局最优解。
硬约束编码方法

哈密顿量设计：通过里德堡阻塞效应或惩罚项，确保量子态对应的解满足无相邻顶点条件。
资源效率：避免引入辅助量子比特，直接利用问题结构简化约束实现。
4. 实验结果与性能提升

实验设置：
对比不同深度（
p
=
1
,
2
,
3
p=1,2,3）的量子算法与经典贪心算法。
测试图包括随机图、规则图（如环状、网格）及复杂结构图。
结果：
p
>
1
p>1 时，量子算法在解质量和收敛速度上显著优于经典方法。
算法对图结构变化鲁棒，尤其在稀疏图中表现更优。
5. 研究意义

理论贡献：
量化了量子算法在浅层与深层电路中的行为差异，揭示深度对性能的影响。
提供了一种将经典启发式方法与量子优化结合的通用框架。
实用价值：
为含硬约束的优化问题（如物流调度、芯片布线）提供了高效的量子-经典混合解决方案。
推动QAOA在实际量子硬件上的应用，降低对量子比特数量和错误率的依赖。
总结

该研究通过迭代式混合策略，将经典贪心算法与量子优化深度结合，成功解决了最大独立集等复杂约束问题。实验证明，随着量子电路深度的增加，算法性能显著提升，展现了量子计算在组合优化中的潜力。这一工作为设计更高效的量子-经典混合算法提供了重要范例，强调利用经典智慧增强量子方法的实用价值。
])

#part("Non-native Quantum Generative Optimization with Adversarial Autoencoders",[
  该论文的具体工作与贡献

研究者提出了一种新型 对抗量子自编码器模型（Adversarial Quantum Autoencoder Model, AQAM），旨在解决大规模优化问题在现有量子硬件上的映射与求解难题。以下是核心内容的分步解释：

1. 核心问题与挑战

量子比特不足：现有量子采样器（如中性原子设备）仅有少量可用量子比特，无法直接编码大规模优化问题（如工程、金融中的复杂模型）。
约束不匹配：优化问题的约束条件难以直接对应量子硬件的原生哈密顿量（如里德堡原子系统的阻塞效应）。
2. 解决方案：对抗量子自编码器（AQAM）

(1) 模型结构

量子自编码器（QAE）：
编码器：将高维优化问题压缩（降维）至量子硬件可处理的低维潜在空间（latent space）。
解码器：从潜在空间恢复原始问题空间，生成优化解候选。
对抗训练（Adversarial Training）：
引入判别器网络（经典或量子），区分生成解与真实最优解分布，迫使自编码器生成更接近最优的解。
(2) 量子增强的玻尔兹曼采样（Quantum-Enhanced Boltzmann Sampling）

潜在空间采样：在量子设备的潜在空间中执行玻尔兹曼采样，利用量子叠加和纠缠高效探索解空间。
优势：相比经典马尔可夫链蒙特卡洛（MCMC）方法，量子采样能更快跳出局部最优，逼近全局最优解。
3. 实验验证：超表面单元设计

(1) 问题背景

设计一种 广角滤波超表面（Broad-Angle Filter Metasurface） 的64x64像素单元结构，用于提升中性原子设备的相干性。

优化目标：最大化特定波长和角度的透射效率，同时最小化噪声。
(2) 实验步骤

问题压缩：将64x64像素（4096参数）优化问题通过AQAM映射到 12个中性原子 的潜在空间。
量子采样：在潜在空间中利用里德堡原子系统的量子特性生成候选解。
解重构与评估：解码器将量子采样结果恢复为像素结构，计算透射效率与噪声指标。
(3) 结果对比

性能指标：
Renyi散度（Renyi Divergence）：AQAM生成的解分布更接近理论最优分布（比经典MCMC低约30%）。
能隙（Spectral Gap）：AQAM的能隙更大，表明系统更快逃离局部最优，收敛速度提升。
实际效果：优化后的超表面单元显著提升了中性原子设备的相干时间和信噪比。
4. 关键创新点

高效问题压缩：通过AQAM将高维问题映射到低维量子空间，突破量子比特数量限制。
对抗训练机制：结合判别器提升解的质量，确保生成解满足复杂约束（如光学性能要求）。
量子采样优势：利用量子并行性加速解空间探索，显著优于经典MCMC方法。
5. 技术细节解释

术语	通俗解释
量子自编码器	一种量子-经典混合模型，将大问题压缩成小问题（类似“缩小镜”），再恢复完整解。
对抗训练	通过“生成器-判别器”对抗博弈，提升模型生成解的质量（类似“真假鉴别游戏”）。
玻尔兹曼采样	按能量分布概率随机采样解，量子版本利用叠加态同时探索多个候选解。
Renyi散度	衡量生成解分布与理论最优分布的差异，值越小表示越接近最优。
能隙（Spectral Gap）	量子系统基态与第一激发态的能量差，能隙越大，系统越容易稳定在最优解（不易陷入局部最优）。
6. 意义与未来方向

硬件适配性：为现有小规模量子设备（如中性原子采样器）提供了处理大规模实际问题的通用框架。
跨领域应用：可推广至物流调度、金融组合优化、材料设计等领域。
量子优势验证：通过实验量化量子采样在优化问题中的性能提升，推动量子计算实用化。

])