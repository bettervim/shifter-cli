include StepsCrafter.Make({
  type t = [
    | #SelectTheme
    | #StatusPosition
    | #WindowLayout
    | #StatusLeft
    | #StatusRight
    | #Review
    | #Terminate
  ]
  let steps = [#SelectTheme, #StatusPosition, #WindowLayout, #StatusLeft, #StatusRight, #Review, #Terminate]
  let initial = #SelectTheme
})
