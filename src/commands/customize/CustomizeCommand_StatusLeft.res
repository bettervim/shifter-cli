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
  let handleChange = value => {
    switch value {
    | #"session-name" => SetGlobal(StatusLeft(" #S "))->Tmux.exec
    | #"number-and-session-name" => SetGlobal(StatusLeft(" #I #S "))->Tmux.exec
    | #hidden => SetGlobal(StatusLeft(""))->Tmux.exec
    | _ => ()
    }
    
    steps.forward()
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"How do you want your status-left?"->s} </StepHeader>
    <Box paddingLeft={1}>
      <StatusLeftSelect options onChange={handleChange} />
    </Box>
  </Box>
}
