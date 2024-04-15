# Colors
WINDOW_FORMAT=" #W "
BACKGROUND="#4C566A"
PRIMARY="#88C0D0"
SECONDARY="#5E81AC"
FOREGROUND="#ECEFF4"
FOREGROUND_INVERT="#000000"

# Window
tmux set -g window-status-separator ""

## Current
tmux set -g window-status-current-format "$WINDOW_FORMAT"
tmux set -g window-status-current-style "bg=$PRIMARY, fg=$FOREGROUND_INVERT"

## General
tmux set -g window-status-style "bg=$BACKGROUND"
tmux set -g window-status-format "$WINDOW_FORMAT"

# Status
tmux set -g status-bg "$BACKGROUND"
tmux set -g status-fg "$FOREGROUND"

# Status Left
tmux set -g status-left-length 300
tmux set -g status-left " #S "
tmux set -g status-right " #D "
