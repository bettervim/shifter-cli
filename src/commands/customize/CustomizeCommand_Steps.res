include StepsCrafter.Make({
  type t = [
    | #SelectTheme
    | #WindowLayout
    | #StatusPosition
    | #StatusJustify
    | #StatusLeft
    | #StatusRight
    | #Review
  ]
  let steps = [
    #SelectTheme,
    #WindowLayout,
    #StatusPosition,
    #StatusLeft,
    #StatusRight,
    #StatusJustify,
    #Review,
  ]
  let initial = #SelectTheme
})
