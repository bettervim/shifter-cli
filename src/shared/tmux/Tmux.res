@spice
type statusPosition = [#top | #bottom]
@spice
type statusJustify = [#centre | #left | #right]

module Styles = {
  @spice
  type t = {
    bg?: string,
    fg?: string,
    bold?: bool,
  }

  let toString = styles => {
    let makeProp = (~name, value) => value->Option.mapOr("", v => `${name}=${v}`)
    let makeBoolProp = (~name, value) => value->Option.mapOr("", v => v ? name : "")

    let bg = makeProp(~name="bg", styles.bg)
    let fg = makeProp(~name="fg", styles.fg)
    let bold = makeBoolProp(~name="bold", styles.bold)

    [bg, fg, bold]
    ->Array.filter(v => v !== "")
    ->Array.join(",")
  }

  let inline = styles => `#[${toString(styles)}]`
}

@spice
type arg =
  | StatusBg(string)
  | StatusFg(string)
  | StatusPosition(statusPosition)
  | StatusJustify(statusJustify)
  | WindowStatusSeparator(string)
  | WindowStatusCurrentFormat(string)
  | WindowStatusCurrentStyle(Styles.t)
  | WindowStatusStyle(Styles.t)
  | WindowStatusFormat(string)
  | StatusLeftContent(string)
  | StatusLeftLength(string)
  | StatusLeft(string)
  | StatusRight(string)

@spice
type command = SetGlobal(arg)

@spice
type commands = array<command>

let argToString = arg => {
  let make = (~command, ~value) => `${command} "${value}"`
  switch arg {
  | StatusBg(value) => make(~command="status-bg", ~value)
  | StatusFg(value) => make(~command="status-fg", ~value)
  | StatusPosition(value) => make(~command="status-position", ~value=(value :> string))
  | StatusJustify(value) => make(~command="status-justify", ~value=(value :> string))
  | WindowStatusSeparator(value) => make(~command="window-status-separator", ~value)
  | WindowStatusCurrentFormat(value) => make(~command="window-status-current-format", ~value)
  | WindowStatusCurrentStyle(value) =>
    make(~command="window-status-current-style", ~value=Styles.toString(value))
  | WindowStatusStyle(value) => make(~command="window-status-style", ~value=Styles.toString(value))
  | WindowStatusFormat(value) => make(~command="window-status-format", ~value)
  | StatusLeftContent(value) => make(~command="status-left", ~value)
  | StatusLeftLength(value) => make(~command="status-left-length", ~value)
  | StatusLeft(value) => make(~command="status-left", ~value)
  | StatusRight(value) => make(~command="status-right", ~value)
  }
}

let parse = command =>
  switch command {
  | SetGlobal(arg) => `tmux set -g ${arg->argToString}`
  }

let dump = commands =>
  commands
  ->Array.map(parse)
  ->Array.join("\n")

let exec = command => NodeJs.ChildProcess.execSync(command->parse)->ignore

module Store = {
  let configFolderPath = NodeJs.Path.join([NodeJs.Os.homedir(), ".config", "shifter"])
  let jsonFile = NodeJs.Path.join([configFolderPath, "shifter.json"])
  let shellFile = NodeJs.Path.join([configFolderPath, "shifter.sh"])

  let checkAndInitFolder = () =>
    switch NodeJs.Fs.existsSync(configFolderPath) {
    | true => ()
    | false => NodeJs.Fs.mkdirSync(configFolderPath)
    }

  let save = commands => {
    let asShell = commands->dump
    checkAndInitFolder()
    NodeJs.Fs.writeFileSync(shellFile, asShell->NodeJs.Buffer.fromString)
  }
}

module TimeCapsule = {
  type ctx = {
    snapshot: array<(string, string)>,
    capture: unit => unit,
    revert: unit => unit,
  }

  let context: React.Context.t<option<ctx>> = React.createContext(None)

  module InternalProvider = {
    let make = React.Context.provider(context)
  }

  let options = [
    "window-status-current-style",
    "window-status-style",
    "status-bg",
    "status-fg",
    "window-status-format",
    "window-status-current-format",
    "status-position",
    "status-left",
    "status-right",
    "status-justify",
  ]

  module Provider = {
    @react.component
    let make = (~children) => {
      let (snapshot, _setSnapshot) = React.useState(_ => [])

      let capture = () => {
        let commands = options->Array.map(opt => (
          opt,
          NodeJs.ChildProcess.execSync(`tmux show-options -g ${opt}`)
          ->NodeJs.Buffer.toString
          ->String.split(`${opt} `)
          ->Array.get(1)
          ->Option.getOr("")
          ->String.replaceAll("\n", ""),
        ))

        _setSnapshot(_ => commands)
      }

      let revert = () => {
        snapshot->Array.forEach(((opt, command)) => {
          let isQuoted = command->String.startsWith(`\"`) || command->String.startsWith("\'")
          let parsedCmd = isQuoted ? command : `"${command}"`
          NodeJs.ChildProcess.execSync(`tmux set -g ${opt} ${parsedCmd}`)->ignore
        })
      }

      <InternalProvider value={Some({snapshot, capture, revert})}> {children} </InternalProvider>
    }
  }

  let useTimeCapsule = () => {
    let ctx = React.useContext(context)

    switch ctx {
    | None => Js.Exn.raiseError("You need to wrap your component with a provider.")
    | Some(v) => v
    }
  }
}
