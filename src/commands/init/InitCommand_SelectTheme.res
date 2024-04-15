open Ink

let options = {
  open InkUI.Select

  [
    {
      label: "Nord",
      value: "nord",
    },
    {
      label: "Dracula",
      value: "dracula",
    },
    {
      label: "Catppuccin",
      value: "catppuccin",
    },
  ]
}

@react.component
let make = () => {
  open InkUI
  let steps = InitCommand_Steps.useSteps()

  let handleChange = _ => steps.next()

  <Box display=#flex flexDirection=#column>
    <Box gap={1}>
      <Badge color="green"> {"1"->s} </Badge>
      <Text> {"Select your favorite theme?"->s} </Text>
    </Box>
    <Box paddingLeft={1}>
      <Select options onChange={handleChange} />
    </Box>
  </Box>
}
