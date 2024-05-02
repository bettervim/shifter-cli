type colorWithVariants = {
  _100: string,
  _200: string,
}

type t = {
  background: colorWithVariants,
  foreground: colorWithVariants,
  primary: colorWithVariants,
  secondary: colorWithVariants,
}

let nord = {
  foreground: {
    _100: "",
    _200: "#D8DEE9"
  },
  background: {
    _100: "#3B4252",
    _200: "#2E3440"
  },
  primary: {_100: "#81A1C1", _200: "#94BECE"},
  secondary: {_100: "#FAFAFA", _200: "#94BECE"},
}

let dracula = {
  foreground: {
    _100: "",
    _200: "#D8DEE9"
  },
  background: {
    _100: "#3B4252",
    _200: "#2E3440"
  },
  primary: {_100: "#81A1C1", _200: "#94BECE"},
  secondary: {_100: "#FAFAFA", _200: "#94BECE"},
}
