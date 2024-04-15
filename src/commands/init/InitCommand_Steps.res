type steps = SelectTheme | StatusPosition | Terminate

let getNext = current =>
  switch current {
  | SelectTheme => Some(StatusPosition)
  | StatusPosition => Some(Terminate)
  | Terminate => None
  }

type t = {
  step: steps,
  next: unit => unit,
  previous: unit => unit,
}

let context: React.Context.t<option<t>> = React.createContext(None)

module InternalProvider = {
  let make = React.Context.provider(context)
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (step, setStep) = React.useState(_ => SelectTheme)

    let next = () => {
      switch getNext(step) {
      | Some(value) => setStep(_ => value)
      | None => ()
      }
    }

    let previous = () => setStep(_ => SelectTheme)

    <InternalProvider value={Some({next, previous, step})}> {children} </InternalProvider>
  }
}

let useSteps = () => {
  let api = React.useContext(context)

  switch api {
  | None => Js.Exn.raiseError("You need to wrap your component with a provider.")
  | Some(v) => v
  }
}
