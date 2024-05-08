open Ink

module StatusModules = CustomizeCommand_StatusModules

@react.component
let make = () => {
  let steps = CustomizeCommand_Steps.useSteps()

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}>
      {"Select modules to display on the right side of the bar"->s}
    </StepHeader>
    <Box paddingLeft={1}>
      <StatusModules.StatusOptionsSelect mode=#right />
    </Box>
  </Box>
}
