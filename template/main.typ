#import "../lib.typ": *

//#set text(font: "Lato")
//#show math.equation: set text(font: "Lato Math")
//#show raw: set text(font: "Fira Code")

#let polygon-custom-style = (
  (0.5cm, 2.4cm),
  (0.5cm, 2.7cm),
  (29cm, 2.7cm),
  (28cm, 2.4cm),
)

#show: project.with(
  title: "Minimalist presentation template",
  sub-title: "This is where your presentation begins",
  author: "Flavio Barisi",
  date: "10/08/2023",
  index-title: "Contents",
  slide-polygon-style: "custom", // standard (default), wide_top, wide_bottom, custom
  slide-polygon-style-custom: polygon-custom-style,
  logo: image("./logo.svg"),
  logo-light: image("./logo_light.svg"),
  cover: image("./image_1.jpg"),
  main-color: rgb("#E30512"),
  lang: "en",
)

= This is a section

== This is a slide title

#lorem(10)

- #lorem(10)
  - #lorem(10)
  - #lorem(10)
  - #lorem(10) @harry @electronic.


== One column image

#figure(
  image("image_1.jpg", height: 10.5cm),
  caption: [An image],
) <image_label>

== Two columns image

#columns-content()[
  #figure(
    image("image_1.jpg", width: 100%),
    caption: [An image],
  ) <image_label_1>
][
  #figure(
    image("image_1.jpg", width: 100%),
    caption: [An image],
  ) <image_label_2>
]

== Two columns

#columns-content()[
  - #lorem(10)
  - #lorem(10)
  - #lorem(10)
][
  #figure(
    image("image_1.jpg", width: 100%),
    caption: [An image],
  ) <image_label_3>
]

= This is a section

== This is a slide title

#lorem(10)

= This is a section

== This is a slide title

#lorem(10)

= This is a section

== This is a slide title

#lorem(10)

= This is a very v v v v v v v v v v v v v v v v v v v v  long section

== This is a very v v v v v v v v v v v v v v v v v v v v  long slide title

= Subtitle test

== Slide title

#lorem(50)

=== Slide subtitle 1

#lorem(50)

=== Slide subtitle 2

#lorem(50)

== Slide title 2

#lorem(50)

=== Slide subtitle 3

#lorem(50)

=== Slide subtitle 4

#lorem(50)

#set-main-color(blue)

= You can change color

== Slide title

#lorem(50)

#bibliography("bibliography.yaml")
