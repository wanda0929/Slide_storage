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
    title: [Fast measurements and multiqubit gates in dual species atomic arrays],
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
== Target
- Fast syndrome measurement in an array of Rb and Cs atoms. 

- Method: entangling one Cs ancella with Rb qubits with $"CNOT"_k$.

- Measurement process: Fast, high-fidelity, lossless.
== Model

#figure(
  image("measurementparity.png",width: 55%)
)
- Mapping of ancella to measurement qubits.
#figure(
  image("map.png",width: 55%)
)

== Two-level system
#figure(
  image("pulse1.png",width: 55%)
)


== Reference
#bibliography("ref.bib")

