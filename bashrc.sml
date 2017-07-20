# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# add to PATH
NPATH="$HOME/.bin"

# add it only if required
case ":${PATH}:" in
  *:${NPATH}:*) ;;
  *) PATH=${PATH}:$NPATH ;;
esac

export PATH
export EDITOR=nvim

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth #:erasedups

# append to the history file, don't overwrite with entries from multiple sessions
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable 256 colors in the terminal
# export TERM=xterm-256color
if [ "x$DISPLAY" != "x" ]
then
	export HAS_256_COLORS=yes
	alias tmux="tmux -2"
	if [ "$TERM" = "xterm" ]
	then
		export TERM=xterm-256color
	fi
else
	if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]
	then
		export HAS_256_COLORS=yes
		alias tmux="tmux -2"
	fi
fi

if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]
then
	export TERM=screen-256color
fi

# do not load rc.config - ranger configuration twice
export RANGER_LOAD_DEFAULT_RC=FALSE
# source /usr/share/doc/packages/ranger/examples/bash_automatic_cd.sh
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -d .* --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# disable stopping the flow in terminal by Ctrl-S, so that this mapping
# can be used to save buffers in vim or to search through bash history
stty -ixon

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."

alias b="($EDITOR ~/dotfiles/bashrc.sml)"
alias f="(firefox &> /dev/null &)"
alias h="(localc ~/harmonogram.xls &> /dev/null &)"
alias m="(mocp)"
alias p="(/home/jakub/dotfiles/bin/praat &> /dev/null &)"
alias s="(/usr/bin/skypeforlinux &> /dev/null &)"
alias S="(/usr/bin/oocalc /home/jakub/Documents/domaci/svatba/seznam_rozpocet_organizace.xls &> /dev/null &)"

alias bh="($EDITOR ~/.bash_history)"
alias bs="(. ~/.bashrc)"
alias or="(openbox --reconfigure)"
alias sd="systemctl poweroff"
alias wm="(sudo wifi-menu)"

alias cbh="(sed -ir '/^.[ ]*$/d' ~/.bash_history; echo 'removed single character lines from .bash_history')"
alias edu="(sudo systemctl stop netctl-auto@wlp12s0.service; sudo netctl stop-all; sudo netctl start eduroam)"
alias low="(lowriter &> /dev/null &)"
alias loc="(localc &> /dev/null &)"
alias reb="systemctl reboot"
alias sus="systemctl suspend"
alias vim="nvim"
alias vimdiff="nvim -d"
alias rename="perl-rename"

# git aliases
alias gs="(git status)"
alias gss="(git status -sb)"
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gac='git add -A && git commit -m'

alias audy="(audacity &> /dev/null &)"
alias auds="(audacious &> /dev/null &)"
alias hrad="(sudo systemctl stop netctl-auto@wlp12s0.service; sudo netctl stop-all; sudo netctl start hrad)"
alias wired="(sudo systemctl stop netctl-auto@wlp12s0.service; sudo netctl stop-all; sudo netctl start ethernet-dhcp)"
alias tether="(f=`ip link | grep -oE "enp0s29f[0-9]+u[0-9]+c[0-9]+"`; sudo dhcpcd "$f")"

# temporary aliases:
alias bau='rsync -rptgoDv --delete --exclude=".*" ~/skola/1_phd/01_state_exam/ /run/media/jakub/BORTLIK/skola/1_phd/01_state_exam'
alias baun='rsync -rptgoDvn --delete --exclude=".*" ~/skola/1_phd/01_state_exam/ /run/media/jakub/BORTLIK/skola/1_phd/01_state_exam'
alias bad='rsync -rptgoDv --delete --exclude=".*" ~/skola/1_phd/01_state_exam/ /run/media/jakub/backup/jakub/skola/1_phd/01_state_exam'
alias badn='rsync -rptgoDvn --delete --exclude=".*" ~/skola/1_phd/01_state_exam/ /run/media/jakub/backup/jakub/skola/1_phd/01_state_exam'

# (mount automatically and) cd to the the first connected USB
alias cu1="cd /mnt/usb1"
# unmount the first connected USB
alias uu1="cd ~; sudo umount /dev/sdb1"

# (mount automatically and) cd to the the second connected USB
alias cu2="cd /mnt/usb2"
# unmount the second connected USB
alias uu2="cd ~; sudo umount /dev/sdc1"

# (mount automatically and) cd to the SD card
alias cs="cd /mnt/sd"
# unmount SD card
alias us="cd ~; sudo umount /dev/mmcblk0p1"

# copied from somewhere without ever using it!
#alias here="find . -type f -print0 | xargs -0"

PS1='[\u@\h \W]\$ '
# if entered shell from ranger, show it in the prompt:
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(in RA) '

# added by Anaconda3 4.1.1 installer
# export PATH="/home/jakub/.anaconda3/bin:$PATH"
