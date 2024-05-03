include StepsCrafter.Make({
  type t = [
    | #SelectTheme
    | #StatusPosition
    | #WindowLayout
    | #StatusLeft
    | #StatusRight
    | #Terminate
  ]
  let steps = [#SelectTheme, #StatusPosition, #WindowLayout, #StatusLeft, #StatusRight, #Terminate]
  let initial = #SelectTheme
})
