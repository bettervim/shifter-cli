open Ink

module ThemesSelect = Select.Make({
  type t = [
    | #nord
    | #dracula
    | #"catppuccin-mocha"
    | #"catppuccin-frappe"
    | #"catppuccin-latte"
    | #"catppuccin-macchiato"
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
    {
      label: "Catppuccin [Mocha]",
      value: #"catppuccin-mocha",
    },
    {
      label: "Catppuccin [Frappe]",
      value: #"catppuccin-frappe",
    },
    {
      label: "Catppuccin [Macchiato]",
      value: #"catppuccin-macchiato",
    },
    {
      label: "Catppuccin [Latte]",
      value: #"catppuccin-latte",
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
          bg: theme.primary,
          fg: theme.background,
        }),
      ),
      SetGlobal(WindowStatusStyle({bg: theme.background})),
      SetGlobal(StatusBg(theme.background)),
      SetGlobal(StatusFg(theme.foreground)),
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
    | #"catppuccin-mocha" => Themes.Catppuccin.mocha
    | #"catppuccin-frappe" => Themes.Catppuccin.frappe
    | #"catppuccin-macchiato" => Themes.Catppuccin.macchiato
    | #"catppuccin-latte" => Themes.Catppuccin.latte
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
