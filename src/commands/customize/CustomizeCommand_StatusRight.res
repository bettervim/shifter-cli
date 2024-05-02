open Ink

module ModulesSelect = MultiSelect.Make({
  type t = [#clock]
})

module Modules = {
  let make = (~icon, ~content, ~theme: Themes.t) => {
    let iconStyles = Tmux.Styles.inline({bg: theme.primary._200, fg: theme.foreground._200})
    let contentStyles = Tmux.Styles.inline({bg: theme.background._200, fg: theme.foreground._200})
    `${iconStyles} ${icon} ${contentStyles} ${content}`
  }

  let clock = make(~icon="", ~content="#S", ~theme=Themes.nord)
}

@react.component
let make = () => {
  let handleChange = _ => {
    let modules = `${Modules.clock}`
    Tmux.exec(SetGlobal(StatusRight(modules)))
  }

  let handleSubmit = vs => {
    Console.log(vs)
  }

  <Box>
    <ModulesSelect
      onChange={handleChange}
      onSubmit={handleSubmit}
      options=[
        {
          label: "Clock",
          value: #clock,
        },
      ]
    />
  </Box>
}
