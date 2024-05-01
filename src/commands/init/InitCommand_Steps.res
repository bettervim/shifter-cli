include StepsCrafter.Make({
  type t = [#SelectTheme | #StatusPosition | #StatusLeft | #WindowLayout | #Terminate]
  let steps = [#SelectTheme, #StatusPosition, #StatusLeft, #WindowLayout, #Terminate]
  let initial = #SelectTheme
})
