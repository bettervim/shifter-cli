open Ink

module App = {
  @react.component
  let make = () => {
    <>
      <Box borderStyle=#round>
        <Text color=#green> {"Hey :)"->s} </Text>
      </Box>
    </>
  }
}

let _ = {
  open Caporal

  program
  ->command("start", "Let's configure your TMUX from scratch.")
  ->default
  ->action((_) => {
    open Tmux
    let commands = [
      SetGlobal(StatusBg(Themes.nord.background)),
      SetGlobal(StatusFg(Themes.nord.foreground))
    ]
    commands->Array.forEach(cmd =>
    cmd->Tmux.command->Tmux.exec->ignore)

  })

  program->run
}
