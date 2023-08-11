#let scriptsize = 15pt
#let normalsize = 25pt
#let largesize = 30pt
#let verylargesize = 38pt
#let hugesize = 48pt

#let logo_light_image = state("logo_light_image", none)

#let columns-content(..args) = {
  let slide-info = args.named()
  let bodies = args.pos()
  let colwidths = none
  let thisgutter = 1cm
  if "colwidths" in slide-info{
  colwidths = slide-info.colwidths
  if colwidths.len() != bodies.len(){
    panic("Provided colwidths must be of same length as bodies")
  }
  }
  else{
    colwidths = (1fr,) * bodies.len()
  }
  if "gutter" in slide-info{
    thisgutter = slide-info.gutter
  }
  grid(
    columns: colwidths,
    gutter: thisgutter,
    ..bodies
  )
}


#let project(
  title: [Title],
  subtitle: [Subtitle],
  author: none,
  date: none,
  aspect-ratio: "16-9",
  mainColor: rgb("#E30512"),
  textColorLight: white,
  textColorDark: black,
  cover: none, 
  logo: none,
  logoLight: none,
  indexTitle: none,
  body
) = {
  set document(title: title, author: author)
  set text(font: "Lato", fill: textColorDark, size: 20pt, lang: "it")
  set underline(offset: 3pt)
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0pt,
  )

  set list(tight:true, indent: 0.27cm ,body-indent: 0.7cm, marker: (place(center, dy: -0.5em, text(size: 2em, fill: mainColor, "▶")), place(center, dy: -0.2em, text(size: 1.3em, fill: mainColor, "■"))))

  show math.equation: set text(font: "Fira Math")
  show raw: set text(font: "Fira Code")

  set figure(gap: 20pt)
  show figure: it => [
    #set text(size: scriptsize)
    #it
  ]

  let pageNumberInt() = {
    let lastpage-number = locate(pos => counter(page).final(pos).at(0))
    set align(right)
    text(size: scriptsize)[
      #counter(page).display("1 / 1", both: true)
    ]
  }

  let pageNumber() = {
     place(bottom + right)[
      #pad(bottom: 0.5cm, right: 0.5cm)[
        #let lastpage-number = locate(pos => counter(page).final(pos).at(0))
        #set align(right)
        #text(size: scriptsize)[
          #counter(page).display("1 / 1", both: true)
        ]
      ]
    ]
  }

  let slidePolygon() = {
    place(top+left, polygon(
        fill: mainColor,
        (1cm, 0%),
        (1cm, 100%),
        (1.6cm, 100%),
        (1.6cm,  0%),
    ))
  }

  let slideLogo(theLogo) = {
    if theLogo!= none {
    place(top + right, dx: -0.5cm, dy: 0.5cm)[
      #set image(width: 2.5cm)
        #theLogo
      ]
    }
  }

  // Display the title page.
  page(margin: 0pt)[
    #set text(fill: textColorLight)
    #if (cover != none){
      place()[
        #set image(width: 100%, height: 100% + 1pt)
        #cover
        ]
    }
    #logo_light_image.update(x =>
      logoLight
    )
    #place(block(fill: rgb("000000AA"), width: 100%, height: 100% + 1pt))
    #place(
      polygon(
      fill: mainColor,
      (100%, 0%),
      (55%, 0%),
      (80%, 100%),
      (100%,  100%),
    ))

    #slideLogo(logoLight)
    #pad(left: 2.6cm, right: 10cm, y: 1.5cm)[
      #v(1fr)
      #block(width: 15cm)[ #par(leading: 1cm)[
          #text(size: hugesize, weight: "black", upper(title))
      ]]
      #v(0.5cm)      
      #text(size: normalsize, weight: "black", subtitle)
      #v(1fr)
      #if author != none {
          text(size: scriptsize)[#author]
      } --
      #if date != none {
          text(size: scriptsize)[#date]
      }
    ]
  ]

  set page(
    background: locate(loc => {
    let next-headings = query(heading.where(level: 1).before(loc), loc)
    if next-headings != () and next-headings.first().location().page() == loc.page() {
      rect(width: 100%, height: 100%, fill: mainColor)
      place(top,
        polygon(
        fill: white,
        (90%, 20%),
        (90% - 1.2cm, 20%),
        (90% - 1.2cm, 90%),
        (90% - 1.2cm, 20%),
        (90% - 1.2cm, 90% - 1.2cm),
        (90% - 9cm,  90% - 1.2cm),
        (90% - 9cm,  90%),
        (90%, 90%),
        (90%, 20%)
      ))

      locate(loc => {
          let logoLight = logo_light_image.at(loc)
          place(top + right, dx: -0.5cm, dy: 0.5cm)[
            #set image(width: 2.5cm)
            #logoLight
          ]
      })

      place(bottom + right)[
          #pad(bottom: 0.5cm, right: 0.5cm)[
            #let lastpage-number = locate(pos => counter(page).final(pos).at(0))
            #set align(right)
            #text(fill: white, size: scriptsize)[
              #counter(page).display("1 / 1", both: true)
            ]
          ]
      ]
    }
    else{
      [
        #slideLogo(logo)
        #slidePolygon()
        #pageNumber()
      ]
    }
    }),
    margin: (top:1cm, bottom: 1.5cm, left: 2.6cm, right: 1cm)
  )

  set align(horizon)

  // Display the summary page.
  align(top)[#text(size: verylargesize, weight: "black", indexTitle)]
  locate(loc => {
      let elems = query(selector(heading.where(level: 1)).after(loc), loc)
      list(..elems.map(elem => {link(elem.location(),elem.body)}))
  })

  show link: it => [
    #set text(fill: mainColor)
    #underline(it)
  ]

  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set text(hugesize, fill: white, weight: "black")
    #move(dy: 0.25cm, it.body)
  ]

  show heading.where(level: 2): it => {
    pagebreak()
    set text(verylargesize, weight: "black")
    align(top, it.body)
    v(0.5cm)
  }

  // Add the body.
  body
}