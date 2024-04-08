@module("ink")
external render: (React.element) => unit = "render"

module Text = {
  type color = [#green | #red]
  type props = {color?:color , children?: React.element}

  @module("ink")
  external make: React.component<props> = "Text"
}
