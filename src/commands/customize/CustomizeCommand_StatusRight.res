open Ink

module ModulesSelect = MultiSelect.Make({
  type t = [#clock | #hostname | #date]
})

module Modules = {
  let make = (~icon, ~content, ~theme: Themes.t) => {
    let iconStyles = Tmux.Styles.inline({bg: theme.primary._200, fg: theme.background._200})
    let contentStyles = Tmux.Styles.inline({bg: theme.background._200, fg: theme.foreground._200})
    `${iconStyles} ${icon} ${contentStyles} ${content} `
  }

  let clock = make(~icon=" ", ~content="%H:%M", ...)
  let hostname = make(~icon="", ~content="#H", ...)
  let date = make(~icon="", ~content="%Y", ...)
}

@react.component
let make = () => {
  let store = CustomizeCommand_Store.useStore()
  let steps = CustomizeCommand_Steps.useSteps()
  
  let commandFromModules = (modules) => {
    let {theme} = store
    let compiledModules = modules->Array.reduce("", (modules, mod) => {
      let compiledModule = switch mod {
      | #clock => Modules.clock(~theme)
      | #hostname => Modules.hostname(~theme)
      | #date => Modules.date(~theme)
      }

      `${modules}${compiledModule}`
    })
    
    Tmux.SetGlobal(Tmux.StatusRight(compiledModules))
  }

  let handleChange = modules => {
    let command = commandFromModules(modules)
    Tmux.exec(command)
  }

  let handleSubmit = modules => { 
    let command = commandFromModules(modules)
    store.addCommands([command])
    steps.forward()
  }

  <Box display=#flex flexDirection=#column>
    <StepHeader number={steps.current.index}>
      {"Select modules to display on the right side of the bar"->s}
    </StepHeader>
    <Box paddingLeft={1}>
      <ModulesSelect
        onChange={handleChange}
        onSubmit={handleSubmit}
        options=[
          {
            label: "Clock",
            value: #clock,
          },
          {
            label: "Hostname",
            value: #hostname,
          },
          {
            label: "Date",
            value: #date,
          },
        ]
      />
    </Box>
  </Box>
}
