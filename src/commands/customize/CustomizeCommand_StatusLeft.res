open Ink

module StatusLeftSelect = Select.Make({
  type t = [
    | #"session-name"
    | #"number-and-session-name"
    | #hidden
  ]
})

let options = {
  open StatusLeftSelect

  [
    {
      label: "Session Name",
      value: #"session-name",
    },
    {
      label: "Number & Session Name",
      value: #"number-and-session-name",
    },
{
      label: "Hidden (None)",
      value: #hidden,
    },

  ]
}

@react.component
let make = () => {
  let steps = CustomizeCommand_Steps.useSteps()
  let store = CustomizeCommands_Store.useStore()
  let handleChange = value => {
    open Tmux

    let command = switch value {
    | #"session-name" => SetGlobal(StatusLeft(" #S "))
    | #"number-and-session-name" => SetGlobal(StatusLeft(" #I #S "))
    | #hidden => SetGlobal(StatusLeft(""))
    }

    Tmux.exec(command)
    store.addCommands([command])
    
    steps.forward()
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"Select modules to display on the left side of the bar"->s} </StepHeader>
    <Box paddingLeft={1}>
      <StatusLeftSelect options onChange={handleChange} />
    </Box>
  </Box>
}
