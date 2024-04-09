@module("ink")
external render: React.element => unit = "render"

module Style = {
  type color = [#green | #red]
  type borderStyle = [
    | #single
    | #double
    | #round
    | #bold
    | #singleDouble
    | #doubleSingle
    | #classic
    | #arrow
  ]
  type styles = {color?: color, borderStyle?: borderStyle}
}

module Box = {
  type props = {...Style.styles, children?: React.element}

  @module("ink")
  external make: React.component<props> = "Box"
}

module Text = {
  type props = {...Style.styles, children?: React.element}

  @module("ink")
  external make: React.component<props> = "Text"
}
