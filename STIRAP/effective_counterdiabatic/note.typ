#import "lib.typ": conf, part
#import "@preview/physica:0.9.4": *

#show: doc => conf(
  title: [Quantum control by effective counterdiabatic driving],
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

#part("Main target",[
  少量子系统基于绝热捷径的设计方案。他们在控制哈密顿量当中引入高频调制来加速绝热动力学。模拟基于时间的反绝热修正。（effective conterdiabatic driving）。

  shortcut to adiabaticity（STA）：和缓慢变化的绝热过程效果相同，但是花费较少时间。因为STA并不是每时每刻都follow驱动哈密顿量的本征态，而是会允许偶然向其他态的漂移。STA的实验实现是比较challenging的，因为需要控制额外的自由度。

  下面的工作是transitionless or counterdiabitic driving。

])

#part("counterdiabatic driving",[
  1. 经过证明，需要加入的$H_"CD"$包含$sigma_y$ operator which is not present in $H_"0"$. 所以直接的实现是有困难的。所以我们需要approximate methods。
  2. 问题：如果CD没办法直接实现，那么我们可以通过已有的控制参数近似，得到一条有用的绝热捷径吗？---通过quantum control theory，表述$-i*H_"CD"(lambda)$对于任意的$lambda$, 属于dynamic Lie algebra of the control systems。也就是说我们可以通过已有的算符来近似实现$H_"CD"$。此时需要一些合适的control functions
  3. 具体method看笔记
  4. 回归本系统的哈密顿量，effective CD hamiltonian为了实现原来CD Hamiltonian的效果，先按照eq7的ansatz来写出驱动方程，然后一阶展开为0，二阶修正占据主导，然后算出对应的H_F，算出来之后让他能够等于H_CD，你什么人就会有A，B参数的一系列constraints。这样就可以获得eCD hamiltonian。由于二阶修正占据主导，所以驱动频率和驱动幅度是关联的。具体的详细分析可以看参考文献。结果是其保真度是提高的。
  
  ])

  #part("Micromotion and driving phase",[
    1. 在 刚刚的近似当中，控制场产生的有效哈密顿量在周期时刻是近似等于H_CD的，但是在中间的时刻，情况会怎样？用micromotion operator K(t)来描述与Floquet hamiltonian产生的偏差。
    2. 通过计算，omega越大，结果会更加匹配
    3. 
    ])

#part("application",[
  1. STIRAP:
  实现无法直接转移的量子态之间的transition。

])