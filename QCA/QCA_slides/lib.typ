// HKUST GZ theme for touying 0.7.0
// Ported from the touying 0.4.2 hkustgz-theme

#import "@preview/touying:0.7.0": *

// ── Slide types ──────────────────────────────────────────────

/// Default content slide
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  // header
  let header(self) = {
    set align(top)
    // Navigation bar
    grid(
      rows: (auto, auto),
      {
        // dark nav bar with section links
        set text(size: 0.5em)
        grid(
          align: center + horizon,
          columns: (1fr, auto),
          rows: 1.8em,
          components.cell(
            fill: self.colors.neutral-darkest,
            {
              context {
                let current = utils.slide-counter.get().first()
                let headings = query(heading.where(level: 1))
                for (i, h) in headings.enumerate() {
                  let loc = h.location()
                  let is-current = {
                    let next-loc = if i + 1 < headings.len() { headings.at(i + 1).location() } else { none }
                    let here-page = current
                    let h-page = counter(page).at(loc).first()
                    let n-page = if next-loc != none { counter(page).at(next-loc).first() } else { calc.inf }
                    h-page <= here-page and here-page < n-page
                  }
                  let color = if is-current { white } else { gray }
                  box(inset: 0.5em, link(loc, text(fill: color, h.body)))
                }
              }
            },
          ),
          block(
            fill: self.colors.neutral-darkest,
            inset: 4pt,
            height: 100%,
            image("assets/vi/hkustgz-logo.svg"),
          ),
        )
      },
      // Title bar
      {
        let title = utils.display-current-heading(level: 2, style: auto)
        context {
          let elems = query(heading.where(level: 2).before(here()))
          if elems.len() > 0 {
            block(
              width: 100%,
              height: 1.8em,
              fill: gradient.linear(self.colors.primary, self.colors.neutral-darkest),
              place(
                left + horizon,
                text(fill: self.colors.neutral-lightest, weight: "bold", size: 1.3em, elems.last().body),
                dx: 1.5em,
              ),
            )
          }
        }
      },
    )
  }
  // footer
  let footer(self) = {
    set text(size: .5em)
    set align(center + bottom)
    grid(
      rows: (auto, auto),
      {
        let cell(fill: none, it) = rect(
          width: 100%,
          height: 100%,
          inset: 1mm,
          outset: 0mm,
          fill: fill,
          stroke: none,
          align(horizon, text(fill: self.colors.neutral-lightest, it)),
        )
        grid(
          columns: (25%, 25%, 1fr, 5em),
          rows: (1.5em, auto),
          cell(fill: self.colors.neutral-darkest, self.info.author),
          cell(fill: self.colors.neutral-darkest, utils.display-info-date(self)),
          cell(
            fill: self.colors.primary,
            if self.info.short-title == auto { self.info.title } else { self.info.short-title },
          ),
          cell(
            fill: self.colors.primary,
            context utils.slide-counter.display() + " / " + utils.last-slide-number,
          ),
        )
      },
      // progress bar
      if self.store.progress-bar {
        components.progress-bar(height: 2pt, self.colors.primary, self.colors.neutral-lightest)
      },
    )
  }
  let self = utils.merge-dicts(
    self,
    config-page(header: header, footer: footer),
  )
  let new-setting = body => {
    show: align.with(horizon)
    show: setting
    body
  }
  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})

/// Title slide
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config)
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info { info.authors } else { info.author }
    if type(authors) == array { authors } else { (authors,) }
  }
  let body = {
    if info.logo != none {
      align(right, info.logo)
    }
    show: align.with(center + horizon)
    block(
      fill: self.colors.primary,
      inset: 1.5em,
      radius: 0.5em,
      breakable: false,
      {
        text(size: 1.2em, fill: self.colors.neutral-lightest, weight: "bold", info.title)
        if info.subtitle != none {
          parbreak()
          text(size: 1.0em, fill: self.colors.neutral-lightest, weight: "bold", info.subtitle)
        }
      },
    )
    grid(
      columns: (1fr,) * calc.min(info.authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
      ..info.authors.map(author => text(fill: black, author)),
    )
    v(0.5em)
    if info.institution != none {
      parbreak()
      text(size: 0.7em, info.institution)
    }
    if info.date != none {
      parbreak()
      text(size: 1.0em, utils.display-info-date(self))
    }
  }
  touying-slide(self: self, body)
})

/// New section slide (minimal – just shows the section title)
#let new-section-slide(config: (:), level: 1, numbered: true, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config)
  let slide-body = {
    set align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em, fill: self.colors.primary, weight: "bold")
    utils.display-current-heading(level: level, numbered: numbered)
    body
  }
  touying-slide(self: self, slide-body)
})

/// Ending slide
#let ending-slide(config: (:), title: none, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-common(freeze-slide-counter: true), config)
  let content = {
    set align(center + horizon)
    if title != none {
      block(
        fill: self.colors.tertiary,
        inset: (top: 0.7em, bottom: 0.7em, left: 3em, right: 3em),
        radius: 0.5em,
        text(size: 1.5em, fill: self.colors.neutral-lightest, title),
      )
    }
    body
  }
  touying-slide(self: self, content)
})

// ── Theme entry point ────────────────────────────────────────

/// HKUST(GZ) presentation theme.
///
/// Usage:
/// ```typst
/// #show: hkustgz-theme.with(
///   aspect-ratio: "16-9",
///   config-info(title: [...], author: [...], ...),
/// )
/// ```
#let hkustgz-theme(
  aspect-ratio: "16-9",
  progress-bar: true,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 4.5em, bottom: 3.5em, x: 2.5em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 19pt)
        set heading(outlined: false)
        // custom list marker
        set list(
          marker: box(
            width: 0.5em,
            place(
              dy: 0.1em,
              circle(
                fill: gradient.radial(
                  rgb("#005bac").lighten(100%),
                  rgb("#005bac").darken(40%),
                  focal-center: (30%, 30%),
                ),
                radius: 0.25em,
              ),
            ),
          ),
        )
        show strong: it => text(weight: "bold", it)
        show figure.caption: set text(size: 0.6em)
        show footnote.entry: set text(size: 0.6em)
        show link: it => if type(it.dest) == str {
          set text(fill: rgb("#005bac"))
          it
        } else {
          it
        }
        show figure.where(kind: table): set figure.caption(position: top)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: rgb("#005bac"),
      primary-dark: rgb("#004078"),
      secondary: rgb("#ffffff"),
      tertiary: rgb("#005bac"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    config-store(
      progress-bar: progress-bar,
    ),
    ..args,
  )
  body
}

// ── Utility: tblock (titled block) ──────────────────────────

/// A titled content block with HKUST GZ styling.
///
/// ```typst
/// #tblock(title: [My Title])[Content here]
/// ```
#let tblock(title: none, it) = {
  grid(
    columns: 1,
    row-gutter: 0pt,
    block(
      fill: rgb("#004078"),
      width: 100%,
      radius: (top: 6pt),
      inset: (top: 0.4em, bottom: 0.3em, left: 0.5em, right: 0.5em),
      text(fill: white, weight: "bold", title),
    ),
    rect(
      fill: gradient.linear(rgb("#004078"), rgb("#005bac").lighten(90%), angle: 90deg),
      width: 100%,
      height: 4pt,
    ),
    block(
      fill: rgb("#005bac").lighten(90%),
      width: 100%,
      radius: (bottom: 6pt),
      inset: (top: 0.4em, bottom: 0.5em, left: 0.5em, right: 0.5em),
      it,
    ),
  )
}
