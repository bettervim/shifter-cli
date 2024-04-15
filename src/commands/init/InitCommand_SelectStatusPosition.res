open Ink
open InkUI

let options = {
  open InkUI.Select
  [
    {
      value: "top",
      label: "Top",
    },
    {
      value: "bottom",
      label: "Bottom",
    },
  ]
}

@react.component
let make = () => {
  let steps = InitCommand_Steps.useSteps()
  let handleChange = _ => steps.forward()

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}>
      {"Would you like your status bar at the "->s}
      <Text color=#green> {"top"->s} </Text>
      {" or "->s}
      <Text color=#green> {"bottom"->s} </Text>
      {" of the screen?"->s}
    </StepHeader>
    <Box paddingLeft={1}>
      <Select options onChange={handleChange} />
    </Box>
  </Box>
}
