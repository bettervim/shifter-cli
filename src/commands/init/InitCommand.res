open Ink
type steps = SelectTheme | StatusPosition

module Implementation = {
  @react.component
  let make = () => {
    let steps = InitCommand_Steps.useSteps()

    switch steps.current.id {
    | SelectTheme => <InitCommand_SelectTheme />
    | StatusPosition => <InitCommand_SelectStatusPosition />
    | Terminate => {
        Console.clear()
        <Text> {"Completed ✅"->s} </Text>
      }
    }
  }
}

@react.component
let make = () => {
  <InitCommand_Steps.Provider>
    <Implementation />
  </InitCommand_Steps.Provider>
}
