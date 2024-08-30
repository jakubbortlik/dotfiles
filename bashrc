#!/usr/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# disable stopping the flow in terminal by Ctrl-S, so that this mapping can be
# used to save buffers in vim or to search through bash history
stty -ixon

# Disable overwriting when redirecting 
set -o noclobber
# Ask before overwriting files
alias mv="mv -i"
alias cp="cp -i"

# Editor aliases and functions
if command -v nvim > /dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=/home/bortlik/code/squashfs-root/usr/bin/nvim
fi

# Echo path to current pyproject.toml if any exists.
poetry_project() {
  dir=$PWD
  while [[ "$dir" != "${HOME}" ]] && [[ "$dir" != "/" ]]; do
    pyproject_toml="$dir/pyproject.toml"
    if [[ -r $pyproject_toml ]]; then
      if \grep -q "tool.poetry" $pyproject_toml; then
        echo $pyproject_toml
      fi
      break
    else
      dir=$(dirname "$dir")
    fi
  done
}
export -f poetry_project

# Setup local pyenv version if it does not exist already.
setup_pyenv() {
  pyenv local &>/dev/null && return

  pyproject_toml=$1
  if [[ -r $pyproject_toml ]]; then
    python_version=$(\grep -i "^python =" $pyproject_toml | sed 's/[^0-9.]\+//g')
  else
    echo "$pyproject_toml not readable"
    return 1
  fi

  if [[ $python_version != '' ]]; then
    if command -v pyenv &> /dev/null; then
      pyenv local "$python_version"
    else
      echo "Running 'pyenv local $python_version', but pyenv command not available!"
      return 1
    fi
  else
    echo "No Python version detected in $pyproject_toml"
    return 1
  fi
}
export -f setup_pyenv

# Wrap $EDITOR with `poetry run` if in a Poetry project.
vi() {
  pyproject_toml=$(poetry_project)
  if [[ $pyproject_toml != "" ]] && [[ ! $POETRY_ACTIVE ]]; then
    if command -v poetry &> /dev/null; then
      setup_pyenv $pyproject_toml
      poetry run "$EDITOR" "$@"
    else
      echo "Running in Poetry project ($pyproject_toml), but Poetry command not available!"
      $EDITOR "$@"
    fi
  else
    $EDITOR "$@"
  fi
}

get_main() {
    main=$(git branch | tr -d "+* " | \grep -E "^(main|master)$")
    echo "$main"
}
alias vm='vi -c "DiffviewOpen $(get_main)"'
alias vr='vi -c "lua require\"gitlab\".review()"'
alias vin='nvim -u NONE'

# Search for a pattern with ripgrep and set the error list to the matches
qf() {
    vi -q <(rg --vimgrep --no-heading --smart-case -g '!web-components.min.js' -g '!styles.min.css' -g '!poetry.lock' "$@")
}
alias e="$EDITOR -u NONE"

# Set the python debugger to pudb
export PYTHONBREAKPOINT=pudb.set_trace

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=$HOME/.bash_history
HISTSIZE=50000
HISTFILESIZE=100000

# Verify the command brought from history
shopt -s histverify

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set a fancy prompt (non-color, unless we know we "want" color)
if [[ -n ${TMUX} ]]; then
  export TERM="tmux-256color"
else
  export TERM="xterm-256color"
fi
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

PROMPT_COMMAND='PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf -- "~";IFS=/; for q in ${p:1}; do printf -- /"${q:0:4}"; done; printf -- "${q:4}")'

bg_jobs() {
  if [[ -n $(jobs -s 2> /dev/null) ]]; then
    echo "jobs:$(jobs -s 2> /dev/null | wc -l) "
  fi
}
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
git_status() {
  if git status &> /dev/null; then
      if git status 2> /dev/null | grep -q "working tree clean" ; then
          echo " "
      else
          echo "* "
      fi
  fi
}

# \[\033[01;38;5;243m\] - ANSI bold ([01]) foreground (38;5) color 243
if [ "$color_prompt" = yes ]; then
    export PS1='\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;36m\]${PS1X}\[\033[00;38;5;243m\] $(git_branch)$(git_status)$(bg_jobs)\[\033[00m\]\$ '
else
  echo "NO COLOR PROMPT"
  export PS1='\u@\h:\w\[\033[01;91\] $(git_branch)$(bg_jobs)\[\033[00m\]\$ '
fi
unset color_prompt force_color_prompt

# If entered shell from ranger, show it in the prompt:
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(in RA) '

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi
# See https://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors for more details.
export LS_COLORS="ca=30;41:cd=30;33;01:di=01;36:ln=01;34:ow=01;36;40:"

# Set up ripgrep
alias grep='rg'
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Do not load rc.config - ranger configuration twice
export RANGER_LOAD_DEFAULT_RC=FALSE
function ranger-cd {
  tempfile="$(mktemp -t tmp.XXXXXX)"
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]; then
    cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
}
alias ranger='ranger-cd'
# alias "ra" to start ranger or return to the already started version
ra() {
    if [ -z "$RANGER_LEVEL" ]
    then
        ranger
    else
        exit
    fi
}
bind '"\C-o":"ra\C-m"'

