#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login

export PATH="$HOME/bin:$PATH"

# create first wallpaper
~/bin/nitro

# switch off CapsLock and start US and RU keyboards
~/bin/ru
