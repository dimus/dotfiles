""" config file for Qtile windows manager"""
# -*- coding: utf-8 -*-
import os
import subprocess
from libqtile import qtile
from libqtile.config import Key, Match, Drag, Click
from libqtile.command import lazy
from libqtile import layout, hook

from constants import MOD
# key bindings
from keys import MyKeys
# scratchpad windows like calculator, terminal, solanum
from scratchpads import MyScratchPad
# top panel and screens
from bar import MyPanel
# workspaces
from workspaces import MyWorkspaces

###############################################################################
# Workspaces, scratchpads and keyboard shortcuts                              #
###############################################################################

keys = MyKeys.keys_win_manager() + MyKeys.keys_layout() + \
    MyKeys.keys_app_launcher()

groups = MyWorkspaces.groups()

for j, names in enumerate(MyWorkspaces.pinned_groups()):
    keys.extend(
        Key([MOD], i, lazy.to_screen(j), lazy.group[i].toscreen(screen=None,
                                                                toggle=False))
        for i in names)

keys.extend(Key([MOD, 'shift'], i, lazy.window.togroup(i))
        for i in MyWorkspaces.all_groups())

groups.append(MyScratchPad.pad())
keys += MyKeys.keys_scratchpad()

###############################################################################
# Layouts                                                                     #
###############################################################################

layout_theme = {
    "border_width": 2,
    "margin": 2,
    "border_focus": "e1acff",
    "border_normal": "1D2330"
}

layouts = [
    layout.MonadTall(
        ratio = 0.75,
        max_ratio = 0.8,
        min_ratio = 0.2,
        change_ratio = 0.02,
        align = 1,
        **layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(**layout_theme),
]

###############################################################################
# Panel and screens                                                           #
###############################################################################

widget_defaults = dict(font="Fira Mono Nerd Font",
        fontsize=21,
        padding=0,
        )

extension_defaults = widget_defaults.copy()

screens = MyPanel.screens()

###############################################################################
# Misc                                                                        #
###############################################################################

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),  # tastyworks exit box
    Match(title='Qalculate!'),  # qalculate-gtk
    Match(title='Bluetooth'),  # qalculate-gtk
    Match(title='GNU Image Manipulation Program'),  # gimp
    Match(wm_class='kdenlive'),  # kdenlive
    Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
])

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
