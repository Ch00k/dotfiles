#!/bin/bash

# customizable
LIST_DATA="#{session_name} #{window_name}"

# -p requires tmux 3.2
FZF_COMMAND="fzf-tmux -p --delimiter=: --with-nth 4 --color=hl:2"

# do not change
TARGET_SPEC="#{session_name}:#{window_id}:#{pane_id}:"

# select pane
LINE=$(tmux list-panes -a -F "$TARGET_SPEC $LIST_DATA" | $FZF_COMMAND) || exit 0

# split the result
args=(${LINE//:/ })

# activate session/window/pane
tmux select-pane -t ${args[2]} && tmux select-window -t ${args[1]} && tmux switch-client -t ${args[0]}
