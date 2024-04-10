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
    render(<App />)
  })

  program->run
}
