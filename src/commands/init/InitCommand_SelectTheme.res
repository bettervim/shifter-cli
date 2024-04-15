open Ink

let options = {
  open InkUI.Select

  [
    {
      label: "Nord",
      value: "nord",
    },
    {
      label: "Dracula",
      value: "dracula",
    },
    {
      label: "Catppuccin",
      value: "catppuccin",
    },
  ]
}

@react.component
let make = () => {
  open InkUI
  let steps = InitCommand_Steps.useSteps()
  let handleChange = _ => steps.forward()

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"Select a theme"->s} </StepHeader>
    <Box paddingLeft={1}>
      <Select options onChange={handleChange} />
    </Box>
  </Box>
}
