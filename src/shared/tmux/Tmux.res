type statusPosition = [#top | #bottom]

type arg =
  | StatusBg(string)
  | StatusFg(string)
  | StatusPosition(statusPosition)

let argToString = arg => {
  let make = (~command, ~value) => `${command} "${value}"`
  switch arg {
  | StatusBg(value) => make(~command="status-bg", ~value)
  | StatusFg(value) => make(~command="status-fg", ~value)
  | StatusPosition(value) => make(~command="status-position", ~value=(value :> string))
  }
}

type command = SetGlobal(arg)

let command = command =>
  switch command {
  | SetGlobal(arg) => `tmux set -g ${arg->argToString}`
  }

let exec = command => NodeJs.ChildProcess.execSync(command)->ignore

module TimeCapsule = {
  @module("./sh.js")
  external sh: string => promise<string> = "sh"
  }
