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

@react.component
let make = () => {
  let steps = CustomizeCommand_Steps.useSteps()
  let store = CustomizeCommand_Store.useStore()

  let updateTmuxUI = (theme: Themes.t) => {
    open Tmux

    let commands = [
      SetGlobal(
        WindowStatusCurrentStyle({
          bg: theme.primary._100,
          fg: theme.background._100,
        }),
      ),
      SetGlobal(WindowStatusStyle({bg: theme.background._200})),
      SetGlobal(StatusBg(theme.background._200)),
      SetGlobal(StatusFg(theme.foreground._200)),
    ]
    
    store.addCommands(commands)

    commands->Array.forEach(command => {
      command->Tmux.exec->ignore
    })
  }

  let handleChange = theme => {
    let selectedTheme = switch theme {
      | #nord => Themes.nord
      | #dracula => Themes.dracula
    }
    updateTmuxUI(selectedTheme)
    store.setTheme(selectedTheme)
    steps.forward()
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}> {"What's your favorite theme?"->s} </StepHeader>
    <Box paddingLeft={1}>
      <ThemesSelect options onChange={handleChange} />
    </Box>
  </Box>
}
