type statusPosition = [#top | #bottom]

type arg =
  | StatusBg(string)
  | StatusFg(string)
  | StatusPosition(statusPosition)
  | WindowStatusSeparator(string)
  | WindowStatusCurrentFormat(string)
  | WindowStatusCurrentStyle(string)
  | WindowStatusStyle(string)
  | WindowStatusFormat(string)
  | StatusLeftContent(string)
  | StatusLeftLength(string)

let argToString = arg => {
  let make = (~command, ~value) => `${command} "${value}"`
  switch arg {
  | StatusBg(value) => make(~command="status-bg", ~value)
  | StatusFg(value) => make(~command="status-fg", ~value)
  | StatusPosition(value) => make(~command="status-position", ~value=(value :> string))
  | WindowStatusSeparator(value) => make(~command="window-status-separator", ~value)
  | WindowStatusCurrentFormat(value) => make(~command="window-status-current-format", ~value)
  | WindowStatusCurrentStyle(value) => make(~command="window-status-current-style", ~value)
  | WindowStatusStyle(value) => make(~command="window-status-style", ~value)
  | WindowStatusFormat(value) => make(~command="window-status-format", ~value)
  | StatusLeftContent(value) => make(~command="status-left", ~value)
  | StatusLeftLength(value) => make(~command="status-left-length", ~value)
  }
}

type command = SetGlobal(arg)

let command = command =>
  switch command {
  | SetGlobal(arg) => `tmux set -g ${arg->argToString}`
  }

let exec = command => NodeJs.ChildProcess.execSync(command)->ignore
