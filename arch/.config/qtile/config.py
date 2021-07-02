# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.config import ScratchPad, DropDown
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401


def toggle_group_empty():
    pass


lazy.screen.toggle_group = toggle_group_empty

mod = "mod4"  # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"  # My terminal of choice

###############################################################################
# Computer Screens                                                            #
###############################################################################

keys = [
    Key([mod], "s", lazy.spawn("steam-runtime")),
    ### The essentials
    Key([mod], "Return", lazy.spawn(myTerm)),
    Key([mod], "Escape", lazy.spawn('xkill')),
    Key([mod, "shift"], "Return", lazy.spawn("dmenu_run -p 'Run: '")),
    Key([mod], "space", lazy.next_layout(), desc='Toggle through layouts'),
    Key([mod], "q", lazy.window.kill(), desc='Kill active window'),
    Key([mod, "shift"], "r", lazy.restart(), desc='Restart Qtile'),
    Key([mod], "Left", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "Right", lazy.prev_screen(), desc='Move focus to prev monitor'),

    ### Window controls
    Key([mod],
        "j",
        lazy.layout.down(),
        desc='Move focus down in current stack pane'),
    Key([mod],
        "k",
        lazy.layout.up(),
        desc='Move focus up in current stack pane'),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc='Move windows down in current stack'),
    Key([mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc='Move windows up in current stack'),
    Key([mod],
        "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
        ),
    Key([mod],
        "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
        ),
    Key([mod],
        "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'),
    Key([mod],
        "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'),
    Key([mod, "shift"],
        "space",
        lazy.window.toggle_floating(),
        desc='toggle floating'),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),

    # Dmenu scripts launched using the key chord SUPER+p followed by 'key'
    KeyChord(
        [mod],
        "p",
        [
            Key([],
                "e",
                lazy.spawn("dm-confedit"),
                desc='Choose a config file to edit'),
            # Key([], "i",
            #     lazy.spawn("./dmscripts/dm-maim"),
            #     desc='Take screenshots via dmenu'
            #     ),
            Key([],
                "k",
                lazy.spawn("dm-kill"),
                desc='Kill processes via dmenu'),
            # Key([], "l",
            #     lazy.spawn("./dmscripts/dm-logout"),
            #     desc='A logout menu'
            #     ),
            # Key([], "m",
            #     lazy.spawn("./dmscripts/dm-man"),
            #     desc='Search manpages in dmenu'
            #     ),
            # Key([], "o",
            #     lazy.spawn("./dmscripts/dm-bookman"),
            #     desc='Search your qutebrowser bookmarks and quickmarks'
            #     ),
            # Key([], "r",
            #     lazy.spawn("./dmscripts/dm-reddit"),
            #     desc='Search reddit via dmenu'
            #     ),
            # Key([], "s",
            #     lazy.spawn("./dmscripts/dm-websearch"),
            #     desc='Search various search engines via dmenu'
            #     ),
            Key([],
                "p",
                lazy.spawn("passmenu"),
                desc='Retrieve passwords with dmenu')
        ])
]

group_names = [
        ("1", { 'layout': 'monadtall' }),
        ("2", { 'layout': 'monadtall' }),
        ("3", { 'layout': 'monadtall' }),
        ("4", { 'layout': 'monadtall' }),
        ("5", { 'layout': 'monadtall' }),
        ("6", { 'layout': 'monadtall' }),
        ("7", { 'layout': 'monadtall' }),
        ("8", { 'layout': 'monadtall' }),
        ("9", { 'layout': 'monadtall' }),
        ("0", { 'layout': 'floating' }),
        ]

pinned_groups = ['123456789', '0']

all_groups = ''.join(pinned_groups)

groups = [Group(i, **group_names[ind][1]) for ind, i in enumerate(all_groups)]

for j, names in enumerate(pinned_groups):
    keys.extend(
        Key([mod], i, lazy.to_screen(j), lazy.group[i].toscreen(screen=None,
                                                                toggle=False))
        for i in names)

###############################################################################
# Sratch Pads                                                                 #
###############################################################################

dropdowns = [
    DropDown("calc",
             myTerm + " -t calc -e '/home/dimus/.rbenv/shims/irb'",
             x=0.05,
             y=0.3,
             width=0.3,
             height=0.3,
             on_focus_lost_hide=False),
    DropDown("term",
             myTerm + " -t term",
             x=0.05,
             y=0.01,
             width=0.9,
             height=0.9,
             on_focus_lost_hide=False),
    DropDown(
        "solanum",
        "alacritty -t solanum --config-file /home/dimus/.config/alacritty/sol.yml -e '/home/dimus/go/bin/solanum'",
        x=0.05,
        y=0.01,
        width=0.9,
        height=0.3,
        on_focus_lost_hide=False),
]

scrpad = ScratchPad("scratchpad", dropdowns)

groups.append(scrpad)

keys.extend(Key([mod, 'shift'], i, lazy.window.togroup(i)) for i in all_groups)

keys.append(Key([mod], "z", lazy.group["scratchpad"].dropdown_toggle("term")))
keys.append(
    Key([mod], "x", lazy.group["scratchpad"].dropdown_toggle("solanum")))
keys.append(Key([mod], "a", lazy.group["scratchpad"].dropdown_toggle("calc")))

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
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(**layout_theme),
]