# Fuzzy find stuff in a git repo
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}
gf() {
  is_in_git_repo &&
    git -c color.status=always status --short |
    fzf --height 40% -m --ansi --nth 2..,.. | awk '{print $2}'
}
gb() {
  if [[ $# -eq 0 ]]; then
    prompt="Select a branch"
  else
    prompt="$*"
  fi
  is_in_git_repo &&
    git branch -a -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --multi --tac --header "${prompt}" | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##'
}
gt() {
  is_in_git_repo &&
    git tag --sort -version:refname |
    fzf --height 40% --multi --header "Select a tag" 
}
ghash() {
  is_in_git_repo &&
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
    fzf --height 40% --ansi --no-sort --reverse --multi | grep -o '[a-f0-9]\{7,\}'
}
gr() {
  is_in_git_repo &&
    git remote -v | awk '{print $1 " " $2}' | uniq |
    fzf --height 40% --tac | awk '{print $1}'
}
gw() {
  is_in_git_repo &&
    git worktree list |
    fzf --height 40% --ansi --multi --tac --header "Select a worktree" | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##'
}
bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(gf)\e\C-e\er"'  # Fuzzy find git [f]ile
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'  # Fuzzy find git [b]ranch
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'  # Fuzzy find git [t]ag
bind '"\C-g\C-c": "$(ghash)\e\C-e\er"'  # Fuzzy find git [c]ommit hash
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'  # Fuzzy find git [r]emote
bind '"\C-g\C-w": "$(gw)\e\C-e\er"'  # Fuzzy find git [w]orktree
export -f is_in_git_repo
export -f gb
export -f gf
export -f gt
export -f ghash
export -f gr
export -f gw

# Fuzzy find directory to start up a tmux [s]ession in or attach to an existing one
bind -x '"\C-g\C-s":"tmux-sessionizer"'

# Fuzzy find a file and open with `vi`
bind -x '"\C-g\C-v":"selected=$(fzf --multi) && if [[ $selected != \"\" ]]; then vi $selected; fi"'

# Navigate to tmux-pane with Alt+hjkl
bind -x '"\eh":"tmux select-pane -L"'
bind -x '"\ej":"tmux select-pane -D"'
bind -x '"\ek":"tmux select-pane -U"'
bind -x '"\el":"tmux select-pane -R"'

# Get the header of a table and prepend column numbers to column names.
header () {
    SEPARATOR="[ 	;,]"
    if [[ $# -eq 0 ]]; then
        echo "No arguments supplied"
        exit 1
    elif [[ $# -gt 2 ]]; then
        echo "Too many arguments"
        exit 1
    fi
    if [[ $# -eq 2 ]]; then
        if [[ $1 == "," ]]; then
            SEPARATOR=","
        elif [[ $1 == ";" ]]; then
            SEPARATOR=";"
        elif [[ $1 == " " ]]; then
            SEPARATOR=" "
        elif [[ $1 == "	" ]]; then
            SEPARATOR="	"
        fi
        FILE="$2"
    else
        FILE="$1"
    fi
    if [[ -r "${FILE}" ]]; then
        head -1 "${FILE}" | sed -r "s/${SEPARATOR}/\n/g" | nl
    else
        echo "File ${FILE} not readable"
    fi
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Git aliases:
alias g='git'
# Git branch bash completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
if [[ ! $(type -t __git_complete) == function ]]; then
  if [ ! -r ~/.git-completion.bash ]; then
    echo "Downloading git-completion.bash:"
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash && source ~/.git-completion.bash
  else
    source ~/.git-completion.bash
  fi
fi
if [ "$(type -t __git_complete)" == function ]; then
  __git_complete g __git_main
else
  echo "Cannot enable git CLI completion for alias 'g'"
fi

lull() {
  for lfs_object in "$@"; do
    git lfs pull --include="${lfs_object}" --exclude="";
  done
}
# Regenerate ctags:
alias rtags='~/.git_template/hooks/ctags >/dev/null 2>&1 &'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -r ~/code/bash-completion/bash_completion ]; then
    source ~/code/bash-completion/bash_completion
  elif [ -r /etc/bash_completion ]; then
    source /etc/bash_completion
  elif [ -r /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  fi
fi

# Bashrc aliases
alias b="$EDITOR ~/dotfiles/bashrc"
alias bs="source $HOME/.bashrc"
alias be="$EDITOR $HOME/.bashrc_extras"
alias bes="source $HOME/.bashrc_extras"

# Tmux aliases:
alias t='tmux'
alias ta='tmux attach -d'
alias ts='tmux ls'

# wc aliases:
alias lc='wc -l'

# Simplify `cut` usage with tab-separated files
alias cutt="cut -d'	' -f"
# Simplify `cut` usage with space-separated files
alias cuts="cut -d' ' -f"

# Some extra aliases etc.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f "$HOME/.bashrc_extras" ]]; then
  source "$HOME"/.bashrc_extras
fi

# Remap cd to pushd and bd to popd
function cd() {
  if [ "$#" = "0" ]
  then
    pushd "${HOME}" > /dev/null
  elif [ -f "${1}" ]
  then
    "${EDITOR}" "${1}"
  else
    pushd "$1" > /dev/null
  fi
}
function bd(){
  if [ "$#" = "0" ]
  then
    popd > /dev/null
  else
    for i in $(seq "${1}")
    do
      popd > /dev/null
    done
  fi
}

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf '  %-9s' "${seq0:-(default)}"
      printf ' %sTEXT\e[m' "${seq0}"
      printf ' \e[%s1mBOLD\e[m' "${vals:+${vals+$vals;}}"
    done
    echo; echo
  done
}

# correct some typing mistakes with the `cd` command
shopt -s cdspell

export PATH=$HOME/local/bin:$HOME/.local/bin:/usr/lib/node_modules/node/bin:$PATH
# vim:set sw=2 ts=2 ft=sh:
