"""shortcuts module creates shortcuts for Qtile windows manager."""
from libqtile.config import Key, KeyChord
from libqtile.command import lazy

from constants import ALT, MOD, MY_TERM


class MyKeys:
    """MyShortcuts has methods for setting up Qtile keyboard shortcuts."""

    @staticmethod
    def keys_win_manager():
        """keys_win_manager contains shorcuts for spawning particular applications,
        changing current layout, starting an app launcher, restarting windows
        manager..."""

        res = [
            Key([MOD], "s", lazy.spawn("steam-runtime")),
            Key([MOD], "Return", lazy.spawn(MY_TERM)),
            Key([MOD, "shift"], "f", lazy.spawn("pcmanfm")),
            Key([ALT], "f", lazy.spawn("firefox")),
            Key([MOD], "Escape", lazy.spawn('xkill')),

            Key([MOD], "space", lazy.next_layout(),
                desc='Toggle through layouts'),
            Key([MOD], "q", lazy.window.kill(),
                desc='Kill active window'),
            Key([MOD, "shift"], "r", lazy.restart(),
                desc='Restart Qtile'),
            Key([MOD], "Left", lazy.next_screen(),
                desc='Move focus to next monitor'),
            Key([MOD], "Right", lazy.prev_screen(),
                desc='Move focus to prev monitor'),
        ]
        return res

    @staticmethod
    def keys_layout():
        """keys_layout creates keys for manipulating size and position of
        windows in a layout as well as switching from one layout to another."""

        res = [
            Key([MOD], "j", lazy.layout.down(),
                desc='Move focus down in current stack pane'),
            Key([MOD], "k", lazy.layout.up(),
                desc='Move focus up in current stack pane'),
            Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), lazy.layout.section_down(),
                desc='Move windows down in current stack'),
            Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), lazy.layout.section_up(),
                desc='Move windows up in current stack'),
            Key([MOD], "l", lazy.layout.shrink(), lazy.layout.decrease_nmaster(),
                desc='Shrink window (MonadTall), decrease number in master pane (Tile)'),
            Key([MOD], "h", lazy.layout.grow(), lazy.layout.increase_nmaster(),
                desc='Expand window (MonadTall), increase number in master pane (Tile)'),
            Key([MOD], "n", lazy.layout.normalize(),
                desc='normalize window size ratios'),
            Key([MOD], "m", lazy.layout.maximize(),
                desc='toggle window between minimum and maximum sizes'),
            Key([MOD, "shift"], "space", lazy.window.toggle_floating(),
                desc='toggle floating'),
            Key([MOD], "f", lazy.window.toggle_fullscreen(),
                desc='toggle fullscreen'),
        ]
        return res

    @staticmethod
    def keys_app_launcher():
        """keys_app_launcher creates shortcuts to operate dmenu or potentially
        another analogous launcher program."""

        res = [
            Key([MOD, "shift"], "Return",
                lazy.spawn("dmenu_run -p 'Run: '")),
            KeyChord([MOD], "p", [
                Key([], "e", lazy.spawn("dm-confedit"),
                    desc='Choose a config file to edit'),
                Key([], "k", lazy.spawn("dm-kill"),
                    desc='Kill processes via dmenu'),
                Key([], "p", lazy.spawn("passmenu"),
                    desc='Retrieve passwords with dmenu'),
            ]),
        ]
        return res

    @staticmethod
    def keys_scratchpad():
        """ keys_scratchpad method provides keyboard shortcuts to toggle
        visibility of scratchpads."""

        res = [
            Key([MOD], "z", lazy.group["scratchpad"].dropdown_toggle("term")),
            Key([MOD], "x", lazy.group["scratchpad"].dropdown_toggle("solanum")),
            Key([MOD], "a", lazy.group["scratchpad"].dropdown_toggle("calc")),
        ]
        return res
