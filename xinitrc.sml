#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# enable keyboard switching

# setxkbmap -model pc105 -layout us,cz,epo -variant intl,, -option grp:shift_caps_toggle

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# select the default internet browser:

if [ -n "$DISPLAY" ]; then
	export BROWSER=firefox
else
	export BROWSER=w3m
fi

export EDITOR=nvim
export VISUAL=nvim

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

# # enable scrolling set in ~/.xsessionrc
# if [ -f "~/.xsessionrc" ]; then
# 	bash .xsessionrc
# fi
# check if the xinput command is available
if command -v xinput >/dev/null 2>&1
then
	# to enable vertical scrolling
	xinput set-prop "AlpsPS/2 ALPS DualPoint Stick" "Evdev Wheel Emulation" 1
	xinput set-prop "AlpsPS/2 ALPS DualPoint Stick" "Evdev Wheel Emulation Button" 2
	xinput set-prop "AlpsPS/2 ALPS DualPoint Stick" "Evdev Wheel Emulation Timeout" 200

	# to enable horizontal scrolling
	xinput set-prop "AlpsPS/2 ALPS DualPoint Stick" "Evdev Wheel Emulation Axes" 6 7 4 5
fi

# exec startlxde
exec startlxqt
