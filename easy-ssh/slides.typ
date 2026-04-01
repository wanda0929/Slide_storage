#import "@preview/touying:0.6.1": *
#import "lib.typ": *

// Colors
#let warn-color = rgb("#e76f51")
#let ok-color = rgb("#2a9d8f")
#let emph-color = rgb("#1f77b4")

#let warn-text(content) = text(fill: warn-color, weight: "bold", content)
#let ok-text(content) = text(fill: ok-color, weight: "bold", content)
#let emph-text(content) = text(fill: emph-color, weight: "bold", content)

#show: hkustgz-theme.with(
  config-info(
    title: [easy-ssh: Local AI, Remote Execution],
    subtitle: [Develop locally with LLM, run on servers via SSH],
    author: [Yusheng Zhao, Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)

#title-slide()

// ============================================================


= Easy-ssh

== The Problem

#{
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1.2em,
    // Left column — pain
    rect(
      width: 100%,
      fill: warn-color.lighten(90%),
      stroke: 1.5pt + warn-color,
      radius: 8pt,
      inset: 1em,
    )[
      #text(weight: "bold", fill: warn-color, size: 1.05em)[#emoji.warning Setting up LLM on a server]
      #v(0.4em)
      #set text(size: 0.85em)
      - API keys, network proxies, firewalls
      - Different OS / package managers
      - Every server needs its own config
      - Debugging setup wastes hours
    ],
    // Right column — need
    rect(
      width: 100%,
      fill: ok-color.lighten(90%),
      stroke: 1.5pt + ok-color,
      radius: 8pt,
      inset: 1em,
    )[
      #text(weight: "bold", fill: ok-color, size: 1.05em)[#emoji.sparkles But the server has]
      #v(0.0em)
      #set text(size: 0.95em)
      - GPU

      - Larger RAM

      - Faster CPU
    ],
  )
}

#v(1em)

#{
  set align(center)
  rect(
    fill: warn-color.lighten(92%),
    stroke: 1.2pt + warn-color,
    radius: 6pt,
    inset: (x: 1.5em, y: 0.7em),
  )[
    #text(size: 1.1em, fill: warn-color, weight: "bold")[
      Can we keep the LLM on the laptop and send only the _work_ to the server?
    ]
  ]
}

// ============================================================

== The Solution: easy-ssh

A #emph-text[single Bash script] - no installation needed on the server. Just SSH access.

#v(0.5em)

#{
  set align(center)

  let node-box(title, icon, items, fill-color, stroke-color) = rect(
    width: 10.5em,
    fill: fill-color.lighten(85%),
    stroke: 1.8pt + stroke-color,
    radius: 8pt,
    inset: (x: 0.9em, y: 0.7em),
  )[
    #set align(left)
    #text(weight: "bold", size: 0.9em, fill: stroke-color)[#icon #h(0.3em) #title]
    #v(0.35em)
    #set text(size: 0.8em)
    #for item in items [
      #text(fill: stroke-color, weight: "bold")[‣] #item \
    ]
  ]

  let styled-arrow(direction) = {
    let head-size = 6pt
    let arrow-head(dir) = box(
      baseline: 50% - 0.5pt,
      if dir == "right" {
        polygon(fill: ok-color, (0pt, 0pt), (head-size * 1.2, head-size), (0pt, head-size * 2))
      } else {
        polygon(fill: ok-color, (head-size * 1.2, 0pt), (0pt, head-size), (head-size * 1.2, head-size * 2))
      },
    )
    box(width: 6em, {
      set align(horizon)
      if direction == "right" {
        box(width: 1fr, line(length: 100%, stroke: 1.8pt + ok-color))
        arrow-head("right")
      } else {
        arrow-head("left")
        box(width: 1fr, line(length: 100%, stroke: 1.8pt + ok-color))
      }
    })
  }

  let arrow-block = {
    set align(center)
    set text(size: 0.78em)
    stack(
      dir: ttb,
      spacing: 0.2em,
      rect(fill: ok-color.lighten(88%), stroke: 0.8pt + ok-color, radius: 4pt, inset: (x: 0.6em, y: 0.3em))[
        #text(weight: "bold", fill: ok-color, size: 1.1em)[SSH + rsync]
      ],
      v(0.5em),
      text(size: 1.1em)[push code, run command],
      styled-arrow("right"  ),
      v(0.3em),
      styled-arrow("left"),
      text(size: 1.1em)[pull results],
    )
  }

  grid(
    columns: (auto, 10em, auto),
    align: horizon,
    node-box("Your Laptop", emoji.laptop, ("Claude Code", "Codex", "Any LLM"), emph-color, emph-color),
    arrow-block,
    node-box("Server (a800)", emoji.computer, ("GPU", "Big RAM", "Your data"), warn-color, warn-color),
  )
}

