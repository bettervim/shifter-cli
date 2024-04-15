type steps = SelectTheme | StatusPosition | Terminate

let steps = [SelectTheme, StatusPosition, Terminate]

let getStep = index => steps->Array.get(index)

type currentStep = {
  index: int,
  id: steps,
}

type t = {
  current: currentStep,
  forward: unit => unit,
  back: unit => unit,
}

let context: React.Context.t<option<t>> = React.createContext(None)

module InternalProvider = {
  let make = React.Context.provider(context)
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (currentStep, setCurrentStep) = React.useState(_ => {
      index: 0,
      id: SelectTheme,
    })

    let forward = () => {
      let next = currentStep.index + 1
      switch getStep(next) {
      | Some(stepId) => setCurrentStep(_ => {index: next, id: stepId})
      | None => ()
      }
    }

    let back = () => {
      let previous = currentStep.index - 1
      switch getStep(previous) {
      | Some(stepId) => setCurrentStep(_ => {index: previous, id: stepId})
      | None => ()
      }
    }
    <InternalProvider value={Some({forward, back, current: currentStep})}> {children} </InternalProvider>
  }
}

let useSteps = () => {
  let api = React.useContext(context)

  switch api {
  | None => Js.Exn.raiseError("You need to wrap your component with a provider.")
  | Some(v) => v
  }
}
