# use some vim-like keybindings
unbind-key -t vi-copy v
bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection
bind-key -t vi-copy 'C-v' rectangle-toggle

# the following configuration comes mostly from:
# http://technopoetic.com/2014/05/emulating-powerline-with-just-vim-and-tmux/

# Index windows from 1
set-option -g base-index 1

# Make Prefix + 0 go to window number 10
bind 0 select-window -t :10
 
# If a window is closed, renumber the remaining windows
set -g renumber-windows on

# Swap windows with < and >
bind -r < swap-window -t -1
bind -r > swap-window -t +1

# Silence bell
set-option -g visual-bell off
 
# Shortcut to reload config
# Keeps me from having to exit and restart whenever I make a config change.
bind r source-file ~/.tmux.conf \; display "Reloaded!"
 
# Bind Ctrl-q to display-pane
bind C-q display-pane

# Bind control-key + Ctrl-a to last window
bind-key C-a last-window
 
# Up the history limit
set-option -g history-limit 10000
 
# Change window-splitting commands
# unbind %
# bind | split-window -h
# bind - split-window -v
 
# Vim style Movement commands
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
 
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+
 
# Pane resizing commands
bind H resize-pane -L 5
bind J resize-pane -D 5
bind K resize-pane -U 5
bind L resize-pane -R 5
 
# Turn on mouse support
# set-option -g mode-mouse on
# set-option -g mouse-resize-pane on
# set-option -g mouse-select-pane on
# set-option -g mouse-select-window on
 
# 256 colors, this gives me real trouble, and I'm still not sure
# it's right
set -g default-terminal "screen-256color"

# alternative copy mode key
bind Escape copy-mode
 
# pass through xterm keys
set -g xterm-keys on
 
# monitor activity in windows
setw -g monitor-activity on
 
# highlight panes
set -g window-style 'fg=colour247,bg=colour236'
set -g window-active-style 'fg=colour250,bg=black'
set-option -g pane-active-border-fg red
set-option -g pane-active-border-bg black
set-option -g pane-border-fg blue
set-option -g pane-border-bg black
 
# Here's where we get into the status line:
# These basically set the defaults
# set-option -g status-utf8 on
set-option -g status-justify left
set-option -g status-bg black
set-option -g status-fg white
# Set the length of the left region to 40 characters
set-option -g status-left-length 40
 
set-option -g message-fg white
set-option -g message-bg red
 
setw -g window-status-bg black
setw -g window-status-current-fg red
#setw -g window-status-alert-attr default
#setw -g window-status-alert-fg yellow
 
# Here's where we set the actual display of the various regions
set -g status-left '#[bg=colour100]#[fg=black]#H: #[fg=blue]#S#[fg=colour100] #[bg=black]#[default]'
set -g status-right-length 100
set -g status-right '#[fg=colour100]#[bg=colour100] #[fg=black]%Y-%m-%d #[fg=blue]#[bg=blue]#[fg=black] %H:%M #[default]'

# EXPERIMENTAL SETTINGS:
# smart pane switching with awareness of vim splits
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^([^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?|python)$'"
bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"

# Disable the delay between an escape key press and subsequent characters. This
# increases Vim responsiveness:
set -sg escape-time 0

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

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'
# vim:set syntax=sh:
