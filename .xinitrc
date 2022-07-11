#!/bin/sh

# Load installed init scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Laptop screen
eDP=$(xrandr --listactivemonitors | grep -Eo '\beDP-[0-9]+\b' | sort -u | head -n1)
if [ -n "$eDP" ]; then
	xrdb -merge /dev/stdin << EOF
Xft.dpi: 125
EOF
fi

# Background
feh --bg-scale /usr/share/backgrounds/archlinux/wave.png

# i3wm
exec i3
