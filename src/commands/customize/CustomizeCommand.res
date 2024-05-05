open Ink
type steps = SelectTheme | StatusPosition

module Implementation = {
  @react.component
  let make = () => {
    let steps = CustomizeCommand_Steps.useSteps()

    <Box display=#flex flexDirection=#column>
      <Text> {"Shifter ⚡"->s} </Text>
      {if steps.current.id === CustomizeCommand_Steps.initial {
        <Box paddingBottom={1} display=#flex flexDirection=#column>
          <Text>
            {"This command will guide you through creating a new UI config from scratch."->s}
          </Text>
          <Text>
            {"Enjoy real-time previews and confirm changes at the end, or cancel to revert all."->s}
          </Text>
        </Box>
      } else {
        React.null
      }}
      {switch steps.current.id {
      | #SelectTheme => <CustomizeCommand_SelectTheme />
      | #StatusPosition => <CustomizeCommand_SelectStatusPosition />
      | #StatusLeft => <CustomizeCommand_StatusLeft />
      | #WindowLayout => <CustomizeCommand_WindowLayout />
      | #StatusRight => <CustomizeCommand_StatusRight />
      | #Terminate => {
          Console.clear()
          <Text> {"Completed ✅"->s} </Text>
        }
      }}
    </Box>
  }
}

@react.component
let make = () => {
  <CustomizeCommands_Store.Provider>
    <CustomizeCommand_Steps.Provider>
      <Implementation />
    </CustomizeCommand_Steps.Provider>
  </CustomizeCommands_Store.Provider>
}
