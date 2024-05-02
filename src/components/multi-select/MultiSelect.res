module type ISelect = {
  type t
}

module Make = (ISelect: ISelect) => {
  type t = ISelect.t
  type option = {
    label: string,
    value: ISelect.t,
  }
  let parseOptions = (options: array<option>) => {
    options->Array.map((option): InkUI.MultiSelect.option => {
      label: option.label,
      value: Obj.magic(option.value),
    })
  }

  @react.component
  let make = (~options, ~onSubmit, ~onChange) => {
    let handleChange = value => value->Obj.magic->onChange

    <InkUI.MultiSelect options={options->parseOptions} onChange={handleChange} onSubmit={onSubmit} />
  }
}


