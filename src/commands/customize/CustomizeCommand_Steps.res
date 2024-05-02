include StepsCrafter.Make({
  type t = [
    | #SelectTheme
    | #StatusPosition
    | #StatusLeft
    | #StatusRight
    | #WindowLayout
    | #Terminate
  ]
  let steps = [#SelectTheme, #StatusPosition, #StatusLeft, #StatusRight, #WindowLayout, #Terminate]
  let initial = #SelectTheme
})
