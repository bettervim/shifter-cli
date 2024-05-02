type t = {
  theme: Themes.t,
  commands: array<Tmux.command>,
  addCommands: array<Tmux.command> => unit,
  setTheme: Themes.t => unit,
}

let context: React.Context.t<option<t>> = React.createContext(None)

module InternalProvider = {
  let make = React.Context.provider(context)
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (commands, setCommands) = React.useState(_ => [])
    let (theme, _setTheme) = React.useState(_ => Themes.nord)

    let addCommands = newCommands => setCommands(_ => Array.concat(commands, newCommands))
    let setTheme = theme => _setTheme(_ => theme)

    <InternalProvider value={Some({commands, theme, addCommands, setTheme})}>
      {children}
    </InternalProvider>
  }
}

let useStore = () => {
  let context = React.useContext(context)

  switch context {
    | None => Js.Exn.raiseError("You need to wrap your app with CustomizeCommands_Store.Provider.")
    | Some(context) => context
  }
}
