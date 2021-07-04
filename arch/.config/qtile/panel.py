"""panel module contains code for creating top panel bar and screens layout"""
from libqtile.config import Screen
from libqtile import bar, qtile, widget

from constants import MY_TERM

COLORS = [
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

def delim():
    """delim creates a pipe delimiter"""
    res = widget.Sep(linewidth=2,
        padding=20,
        foreground=COLORS[11],
        background=COLORS[0])
    return res

def delim_empty(padding_num):
    """delim_empty provides the spacing between widgets"""
    return widget.Sep(linewidth=0,
            padding=padding_num,
            foreground=COLORS[2],
            background=COLORS[0])

def python_icon():
    """python_icon at the start of a panel"""
    res = widget.Image(
            filename="~/.config/qtile/icons/python-white.png",
            scale="False",
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(MY_TERM)})
    return res

def workspaces():
    """workspaces creates group (workspaces) widgets for showing current
    workspace and giving information which workspaces have opened windows"""
    res= widget.GroupBox(margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=COLORS[2],
            inactive=COLORS[7],
            rounded=False,
            highlight_color=COLORS[1],
            highlight_method="line",
            this_current_screen_border=COLORS[6],
            this_screen_border=COLORS[4],
            other_current_screen_border=COLORS[6],
            other_screen_border=COLORS[4],
            foreground=COLORS[2],
            background=COLORS[0])
    return res

def win_title():
    """win-title gives a title of a current window on the screen"""
    res = widget.WindowName(foreground=COLORS[6],
            background=COLORS[0],
            padding=0)
    return res

def widget_network():
    """network"""
    res = widget.Net(interface="all",
        format=' {down}  {up}',
        fontsize=18,
        foreground=COLORS[8],
        background=COLORS[0],
        padding=5)
    return res

def widget_cpu():
    """CPU"""
    res = widget.CPU(
        format = '  {freq_current}GHz  {load_percent}%',
        foreground=COLORS[10],
        background=COLORS[0],
        )
    return res

def widget_battery():
    """battery"""
    res = widget.Battery(
        charge_char = '',
        discharge_char = '',
        empty_char = '',
        full_char = '',
        show_short_text = False,
        format = '{char}  {percent:2.0%} {hour:d}:{min:02d}',
        padding=2,
        background=COLORS[0],
        foreground=COLORS[7])
    return res

def widget_temp():
    """CPU temperature"""
    res = widget.ThermalSensor(tag_sensor="temp1",
        foreground=COLORS[9],
        background=COLORS[0],
        threshold=90,
        padding=5)
    return res

def widget_memory():
    """used and free memory"""
    res = widget.Memory(format='{MemPercent: 0.1f}%',
        foreground=COLORS[3],
        background=COLORS[0],
        mouse_callbacks={
            'Button1':
            lambda: qtile.cmd_spawn(MY_TERM + ' -e htop')
            },
        padding=5)
    return res

def widget_vol():
    """audio volume settings"""
    res = widget.Volume(
        emoji = True,
        foreground=COLORS[5],
        background=COLORS[0],
        )
    return res

def widget_clock():
    """date and time"""
    res = widget.Clock(
        foreground=COLORS[2],
        background=COLORS[0],
        format="%a %b %d %H:%M:%S ",
        )
    return res

def applets():
    """panel applets"""
    res = widget.Systray(
        background=COLORS[0],
        padding=10,
        )
    return res

class MyPanel:
    """MyPanel class provides functionality for creating screens layouts and
    a widget panel"""

    @staticmethod
    def init():
        """init creates all widgets for the panel"""
        widgets_list = [
                delim_empty(6),
                python_icon(),
                delim_empty(20),
                workspaces(),
                delim_empty(40),
                win_title(),

                widget_network(),
                delim(),
                widget_cpu(),
                delim(),
                widget_battery(),
                delim(),
                widget_temp(),
                delim(),
                widget_memory(),
                delim(),
                widget_vol(),
                delim(),
                widget_clock(),
                delim(),

                applets(),
                delim_empty(10),
                ]
        return widgets_list

    @staticmethod
    def panel_primary():
        """panel_primary creates a panel for the primary screen"""
        return MyPanel.init()

    @staticmethod
    def panel_secondary():
        """panel_secondary creates a panel for all secondary screens"""
        return MyPanel.init()[:-3]

    @staticmethod
    def screens():
        """screens creates screen layout"""
        return [
                Screen(
                    top=bar.Bar(widgets=MyPanel.panel_primary(),
                        opacity=1.0, size=30)),
                Screen(
                    top=bar.Bar(widgets=MyPanel.panel_secondary(),
                        opacity=1.0, size=40)),
                Screen(
                    top=bar.Bar(widgets=MyPanel.panel_secondary(),
                        opacity=1.0, size=30)),
                ]
