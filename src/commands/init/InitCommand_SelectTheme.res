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
  let handleChange = _ => {
    open Tmux

    let commands = [
      SetGlobal(WindowStatusSeparator("")),
      SetGlobal(WindowStatusCurrentFormat(" #W ")),
      SetGlobal(
        WindowStatusCurrentStyle(
          `bg=${Themes.nord.primary._100}, fg=${Themes.nord.background._100}`,
        ),
      ),
      SetGlobal(WindowStatusStyle(`bg=#{Themes.nord.background._200}`)),
      SetGlobal(StatusBg(Themes.nord.background._200)),
      SetGlobal(StatusFg(Themes.nord.foreground._200)),
      SetGlobal(StatusLeftLength("300")),
      SetGlobal(StatusLeftContent(" #S ")),
    ]

    commands->Array.forEach(command => {
      command->Tmux.command->Tmux.exec->ignore
    })
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"Select a theme"->s} </StepHeader>
    <Box paddingLeft={1}>
      <Select options onChange={handleChange} />
    </Box>
  </Box>
}
