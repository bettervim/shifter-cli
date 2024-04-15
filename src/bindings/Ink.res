@module("ink")
external render: React.element => unit = "render"

module Style = {
  type color = [#green | #red]
  type display = [#flex | #none]
  type flexDirection = [#column | #"column-reverse" | #row | #"row-reverse"]
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
  type styles = {
    display?: display,
    flexDirection?: flexDirection,
    gap?: int,
    paddingLeft?: int,
    marginTop?: int,
    color?: color,
    borderStyle?: borderStyle,
  }
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
