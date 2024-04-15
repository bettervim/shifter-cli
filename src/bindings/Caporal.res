type t

@module("@caporal/core") @scope("default")
external program: t = "program"

type logger = {
  info: string => unit
}

type actionParams = {
  logger: logger,
}

@send
external action: (t, actionParams => unit) => unit = "action"

@send
external command: (t, string, string) => t = "command"

@send
external default: (t) => t = "default"

@send
external run: (t) => unit = "run"