###############################################################################
# Top Bar                                                                     #
###############################################################################

colors = [
    ["#282c34", "#282c34"],  # 0 panel background
    ["#3d3f4b", "#434758"],  # 1 background for current screen tab
    ["#ffffff", "#ffffff"],  # 2 font color for group names
    ["#ff5555", "#ff5555"],  # 3 border line color for current tab
    ["#74438f", "#74438f"
     ],  # 4 border line color for 'other tabs' and color for 'odd widgets'
    ["#4f76c7", "#4f76c7"],  # 5 color for the 'even widgets'
    ["#e1acff", "#e1acff"],  # 6 window name
    ["#ecbbfb", "#ecbbfb"],  # 7 backbround for inactive screens
    ["#c3e88d", "#c3e88d"],  # 8
    ["#ffff22", "#ffff22"],  # 9
    ["#ffb86c", "#ffb86c"],  # 10
    ["#555555", "#555555"],  # 11
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(font="Fira Mono Nerd Font",
                       fontsize=21,
                       padding=0,
                       background=colors[0])
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    delim = widget.Sep(linewidth=2,
                       padding=20,
                       foreground=colors[11],
                       background=colors[0])

    widgets_list = [
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground=colors[2],
                   background=colors[0]),
        widget.Image(
            filename="~/.config/qtile/icons/python-white.png",
            scale="False",
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerm)}),
        widget.Sep(linewidth=0,
                   padding=20,
                   foreground=colors[2],
                   background=colors[0]),
        widget.GroupBox(margin_y=3,
                        margin_x=0,
                        padding_y=5,
                        padding_x=3,
                        borderwidth=3,
                        active=colors[2],
                        inactive=colors[7],
                        rounded=False,
                        highlight_color=colors[1],
                        highlight_method="line",
                        this_current_screen_border=colors[6],
                        this_screen_border=colors[4],
                        other_current_screen_border=colors[6],
                        other_screen_border=colors[4],
                        foreground=colors[2],
                        background=colors[0]),
        widget.Sep(linewidth=0,
                   padding=40,
                   foreground=colors[2],
                   background=colors[0]),
        widget.WindowName(foreground=colors[6],
                          background=colors[0],
                          padding=0),

        ################################################################################

        # Network widget
        widget.Net(interface="enp2s0",
                   format='\uf0ab {down} \uf0aa {up}',
                   fontsize=18,
                   foreground=colors[8],
                   padding=5),

        # Layouts widget
        delim,
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            padding=4,
            scale=0.7),
        widget.CurrentLayout(foreground=colors[7], ),

        # Temperature widget
        delim,
        widget.ThermalSensor(tag_sensor="temp1",
                             foreground=colors[9],
                             threshold=90,
                             padding=5),

        # Memory widget
        delim,
        widget.Memory(format='{MemPercent: 0.1f}%',
                      foreground=colors[3],
                      mouse_callbacks={
                          'Button1':
                          lambda: qtile.cmd_spawn(myTerm + ' -e htop')
                      },
                      padding=5),

        # CPU widget
        delim,
        widget.CPU(foreground=colors[10], ),

        #Volume widget
        delim,
        widget.TextBox(text="🔉︁", foreground=colors[5], padding=5),
        widget.Volume(
            foreground=colors[5],
            background=colors[0],
        ),

        # Time widget
        delim,
        widget.Clock(
            foreground=colors[2],
            format="%a %b %d %H:%M:%S ",
        ),

        ################################################################################
        delim,
        widget.Systray(
            background=colors[0],
            padding=10,
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
    ]
    return widgets_list


###############################################################################
# Computer Screens                                                            #
###############################################################################


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1[:-3]


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2  # Monitor 2 will display all widgets in widgets_list


def init_screens():
    return [
        Screen(
            top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=30)),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=40)),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30))
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()

    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),  # tastyworks exit box
    Match(title='Qalculate!'),  # qalculate-gtk
    Match(title='GNU Image Manipulation Program'),  # gimp
    Match(wm_class='kdenlive'),  # kdenlive
    Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
