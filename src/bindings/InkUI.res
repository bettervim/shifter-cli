module Select = {
  type option = {
    label: string,
    value: string,
  }
  type props = {
    options: array<option>,
    onChange: string => unit,
  }

  @module("@inkjs/ui")
  external make: React.component<props> = "Select"
}

module Badge = {
  type props = {
    color: string,
    children: React.element,
  }

  @module("@inkjs/ui")
  external make: React.component<props> = "Badge"
}

module TextInput = {
  type props = {
    placeholder?: string,
    onChange: string => unit,
  }

  @module("@inkjs/ui")
  external make: React.component<props> = "TextInput"
}
