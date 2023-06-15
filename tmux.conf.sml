# Set prefix to Ctrl-Space
unbind C-b
set -g prefix C-Space
bind C-Space send-prefix
bind C-Space resize-pane -Z

# Use some vim-like keybindings
set-option -g mode-keys vi
unbind-key -T copy-mode-vi v
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'y' send-keys -X copy-selection
bind-key -T copy-mode-vi 'C-v' send-keys -X rectangle-toggle

# the following configuration comes mostly from:
# http://technopoetic.com/2014/05/emulating-powerline-with-just-vim-and-tmux/

# Index windows and panes from 1
set-option -g base-index 1
set-option -g pane-base-index 1
set-window-option -g pane-base-index 1

# If a window is closed, renumber the remaining windows
set -g renumber-windows on

# Make Prefix + 0 go to window number 10
bind 0 select-window -t :10
 
# Silence bell
set-option -g visual-bell off
 
# Shortcut to reload config
# Keeps me from having to exit and restart whenever I make a config change.
bind r source-file ~/.tmux.conf \; display "Reloaded!"
 
# Bind Ctrl-q to display-pane
bind C-q display-pane

# Bind control-key + Ctrl-a to last window
bind-key C-a last-window

# Bind prefix+f to disable input to pane
bind-key f select-pane -d

# Bind prefix+F to enable input to pane
bind-key e select-pane -e
 
# Up the history limit
set-option -g history-limit 1000000
 
# Change window-splitting commands
# unbind %
# bind | split-window -h
# bind - split-window -v
 
# Vim style Movement commands
bind -r ^ last-window
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R
 
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+
 
# Pane resizing commands
bind H resize-pane -L 10
bind J resize-pane -D 10
bind K resize-pane -U 10
bind L resize-pane -R 10
 
# Turn on mouse support
# set-option -g mode-mouse on
# set-option -g mouse-resize-pane on
# set-option -g mouse-select-pane on
# set-option -g mouse-select-window on
 
# 256 colors, this gives me real trouble, and I'm still not sure
# it's right
set -g default-terminal 'tmux-256color'
set-option -ga terminal-overrides ',xterm-256color:Tc'

# alternative copy mode key
bind Escape copy-mode
 
# pass through xterm keys
set -g xterm-keys on
 
# monitor activity in windows
setw -g monitor-activity on
 
# highlight panes
set -g window-style 'fg=colour247,bg=colour235'
set -g window-active-style 'fg=colour250,bg=black'
# set-option -g pane-active-border-fg red
# set-option -g pane-active-border-bg black
# set-option -g pane-border-fg blue
# set-option -g pane-border-bg black

# Get a blinking cursor
set -g cursor-style blinking-block

# Here's where we get into the status line:
# These basically set the defaults
# set-option -g status-utf8 on
set-option -g status-justify left
set-option -g status-bg black
set-option -g status-fg white
# Set the length of the left region to 40 characters
set-option -g status-left-length 40
 
set-option -g message-style fg=white
set-option -g message-style bg=red
 
setw -g window-status-style bg=black
setw -g window-status-current-style fg=red
#setw -g window-status-alert-attr default
#setw -g window-status-alert-fg yellow
 
# Here's where we set the actual display of the various regions
set -g status-left '#[bg=colour100]#[fg=black]#H: #[fg=black]#S#[fg=colour100] #[bg=black]#[default]'
set -g status-right-length 100
set -g status-right '#[fg=colour100]#[bg=colour100] #[fg=black]%Y-%m-%d #[fg=blue]#[bg=blue]#[fg=black] %H:%M #[default]'

# EXPERIMENTAL SETTINGS:
# smart pane switching with awareness of vim splits
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^([^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?|python)$'"
bind-key -n M-h if-shell "$is_vim" "send-keys M-h"  "select-pane -L"
bind-key -n M-j if-shell "$is_vim" "send-keys M-j"  "select-pane -D"
bind-key -n M-k if-shell "$is_vim" "send-keys M-k"  "select-pane -U"
bind-key -n M-l if-shell "$is_vim" "send-keys M-l"  "select-pane -R"
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\'  'select-pane -l'"
bind-key -T copy-mode-vi 'M-h' select-pane -L
bind-key -T copy-mode-vi 'M-j' select-pane -D
bind-key -T copy-mode-vi 'M-k' select-pane -U
bind-key -T copy-mode-vi 'M-l' select-pane -R
bind-key -T copy-mode-vi 'M-\' select-pane -l

# Move windows left and right
bind-key -n M-H previous-window
bind-key -n M-L next-window

# Create new window
bind-key -n M-N new-window

# Use tmux-sessionizer to create new sessions
bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"

# Swap windows
bind-key -r -n M-< swap-window -t -1
bind-key -r -n M-> swap-window -t +1

# Disable the delay between an escape key press and subsequent characters. This
# increases Vim responsiveness:
set -sg escape-time 10

# don't rename windows automatically
set-option -g allow-rename off

# Settings for the Tmux Plugin Manager
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Other examples:
set -g @plugin 'tmux-plugins/tmux-sidebar'
# set -g @plugin 'seebi/tmux-colors-solarized'

# Undercurl
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'

# vim:set syntax=sh commentstring=#\ %s:
