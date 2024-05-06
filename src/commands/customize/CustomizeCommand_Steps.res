include StepsCrafter.Make({
  type t = [
    | #SelectTheme
    | #StatusPosition
    | #WindowLayout
    | #StatusLeft
    | #StatusRight
    | #Review
  ]
  let steps = [#SelectTheme, #StatusPosition, #WindowLayout, #StatusLeft, #StatusRight, #Review]
  let initial = #SelectTheme
})
