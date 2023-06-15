# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
  done
}

# disable stopping the flow in terminal by Ctrl-S, so that this mapping can be
# used to save buffers in vim or to serach through bash history
stty -ixon

if command -v nvim > /dev/null 2>&1; then
  export EDITOR=nvim
  alias vi='nvim'
else
  export EDITOR=/home/bortlik/code/squashfs-root/usr/bin/nvim
fi
alias swapurge="rm -i ~/.local/state/nvim/swap/*"

# Set the python debugger to pudb
export PYTHONBREAKPOINT=pudb.set_trace

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
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

PROMPT_COMMAND='PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf -- "~";IFS=/; for q in ${p:1}; do printf -- /"${q:0:3}"; done; printf -- "${q:3}")'

bg_jobs() {
  if [[ -n $(jobs -s 2> /dev/null) ]]; then
    echo "(jobs: $(jobs -s 2> /dev/null | wc -l))"
  fi
}
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
  export PS1='\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;33m\]${PS1X}\[\033[01;32m\]$(git_branch)$(bg_jobs)\[\033[00m\]\$ '
else
  echo "NO COLOR PROMPT"
  export PS1='\u@\h:\w\[\033[01;32m\]$(git_branch)$(bg_jobs)\[\033[00m\]\$ '
fi
unset color_prompt force_color_prompt

# If entered shell from ranger, show it in the prompt:
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(in RA) '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Do not load rc.config - ranger configuration twice
export RANGER_LOAD_DEFAULT_RC=FALSE
function ranger-cd {
  tempfile="$(mktemp -t tmp.XXXXXX)"
  /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
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

# Start up a tmux session
bind -x '"\C-g": "tmux-sessionizer"'

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
    if [[ -r ${FILE} ]]; then
        head -1 ${FILE} | sed -r "s/${SEPARATOR}/\n/g" | nl
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
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
  # Add git completion to aliases
  __git_complete g __git_main
fi
lull() {
  for lfs_object in $@; do
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
alias b="$EDITOR ~/dotfiles/bashrc.sml"
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
  source $HOME/.bashrc_extras
fi

# Remap cd to pushd and bd to popd
function cd() {
  if [ "$#" = "0" ]
  then
    pushd ${HOME} > /dev/null
  elif [ -f "${1}" ]
  then
    ${EDITOR} ${1}
  else
    pushd "$1" > /dev/null
  fi
}
function bd(){
  if [ "$#" = "0" ]
  then
    popd > /dev/null
  else
    for i in $(seq ${1})
    do
      popd > /dev/null
    done
  fi
}

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

export PATH=$HOME/local/bin:$HOME/.local/bin:$PATH
# vim:set ft=bash expandtab ts=2 sw=2:
