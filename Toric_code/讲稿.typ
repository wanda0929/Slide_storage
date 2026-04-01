#import "/Toric-code/Slides/lib.typ": conf, part
#import "@preview/physica:0.9.4": *

#show: doc => conf(
  title: [Non-Perturbative Floquent Engineering of the Toric Code Hamitonian and its Ground State],
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
大家好，今天主要想给大家介绍一篇工作，它通过Floquet engineering，在2D lattice上面实现了Toric code的构建。由于在小于4D的量子系统当中，self- correcting的实现是不确定的，而这个工作通过2D lattice上面Toric code的构建，说明它拥有实现量子系统self- correction的potential。

- 主要部分
我想主要从以下几个部分来介绍这个工作：
因为工作中涉及Toric code的构建，所以背景部分主要介绍quantum error correction以及Toric code以及二维开放边界下的surface code等的介绍。

其次就是对这篇文章进行介绍。

这个工作当中，对5*5的lattice的模拟并没有达到热力学极限，我们希望在噪声条件下对更大的系统通过Pauli- propagation的方式进行模拟，能够让计算量与系统大小无关，如果能够观察到exponential decay，那就说明满足了self- correcting的条件之一。

具体的self-correction的介绍我们放在最后。
//由于这个工作中模拟的5*5的lattice达不到热力学极限，我们希望能够用更大的系统进行模拟，并且在噪声存在的情况下验证它的scaling，如果可以观察到exponential decay，那就说明满足self- correction的条件之一了。我们计划利用Pauli- propagation来进行大规模的模拟。最后就是对self-correction进行介绍，因为最终目标还是要实现self-correction的。
- 背景部分
在量子计算当中，由于各种noise的存在，error的累积会让需要传递的信息变得随机或者是丢失，这就会让我们的计算变得不可靠。所以，我们需要error correction过程来保护我们传递的信息。

在经典系统当中，可以通过Classical repetition code来进行纠错。他们可以通过直接的复制操作来encode bits，如果有bit flip error发生的话他们直接通过majority voting来纠正错误。

但是在量子系统当中，事情就会变得复杂了。首先，我们不能直接复制量子态，因为这会违反no-cloning theorem。其次，我们需要考虑到量子态的superposition，所以我们不能直接通过majority voting来进行纠错。直接的measurement会让量子态塌缩等，所以，我们需要一种新的方法来进行纠错。

首先针对量子系统的non-cloning theorem，用redundancy来代替经典系统的直接复制。将一个逻辑比特的信息编码到多个物理量子比特的纠缠态当中。这就规避了no-cloning theorem。

其次就是错误的检测，这里引入了stabilizer的概念，他们是一组commuting的Pauli operators，所以他们的本征值是+1，-1。可以通过一个例子来看如何通过stabilizer的syndrome确定有无错误：（看纸条），这种测量方式既能检测出错误又不会破坏量子态。

下面是一些error-correcting code。
-- Toric code
我这次主要是想对Toric code进行相关的介绍。
首先，Toric code主要包含两种算符，ZZZZ和XXXX。其中ZZZZ围绕着一个vertex，XXXX围绕着一个plaquette。他们的本征值都是+1，-1。所以他们可以作为stabilizer code来纠错。在这个京哥当中，每个edge上面的圈圈代表一个物理比特。所以里面edge的总数=物理比特的总数。他们所在的这个二维lattice 具有周期性边界条件，所以有着类似于甜甜圈的结构。（拓扑结构介绍？）
1. 对于哈密顿量的介绍：
整个toric code的哈密顿量如下所示。首先，这两个算符的本征值都是正负一，如果overlap的话，他们overlap的edge数量一定是偶数，这样的话我们也知道$X_1X_1$和$Z_1Z_2$算符之间commute，所以他们之间一定commute。（这种commute确保存在共同的基态空间，除此之外，测量所有stabilizer的本征值可以定位错误，如果不对易的话，算符会互相干扰，没办法唯一确定错误位置）

2. 关于logical operator的介绍

首先encode logical operator有几个要求
（1） 一定与stabilizer group的所有elements（$A_V,B_p$） commute。
（2） 逻辑算符必须满足与普通量子比特相同的 Pauli代数关系。
（3）逻辑算符不可以通过局域操作来消除，在甜甜圈上面，如果是一个小的正方形闭合路径的话，那么他恰好和某个面算符的面重合，他就可以被分解成多个bp的组合，他不是全局独立的了，但是如果是沿着环间绕一圈，我们就没办法用局域的AV，BP给他消除掉了，这就说明他是全局的。

那么甜甜圈上面有两个独立的，非可缩闭合路径，每个路径对应一个逻辑量子比特，而环面上有两个独立路径，所以可以编码两个逻辑量子比特，每个逻辑量子比特希尔伯特空间维度是2，所以基态简并度为4。

（也可以这样想，我在环面上构建一条Zoperators，会发现这条线的端点这里，Z和vertex operator只有一个overlap，那么单个XZ不commute，他和vertex operator并不会commute，除非它能够形成一个loop，这样的话一定是commute。所以我们需要找到没有终点的string，那就是一个环）

#figure(
  image("logical.png", width: 80%),
  caption: [
     square lattice with periodic boundary
  ],
)
//3. 对于nkd的介绍和计算
//如果按照[[n,k,d]]来看，n代表物理比特数量，k代表逻辑比特数量，d代表code distance。

//对于LxL格点，$n=2L^2$
//刚刚也讨论了，逻辑比特数量是2，所以k=2
//code distance是看最小逻辑算符需要几个物理比特，这里为L。 

//4. 关于它基态的判断：
//在拓扑结构上研究，已知如果这个环并没有wind around torus，我们可以通过contraction让他disappear；所以，会有四种loops无法变形成另一种：Trivial class with no loops；a loop winding around the torus in either direction;the combination of two loops with one winding around in each direction. 所以刚刚提到的可以被contract的环实际上相当于一种没有环结构的trivialstate。所以，如果a string of occupied edges that winds around the torus in one direction 是无法被收缩的，只能break the string somewhere。


5. 如何探测到错误：
下面就是如何能够detect到错误，
//我们还是通过measure stabilizer operator，通过syndrome来判定是不是有错误，当出现错误的时候，stabilizer operator的本征值会发生改变，变成-1. 
将态1表示为occupied，0表示为empty。同时，对于Pauli-Z来讲，1态对应的是本征值-1，而0态对应的是本征值+1. 那么对于$A_v$来讲的话，如果一个态with all edges unoccupied，也就是说，所有edges都在0态，对应的$A_v$的本征值就是+1，如果有单个qubit翻转，我们用对应位置的$A_v$去测量的话，三个+1，1个-1，最终结果是-1（但是如果是偶数个翻转的话，结果就还是1）. 如果某一个vertex operator周围有奇数个翻转的边（occupied edges），对应的$A_v$的本征值就是-1.所以只要这个空间里的错误string有头尾，就可以测出错误。

- Surface Code
这是二维晶格上面的code，第一张图粗线的部分是Toric code，如果把这个格子旋转一下，让edge上面的qubits放到新格子的格点上面，再把格子转回来，就基本是surface code的样子。相比于Toric code，surfacecode所在的二维晶格不是周期性边界条件而是开放边界条件。除此之外，边界处会存在有两体算符。拥有一个逻辑比特并且基态简并度为2.举个例子：在这个晶格里面，竖着的这条粗线是逻辑X，横着的是逻辑Z。（也可以这样想，如果横着的是X，会发现这条线的端点这里，X邻居是Z，那么单个XZ不commute，他和vertex operator并不会commute）
- XZZX code
1. 如何产生
左侧图片是rotated surface code，如果将其中绿色的Pauli- operator通过Hardmard rotation，就可以得到右侧的XZZX code。

$ hat(U) = product_(i+j="even/odd")1/sqrt(2)(hat(X)_("ij") + hat(Z)_("ij")) $ $ i+j="even", hat(U) hat(W)_("ij")hat(U)^dagger = hat(A)_(i,j) $ $ i+j="odd", hat(U) hat(W)_("ij")hat(U)^dagger = hat(B)_(i,j) $

由于在Pauli noise channel当中，实验测得Pauli-Z error是Pauli-X error的两千倍左右，所以Z-error是最主要的错误来源。(depolarizing noise)
Z-error 测量：发生Z-error的时候，如果错误发生在stabilizer的X- operator位置，那么由于x-z反对易，那么stabilizer测量结果会从1变成-1； 但是由于Z-Z对易，那么stabilizer测量结果不会发生改变。所以传统的code相当于对于这个common error，只有X-stabilizers可以用来detect，但是对于修改后的code，每个stabilizer都是一样的并且都包含有Pauli-X operator，所以他们都可以detect error。除此之外他们有着decreased dimensionality of decoding problem等，and更好的threshold。。。


- 文章介绍：
这篇文章主要目的就是通过floquet驱动，实现2D lattice上面对于刚刚所说的XZZX code的构建。由于在驱动哈密顿量的作用下，所得到的有效哈密顿量包含很多算符项，所以能够实现干净的four-spin interactions就显得十分重要. 由于驱动哈密顿量含时，所以我们通过trotterization来逼近驱动哈密顿量来进行模拟。在2D lattice上面实现Toric code能够对self- correction机制有很大的贡献，具体关于self-correction的内容我们放在后面进行介绍。

1. 首先是关于模型本身的介绍。可以看这张图片，图上一共有6*6个plaquettes，physical qubits是位于整个lattice的格点上，就是这些蓝色的点点。其中黑色实线和红色曲线都代表了每个plaquette上面qubits之间的hopping interaction（也就是说最近邻晶格量子比特之间的耦合导致量子态的交换机制，在光晶格当中，原子可以通过隧穿效应实现相邻点位的跃迁。）但是在本篇文章当中，这个相互作用是含时的，他们将对整个lattice的演化分成四块进行。每块是周期性驱动的一个周期。其中用红色虚线表示的是即将要演化的部分，每驱动一部分，这块就会变成紫色，经过4tau的时间，整个lattice就会演化完毕。在这个演化的过程当中，我们可以通过trotterization来逼近这个演化过程。

2. 关于哈密顿量的介绍，其中整个的哈密顿量实际上包括单原子自身的能量，对单个原子的共振驱动以及最近邻原子之间的hopping process，这部分的哈密顿量用产生湮灭算符表示，通过高频项忽略，他们可以map到Pauli matrix上面($sigma^+ = (hat(X)_alpha+i hat(Y)_alpha)\/2$).所以最终驱动H被定做XX
+YY形式。而我们想要实现的四体相互作用的形式为XZZX的形式。所以，我们要设计合适的Floquet drive来实现有效哈密顿量和四体相互作用形式相同的哈密顿量。

我们可以通过Magnus展开来对effective Hamiltonian进行表示。其中发现第三项可以凑出XZZX的格式，所以想让第三项变成leading order的话，需要让一二项都能消失；第一项的话，当驱动系数g是一个正余弦函数的时候，就可以单个周期积分为0，对于第二项，可以通过time-symmetry来消除，（？？）那么就可以获得g的形式了。

通过刚刚的试探也发现了，$"Y2Y3"$是想要的项，那么针对另外两部分的YY耦合项，通过引入$Omega_1X_1 + Omega_4X_4$,在rotating frame当中，如果M很大很大，那么YY耦合就可以被消除掉。所以我们可以通过这种方式来实现我们想要的四体相互作用。

当然，里面的其他存在的两体相互作用肯定不可能完全清除掉，所以整个的有效哈密顿量由所有存在的算符及他们对应权重组成。通过对单个plaquette的数值模拟及优化，获得最优化的驱动形式，最终所获得第相互作用term当中，想要的四体相互作用项占据了主导地位。有效哈密顿量就可以用主要的四体相互作用以及作为干扰项的其他terms组成。

2. 对于Full lattice的simulation介绍：
可以把整个lattice分成不交叠的四个部分，然后在每个单位时间tau内逐步进行演化。对于时间演化算符，如果刚刚划分的group之间不commute，那就需要通过下面的公式进行计算，但是我们知道有效哈密顿量包括互相commute的四体项以及其他不commute的误差项，所以刚刚这个长公式就可以用来进行误差的计算。

下面这个图像的横轴对应的刚刚公式里面不同operator的权重，所需要的operators是占据主导地位的，相比undesired terms要高两个数量级。纵轴的weight是指在tensor product当中non-identity的算符数量。

3. Prospect：
首先，我们想要证明这个系统可以用于self- correcting memory，那么文章当中所进行的55晶格模拟不够大，我们希望能够通过更大的系统来验证这个exponential decay，如果能够观察到这个decay，那就说明这个系统满足self-correcting的条件之一了。我们计划通过Pauli- propagation来进行大规模的模拟。



4. 对于self-correction的介绍：
通过Self- correction，我们可以避免多次的active error correcting process，这有利于实现大规模高保真度的quantum simulation。在经典系统当中1D Ising model由于在finite temperature下没有phase transition，domain wall的形成只有固定的energy cost，，但是2D Ising model当中，由于creating
 errors(domains of flipped spins)的energy cost scales with system size，那么在2D Ising model当中，更大的error会exponentially suppressed。
 （Guided by this example, one can take the following conditions as necessary for a classical spin system to be a self-correcting memory: 1. The system has a degenerate ground state; one has to flip a macroscopic number of spins in order to map one ground state to another. 2. A macroscopic energy barrier has to be traversed by any sequence of single-spin flips mapping one ground state to another.Note that if condition 1 is violated, the environment can destroy the encoded information by acting only on a few spins. If condition 2 is violated, there is no reason to expect that an energy dissipation mechanism will prevent single-spin errors from accumulating into a logical error. For example, the 1D Ising model satisfies condition 1 but fails to satisfy condition 2. On the other hand, the 2D Ising model satisfies both conditions since mapping one ground state (all spins up) to the other (all spins down) requires creating a domain wall of macroscopic size.）

#part("Why XZZX model can be used as error-correcting code?",[
  1. 将XZZX code与CSS surface code对比，taking Pauli errors（Pauli-X 比特翻转；Pauli-Z 相位翻转） as example。
  2. 为什么Pauli-Z error会产生两个defects？？
  3. 基于所有singlequbit Pauli channels，XZZX surface code相比之下有更高的threshold。
  #figure(
    image("XXXX-XZZX.png", width: 80%),
    caption: [
       XZZX code
    ],
  )
])

