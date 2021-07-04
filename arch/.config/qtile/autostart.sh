#!/usr/bin/env bash 

# start notification manager
dunst &

# start compositor
picom &

#start sxhkd to replace Qtile native key-bindings
sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# start system tray apps
flameshot &
optimus-manager-qt &
nm-applet &
blueberry-tray &
