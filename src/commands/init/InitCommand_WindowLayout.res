open Ink

module WindowLayoutSelect = Select.Make({
  type t = [
    | #compact
    | #"number-and-window"
  ]
})

let options = {
  open WindowLayoutSelect
  [
    {
      label: "Compact",
      value: #compact,
    },
  ]
}

@react.component
let make = () => {
  let steps = InitCommand_Steps.useSteps()
  let handleSelect = value => {
    switch value {
    | #compact => {
        let layout = " #W "
        Tmux.exec(SetGlobal(WindowStatusFormat(layout)))
        Tmux.exec(SetGlobal(WindowStatusCurrentFormat(layout)))
      }
    }
  }
  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}>
      {"How do you want your window layout?"->s}
    </StepHeader>
    <WindowLayoutSelect options onChange={handleSelect} />
  </Box>
}
