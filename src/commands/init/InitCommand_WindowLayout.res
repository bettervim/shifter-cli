open Ink

module WindowLayoutSelect = Select.Make({
  type t = [
    | #name
    | #number
    | #"number-and-name"
  ]
})

let options = {
  open WindowLayoutSelect
  [
    {
      label: "Name",
      value: #name,
    },
    {
      label: "Number",
      value: #number,
    },
    {
      label: "Number & Name",
      value: #"number-and-name",
    },
  ]
}

module WindowLayout = {
  let name = " #W "
  let number = " #I "
  let numberAndName = (~separator=": ") => " #I" ++ separator ++ "#W "
}

let setWindowFormat = layout => {
  Tmux.exec(SetGlobal(WindowStatusFormat(layout)))
  Tmux.exec(SetGlobal(WindowStatusCurrentFormat(layout)))
}

module CustomSeparator = {
  @react.component
  let make = () => {
    let steps = InitCommand_Steps.useSteps()
    let (value, setValue) = React.useState(_ => ": ")

    ReactUse.useDebounce(() => {
      WindowLayout.numberAndName(~separator=value)->setWindowFormat
    }, 200, [value])->ignore

    <Box display=#flex flexDirection=#column>
      <Text> {"💡 Define a separator, you can use any char, including emojis."->s} </Text>
      <InkUI.TextInput placeholder="Default is : " onChange={v => setValue(_ => v)} onSubmit={() => steps.forward()} />
    </Box>
  }
}

@react.component
let make = () => {
  let steps = InitCommand_Steps.useSteps()
  let (selected, setSelected) = React.useState(_ => None)
  let handleSelect = (value: WindowLayoutSelect.t) => {
    let layout = switch value {
    | #name => WindowLayout.name
    | #number => WindowLayout.number
    | #"number-and-name" => WindowLayout.numberAndName()
    }

    setWindowFormat(layout)
    setSelected(_ => Some(value))
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}>
      {"How do you want your window layout?"->s}
    </StepHeader>
    {switch selected {
    | None => <WindowLayoutSelect options onChange={handleSelect} />
    | Some(#"number-and-name") => <CustomSeparator />
    | Some(_) => React.null
    }}
  </Box>
}
