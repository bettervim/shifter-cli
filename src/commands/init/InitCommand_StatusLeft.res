open Ink

module StatusLeftSelect = Select.Make({
  type t = [
    | #"session-name"
    | #"number-and-session-name"
    | #custom
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
      label: "Custom (next step)",
      value: #"custom",
    },
  ]
}


@react.component
let make = () => {
  open InkUI

  let steps = InitCommand_Steps.useSteps()
  let handleChange = _ =>  {
    Console.log("...")
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"How do you want your status-left?"->s} </StepHeader>
    <Box paddingLeft={1}>
      <StatusLeftSelect options onChange={handleChange} />
    </Box>
  </Box>
}
