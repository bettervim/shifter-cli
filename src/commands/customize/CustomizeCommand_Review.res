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
  let store = CustomizeCommand_Store.useStore()
  let timeCapsule = Tmux.TimeCapsule.useTimeCapsule()
  let (selected, setSelected) = React.useState(_ => None)

  let handleChange = value => {
    switch value {
    | #clipboard => {
        Console.clear()
        let commands = Tmux.dump(store.commands)
        Clipboardy.writeSync(commands)
      }
    | #cancel => timeCapsule.revert()
    | #shifter => Tmux.Store.save(store.commands)
    }
    setSelected(_ => Some(value))
  }

  {
    switch selected {
    | None =>
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
    | Some(#clipboard) =>
      <Box display=#flex flexDirection=#column>
        <Text color=#green italic=true> {"You're all set 🎉"->s} </Text>
        <Text>
          {"Your config is ready to paste. You can modify any part of it. Keep in mind that you"->s}
          <Text color=#green> {" can't edit "->s} </Text>
          {"it using Shifter, since you opted to manage it"->s}
          <Text color=#green> {" manually "->s} </Text>
        </Text>
      </Box>
    | Some(_) => React.null
    }
  }
}
