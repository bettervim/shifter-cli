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
  let make = (
    ~options,
    ~onSubmit: array<ISelect.t> => unit,
    ~onChange: array<ISelect.t> => unit,
  ) => {
    let handleChange = value => value->Obj.magic->onChange
    let handleSubmit = value => value->Obj.magic->onSubmit

    <InkUI.MultiSelect
      options={options->parseOptions} onChange={handleChange} onSubmit={handleSubmit}
    />
  }
}
