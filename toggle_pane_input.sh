#! /usr/bin/env bash
# Toggle input to tmux pane and set custom style for the locked pane

if [ $1 -eq 0 ]; then
  tmux select-pane -d
  tmux set-option -p window-style 'bg=colour235'
  tmux set-option -p window-active-style 'bg=colour235'
else
  tmux select-pane -e
  tmux set-option -p -u window-style
  tmux set-option -p -u window-active-style
fi
