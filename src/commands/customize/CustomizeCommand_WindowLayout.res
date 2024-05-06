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

let useSetWindowFormat = () => {
  let store = CustomizeCommand_Store.useStore()
  let setWindowFormat = layout => {
    open Tmux
    let styles = Tmux.Styles.inline({bold: true})
    let layout = `${styles}${layout}`
    let statusCommand = SetGlobal(WindowStatusFormat(layout))
    let statusCurrentCommand = SetGlobal(WindowStatusCurrentFormat(layout))

    store.addCommands([statusCommand, statusCurrentCommand])
    Tmux.exec(statusCommand)
    Tmux.exec(statusCurrentCommand)
  }

  setWindowFormat
}

module CustomSeparator = {
  @react.component
  let make = () => {
    let steps = CustomizeCommand_Steps.useSteps()
    let (value, setValue) = React.useState(_ => ": ")
    let setWindowFormat = useSetWindowFormat()

    ReactUse.useDebounce(() => {
      WindowLayout.numberAndName(~separator=value)->setWindowFormat
    }, 200, [value])->ignore

    <Box display=#flex flexDirection=#column>
      <Text> {"💡 Define a separator, you can use any char, including emojis."->s} </Text>
      <InkUI.TextInput
        placeholder="Default is : "
        onChange={v => setValue(_ => v)}
        onSubmit={() => steps.forward()}
      />
    </Box>
  }
}

@react.component
let make = () => {
  let steps = CustomizeCommand_Steps.useSteps()
  let (selected, setSelected) = React.useState(_ => None)
  let setWindowFormat = useSetWindowFormat()

  let handleSelect = (value: WindowLayoutSelect.t) => {
    let layout = switch value {
    | #name => WindowLayout.name
    | #number => WindowLayout.number
    | #"number-and-name" => WindowLayout.numberAndName()
    }

    setWindowFormat(layout)

    {
      switch value {
      | #"number-and-name" => setSelected(_ => Some(value))
      | _ => steps.forward()
      }
    }
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"Choose your preferred tab layout"->s} </StepHeader>
    {switch selected {
    | None => <WindowLayoutSelect options onChange={handleSelect} />
    | Some(#"number-and-name") => <CustomSeparator />
    | Some(_) => React.null
    }}
  </Box>
}
