open Ink
type steps = SelectTheme | StatusPosition

module Implementation = {
  @react.component
  let make = () => {
    let steps = CustomizeCommand_Steps.useSteps()

    switch steps.current.id {
    | #SelectTheme => <CustomizeCommand_SelectTheme />
    | #StatusPosition => <CustomizeCommand_SelectStatusPosition />
    | #StatusLeft => <CustomizeCommand_StatusLeft />
    | #StatusRight => <CustomizeCommand_StatusRight />
    | #WindowLayout => <CustomizeCommand_WindowLayout />
    | #Terminate => {
        Console.clear()
        <Text> {"Completed ✅"->s} </Text>
      }
    }
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
