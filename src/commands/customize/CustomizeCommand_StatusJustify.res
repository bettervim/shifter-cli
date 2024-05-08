open Ink

module PositionsSelect = Select.Make({
  type t = [#centre | #left | #right ]
})

let options = {
  open PositionsSelect

  [
    {
      label: "Center",
      value: #centre
    },
    {
      label: "Left",
      value: #left
    },
    {
      label: "Right",
      value: #right
    }
  ]
}

@react.component
let make = () => {
  let steps = CustomizeCommand_Steps.useSteps()
  let store = CustomizeCommand_Store.useStore()

  let handleChange = (value) => {
    let command = Tmux.SetGlobal(Tmux.StatusJustify(value))
    store.addCommands([command])
    Tmux.exec(command)
    steps.forward()
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"Choose the position for your tabs"->s} </StepHeader>
    <Box paddingLeft={1}>
    <PositionsSelect options onChange={handleChange} />
    </Box>
  </Box>
}
