open Ink
type steps = SelectTheme | StatusPosition

module Implementation = {
  @react.component
  let make = () => {
    let steps = InitCommand_Steps.useSteps()

    switch steps.current.id {
    | SelectTheme => <InitCommand_SelectTheme />
    | StatusPosition => <Text>{"StatusPosition"->s}</Text>
    | Terminate => <Text>{"Finish"->s} </Text>
    }
  }
}

@react.component
let make = () => {
  <InitCommand_Steps.Provider>
    <Implementation />
  </InitCommand_Steps.Provider>
}
