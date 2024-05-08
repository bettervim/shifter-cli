type modules = [#clock | #hostname | #date | #"session-name" | #"number-and-session-name"]

let makeModule = (~icon, ~content, ~theme: Themes.t) => {
  let iconStyles = Tmux.Styles.inline({bg: theme.primary._200, fg: theme.background._200})
  let contentStyles = Tmux.Styles.inline({bg: theme.background._200, fg: theme.foreground._200})
  `${iconStyles} ${icon} ${contentStyles} ${content} `
}

let clock = makeModule(~icon=" ", ~content="%H:%M", ...)
let hostname = makeModule(~icon="", ~content="#H", ...)
let date = makeModule(~icon="", ~content="%Y", ...)
let sessionName = makeModule(~icon="", ~content="#S", ...)
let sessionNameAndNumber = makeModule(~icon="#I", ~content="#S", ...)

let compile = (~theme, mod) =>
  switch mod {
  | #clock => clock(~theme)
  | #hostname => hostname(~theme)
  | #date => date(~theme)
  | #"session-name" => sessionName(~theme)
  | #"number-and-session-name" => sessionNameAndNumber(~theme)
  }

module StatusOptionsSelect = {
  module InnerSelect = MultiSelect.Make({
    type t = modules
  })
  let options = {
    open InnerSelect
    [
      {
        label: "Clock",
        value: #clock,
      },
      {
        label: "Date",
        value: #date,
      },
      {
        label: "Hostname",
        value: #hostname,
      },
      {
        label: "Session Name",
        value: #"session-name",
      },
      {
        label: "Number & Session Name",
        value: #"number-and-session-name",
      },
    ]
  }

  type mode = [#right | #left]

  @react.component
  let make = (~mode: mode) => {
    let store = CustomizeCommand_Store.useStore()
    let steps = CustomizeCommand_Steps.useSteps()

    let commandFromModules = modules => {
      let {theme} = store

      let compiledModules = modules->Array.reduce("", (modules, mod) => {
        let compiledModule = compile(~theme, mod)
        `${modules}${compiledModule}`
      })

      switch mode {
      | #left => Tmux.SetGlobal(Tmux.StatusLeft(compiledModules))
      | #right => Tmux.SetGlobal(Tmux.StatusRight(compiledModules))
      }
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

    <InnerSelect options onChange={handleChange} onSubmit={handleSubmit} />
  }
}
