open Ink

module App = {
  @react.component
  let make = () => {
    let (step, setStep) = React.useState(_ => 1)

    <>
      <Box borderStyle=#round>
        <Text color=#green>
          {React.string(
            switch step {
            | 1 => "1. Select a theme"
            | 2 => "2. Select status position"
            | _ => ""
            },
          )}
        </Text>
      </Box>
      {switch step {
      | 1 =>
        <InkUI.Select
          options=[{label: "Dracula", value: "dracula"}, {label: "Nord", value: "nord"}]
          onChange={value => {
            let color = switch value {
            | "dracula" => "#000000"
            | "nord" => "#111111"
            | _ => "#fafafa"
            }

            Tmux.command(SetGlobal(StatusBg(color)))->Tmux.exec
            setStep(_ => 2)
          }}
        />
      | 2 =>
        <InkUI.Select
          options=[{label: "Top", value: "top"}, {label: "Bottom", value: "bottom"}]
          onChange={value => {
            let position = switch value {
            | "top" => #top
            | "bottom" => #bottom
            | _ => #bottom
            }

            Tmux.command(SetGlobal(StatusPosition(position)))->Tmux.exec
          }}
        />
      | _ => React.null
      }}
    </>
  }
}

let _ = render(<App />)
