module Select = {
  type option = {
    label: string,
    value: string,
  }
  type props = {
    options: array<option>,
    onChange: string => unit
  }

  @module("@inkjs/ui")
  external make: React.component<props> = "Select"
}