#v(0.5em)

#{
  set align(center)
  text(size: 1.1em, weight: "bold")[
    edit locally #sym.arrow.r push #sym.arrow.r run remotely #sym.arrow.r pull results #sym.arrow.r repeat
  ]
}

// ============================================================

== Install - Let Your LLM Do It
#v(0.8em)
You already have an LLM coding agent (Claude Code, Codex, etc.). #emph-text[Use it.]



#{
  set align(center)
  block(fill: rgb("#f4f4f4"), inset: 1.2em, radius: 6pt, width: 85%)[
    #set align(left)
    #text(size: 1.05em, style: "italic")[
      "Read the README at `github.com/exAClior/easy-ssh` and follow the
      instructions to install the CLI and the skill globally on my machine."
    ]
  ]
}

#v(0.8em)

The LLM will handle:

- Checking prerequisites (`ssh`, `rsync`, `bash`)
- Setting up passwordless SSH if needed
- Cloning the repo and adding cli to `PATH`
- Running `easy-ssh init` in your project

// ============================================================

== Live Demo - Julia Quantum Simulation on a800
#v(0.8em)
A real run: pulse simulation for three qubit gate (PulseODE.jl).
#v(0.3em)


```bash
# Project already configured
cat .easy-ssh.conf
# host='a800'
# remote_dir='/home/yushengzhao/PulseODE.jl'

# One command: sync local code → run on server → see output
easy-ssh run "julia --project=. test/simulation.jl"

# Pull generated figures back to laptop
easy-ssh pull data/
```

#v(0.5em)
== Live Demo - What happened

#{
  let step-box(num, icon, label, detail, color) = rect(
    width: 100%,
    fill: color.lighten(90%),
    stroke: 1.2pt + color,
    radius: 6pt,
    inset: (x: 0.7em, y: 0.4em),
  )[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 0.5em,
      align: horizon,
      text(weight: "bold", fill: color, size: 1.4em)[#icon],
      [
        #text(weight: "bold", fill: color, size: 0.85em)[Step #num: #label] #h(0.5em)
        #text(size: 0.75em)[#detail]
      ],
    )
  ]

  let arrow-sep = {
    set align(center)
    text(fill: ok-color, weight: "bold", size: 1em)[#sym.arrow.b]
  }

  stack(
    dir: ttb,
    spacing: 0.15em,
    step-box("1", emoji.package, "push", [rsync synced project files to `a800:/home/yushengzhao/PulseODE.jl/`], emph-color),
    arrow-sep,
    step-box("2", emoji.gear, "run", [Julia executed `simulation.jl` — three-qubit gate pulse simulation on server], ok-color),
    arrow-sep,
    step-box("3", emoji.folder, "pull", [Fetched simulation results + figures back to laptop], warn-color),
  )
}

#v(0.4em)

#{
  set align(center)
  rect(fill: ok-color.lighten(90%), stroke: 1pt + ok-color, radius: 6pt, inset: (x: 1.2em, y: 0.4em))[
    #text(weight: "bold", fill: ok-color)[Result:] #h(0.5em)
    Simulation data + plots in `data/` — ready for your paper.
  ]
}

// ============================================================

