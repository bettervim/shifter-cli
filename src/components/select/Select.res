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
    options->Array.map((option): InkUI.Select.option => {
      label: option.label,
      value: Obj.magic(option.value),
    })
  }
  @react.component
  let make = (~options, ~onChange) => {
    let handleChange = value => value->Obj.magic->onChange

    <InkUI.Select options={options->parseOptions} onChange={handleChange} />
  }
}
