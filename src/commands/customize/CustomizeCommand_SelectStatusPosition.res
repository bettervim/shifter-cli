open Ink

module StatusPositionSelect = Select.Make({
  type t = Tmux.statusPosition
})

let options = {
  open StatusPositionSelect
  [
    {
      label: "Top",
      value: #top,
    },
    {
      label: "Bottom",
      value: #bottom,
    },
  ]
}

@react.component
let make = () => {
  let steps = CustomizeCommand_Steps.useSteps()
  let store = CustomizeCommand_Store.useStore()

  let handleChange = position => {
    let command = {
      open Tmux
      SetGlobal(StatusPosition(position))
    }

    Tmux.exec(command)
    store.addCommands([command])
    steps.forward()
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}>
      {"Would you like your status bar at the "->s}
      <Text color=#green> {"top"->s} </Text>
      {" or "->s}
      <Text color=#green> {"bottom"->s} </Text>
      {" of the screen?"->s}
    </StepHeader>
    <Box paddingLeft={1}>
      <StatusPositionSelect options onChange={handleChange} />
    </Box>
  </Box>
}
