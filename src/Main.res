let _ = {
  open Caporal

  program
  ->command("start", "Let's configure your TMUX from scratch.")
  ->default
  ->action((_) => {
    Ink.render(<InitCommand />)
  })

  program->run
}
