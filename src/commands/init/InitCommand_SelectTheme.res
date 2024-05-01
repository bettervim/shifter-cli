open Ink

module ThemesSelect = Select.Make({
  type t = [
    | #nord
    | #dracula
  ]
})

let options = {
  open ThemesSelect

  [
    {
      label: "Nord",
      value: #nord,
    },
    {
      label: "Dracula",
      value: #dracula,
    },
  ]
}

let setTheme = () => {
  open Tmux

   let commands = [
      SetGlobal(
        WindowStatusCurrentStyle({
          bg: Themes.nord.primary._100, 
          fg: Themes.nord.background._100,
        }),
      ),
      SetGlobal(WindowStatusStyle({ bg: Themes.nord.background._200 })),
      SetGlobal(StatusBg(Themes.nord.background._200)),
      SetGlobal(StatusFg(Themes.nord.foreground._200)),
    ]

    commands->Array.forEach(command => {
      command->Tmux.exec->ignore
    })
}

@react.component
let make = () => {
  let steps = InitCommand_Steps.useSteps()
  let handleChange = _ =>  {
    setTheme()
    steps.forward()
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"Select a theme"->s} </StepHeader>
    <Box paddingLeft={1}>
      <ThemesSelect options onChange={handleChange} />
    </Box>
  </Box>
}
