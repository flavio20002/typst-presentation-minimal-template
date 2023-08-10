#import "../template.typ": *

#let logoLight = image("./logo_light.svg")

#show: project.with(
  title: "Minimalist presentation template",
  subtitle: "This is where your presentation begins",
  author: "Flavio Barisi",
  date: "10/08/2023",
  indexTitle: "Contents",
  logo: image("./logo.svg"),
  logoLight: logoLight,
  cover: image("./image_3.jpg")
)

#section("This is a section", logoLight)

== This is a slide title

#lorem(10)

- #lorem(10)
  - #lorem(10)
  - #lorem(10)
  - #lorem(10)

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
    image("image_3.jpg", width: 100%),
    caption: [An image],
  ) <image_label_3>
]
