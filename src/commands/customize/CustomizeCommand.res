open Ink
type steps = SelectTheme | StatusPosition

module WelcomeMessage = {
  @react.component
  let make = () => {
    <Box paddingBottom={1} display=#flex flexDirection=#column>
      <Text color=#green bold=true italic=true> {"Shifter ⚡"->s} </Text>
      <Text>
        {"This command will guide you through creating a new"->s}
        <Text color=#green> {" UI "->s} </Text>
        {"config from scratch."->s}
      </Text>
      <Text>
        {"Enjoy"->s}
        <Text color=#green> {" real-time "->s} </Text>
        {"previews and confirm changes at the end, or cancel to revert all."->s}
      </Text>
    </Box>
  }
}

module Implementation = {
  @react.component
  let make = () => {
    let steps = CustomizeCommand_Steps.useSteps()

    <Box display=#flex flexDirection=#column paddingLeft={1.0->Obj.magic}>
      {if steps.current.id === CustomizeCommand_Steps.initial {
        <WelcomeMessage />
      } else {
        React.null
      }}
      {switch steps.current.id {
      | #SelectTheme => <CustomizeCommand_SelectTheme />
      | #StatusPosition => <CustomizeCommand_SelectStatusPosition />
      | #StatusLeft => <CustomizeCommand_StatusLeft />
      | #WindowLayout => <CustomizeCommand_WindowLayout />
      | #StatusRight => <CustomizeCommand_StatusRight />
      | #Review => <CustomizeCommand_Review />
      | #Terminate => React.null
      }}
    </Box>
  }
}

@react.component
let make = () => {
  <CustomizeCommand_Store.Provider>
    <CustomizeCommand_Steps.Provider>
      <Implementation />
    </CustomizeCommand_Steps.Provider>
  </CustomizeCommand_Store.Provider>
}