== Summary

#{
  let card(icon, label, detail, color) = rect(
    width: 100%,
    fill: color.lighten(90%),
    stroke: 1.2pt + color,
    radius: 6pt,
    inset: (x: 0.8em, y: 0.55em),
  )[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 0.6em,
      align: horizon,
      text(size: 1.4em)[#icon],
      [
        #text(weight: "bold", fill: color, size: 0.88em)[#label] #h(0.4em)
        #text(size: 0.82em)[#detail]
      ],
    )
  ]

  grid(
    columns: (1fr, 1fr),
    rows: (auto, auto, auto),
    column-gutter: 0.8em,
    row-gutter: 0.6em,
    card(emoji.page, "What", [A single Bash script for local-AI + remote-execution], emph-color),
    card(emoji.lightbulb, "Why", [Keep LLM on laptop, send work to server — zero server setup], ok-color),
    card(emoji.gear, "How", [`easy-ssh run "cmd"` syncs + runs + shows output], emph-color),
    card(emoji.rocket, "Install", [One `git clone` + add to PATH — done in 30 seconds], ok-color),
    grid.cell(colspan: 2,
      card(emoji.chain, "Server needs", [Just SSH access + rsync (already there)], warn-color),
    ),
  )
}

#v(0.8em)

#{
  set align(center)
  rect(fill: ok-color.lighten(88%), stroke: 1.5pt + ok-color, radius: 8pt, inset: (x: 1.5em, y: 0.7em))[
    #text(weight: "bold")[Get started:] #h(0.8em)
    `git clone git@github.com:exAClior/easy-ssh.git ~/.easy-ssh`
  ]
}

#v(0.8em)

#{
  set align(center)
  text(size: 1.3em, weight: "bold")[Questions?]
}

// ============================================================
// APPENDIX
// ============================================================

= Appendix

== Commands at a Glance

#v(0.3em)

- `easy-ssh init` — Interactive setup, writes `.easy-ssh.conf`

- `easy-ssh push` — Sync local files → server (additive, won’t delete remote files)

- `easy-ssh run "cmd"` — Push + run + #emph-text[wait] for output. Best for quick scripts.

- `easy-ssh submit "cmd"` — Push + launch in background + #emph-text[return immediately]. Job survives disconnect.

- `easy-ssh logs` — Snapshot: last 50 lines of job output

- `easy-ssh monitor` — #emph-text[Live-stream] job output; auto-stops when done

- `easy-ssh status` — Check SSH connection + job state

- `easy-ssh pull path` — Fetch files from server → laptop

- `easy-ssh clean` — Preview / remove remote-only files

// ============================================================

== Config — What NOT to Sync
#v(0.3em)
Create `.easy-ssh-ignore` to skip big files (same syntax as `.gitignore`):

```bash
# .easy-ssh-ignore
__pycache__/
*.pyc
.venv/
data/
*.h5
node_modules/
.git/
```

#v(0.5em)

#emph-text[Why this matters:]

- Without it, `push` uploads #warn-text[everything] — including GBs of data
- The server probably already has the data at a known path
- Keeps sync fast (seconds, not minutes)

#v(0.5em)

#emph-text[Safety:] easy-ssh refuses to sync if your directory is > 500 MB.
Add ignore patterns or use `--force` to override.

// ============================================================

== Bonus — Claude Code Integration

Give Claude Code the ability to use easy-ssh on your behalf:

```bash
npx skills add exAClior/easy-ssh --skill easy-ssh
```

#v(0.5em)

Now you can say things in natural language:

#v(0.3em)

#{
  block(fill: rgb("#f4f4f4"), inset: 1em, radius: 6pt, width: 100%)[
    _"Run train.py on the server"_ \
    _"Submit a training job with 50 epochs"_ \
    _"Pull the results from the server"_ \
    _"Check if my job is still running"_
  ]
}

#v(0.5em)

Claude Code handles `push`, `run`, `submit`, `pull`, `monitor`, `status`, and `logs` automatically.
