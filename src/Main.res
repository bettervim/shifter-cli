open Ink

module App = {
  @react.component
  let make = () => {
    <Text color=#green>
      {React.string("Testing...")}
    </Text>
  }
}

let _ = render(<App />)
