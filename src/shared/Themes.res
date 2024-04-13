type colorWithVariants = {
  _100: string,
  _200: string,
}

type t = {
  background: string,
  foreground: string,
  primary: colorWithVariants,
  secondary: colorWithVariants,
}

let nord = {
  foreground: "#E5E9F0",
  background: "#3C4251",
  primary: {_100: "#FAFAFA", _200: "#94BECE"},
  secondary: {_100: "#FAFAFA", _200: "#94BECE"},
}
