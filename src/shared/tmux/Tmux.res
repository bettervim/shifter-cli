type statusPosition = [#top | #bottom]

module Styles = {
  type t = {
    bg?: string,
    fg?: string,
  }

  let toString = (styles) => {
    let makeProp = (~name, value) => value->Option.mapOr("", v => `${name}=${v}`)
    let bg = makeProp(~name="bg", styles.bg)
    let fg = makeProp(~name="fg", styles.fg)

    `${bg}, ${fg}`
  }

  let inline = (styles) => `#[${toString(styles)}]`
}

type arg =
  | StatusBg(string)
  | StatusFg(string)
  | StatusPosition(statusPosition)
  | WindowStatusSeparator(string)
  | WindowStatusCurrentFormat(string)
  | WindowStatusCurrentStyle(Styles.t)
  | WindowStatusStyle(Styles.t)
  | WindowStatusFormat(string)
  | StatusLeftContent(string)
  | StatusLeftLength(string)
  | StatusLeft(string)
  | StatusRight(string)

let argToString = arg => {
  let make = (~command, ~value) => `${command} "${value}"`
  switch arg {
  | StatusBg(value) => make(~command="status-bg", ~value)
  | StatusFg(value) => make(~command="status-fg", ~value)
  | StatusPosition(value) => make(~command="status-position", ~value=(value :> string))
  | WindowStatusSeparator(value) => make(~command="window-status-separator", ~value)
  | WindowStatusCurrentFormat(value) => make(~command="window-status-current-format", ~value)
  | WindowStatusCurrentStyle(value) => make(~command="window-status-current-style", ~value=Styles.toString(value))
  | WindowStatusStyle(value) => make(~command="window-status-style", ~value=Styles.toString(value))
  | WindowStatusFormat(value) => make(~command="window-status-format", ~value)
  | StatusLeftContent(value) => make(~command="status-left", ~value)
  | StatusLeftLength(value) => make(~command="status-left-length", ~value)
  | StatusLeft(value) => make(~command="status-left", ~value)
  | StatusRight(value) => make(~command="status-right", ~value)
  }
}

type command = SetGlobal(arg)

let parse = command =>
  switch command {
  | SetGlobal(arg) => `tmux set -g ${arg->argToString}`
  }

let exec = command => NodeJs.ChildProcess.execSync(command->parse)->ignore
