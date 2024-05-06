open Ink
module Badge = InkUI.Badge

module ReviewOptionsSelect = Select.Make({
  type t = [
    | #cancel
    | #clipboard
    | #shifter
  ]
})

@react.component
let make = () => {
  let handleChange = value => {
    Console.log(value)
  }

  <Box display=#flex flexDirection=#column>
    <Box gap={1}>
      <Badge color="green">
        <Text bold=true> {"Review"->s} </Text>
      </Badge>
      <Text> {"How would you like to proceed with your configuration?"->s} </Text>
    </Box>
    <ReviewOptionsSelect
      onChange={handleChange}
      options=[
        {
          label: "Cancel and revert all changes",
          value: #cancel,
        },
        {
          label: "Copy to clipboard. I'll paste manually into my own config",
          value: #clipboard,
        },
        {
          label: "Save to my Shifter config. I want to use Shifter to manage my UI configs (recommended)",
          value: #shifter,
        },
      ]
    />
  </Box>
}
