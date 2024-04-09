type statusPosition = [#top | #bottom]

type arg =
  | StatusBg(string)
  | StatusFg(string)
  | StatusPosition(statusPosition)

let argToString = arg => {
  let createArg = (~command, ~value) => `${command} "${value}"`
  switch arg {
  | StatusBg(value) => createArg(~command="status-bg", ~value)
  | StatusFg(value) => createArg(~command="status-fg", ~value)
  | StatusPosition(value) => createArg(~command="status-position", ~value=(value :> string))
  }
}

type command = SetGlobal(arg)

let command = command =>
  switch command {
  | SetGlobal(arg) => `tmux set -g ${arg->argToString}`
  }

let exec = command => NodeJs.ChildProcess.execSync(command)->ignore
