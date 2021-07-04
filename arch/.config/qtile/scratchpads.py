""" scratchpad creates temporary apps that can be toggled to and from hidden
state. """
from libqtile.config import ScratchPad, DropDown
from constants import MY_TERM


class MyScratchPad:
    """ MyScratchPad creates temporary apps that can be toggled to and from
    a hidden state."""

    @staticmethod
    def pad():
        """ pad method provides required scratchpads. The shortcuts for
        the scratchpads are located in `keys` module keys_scratchpad
        static method."""
        dropdowns = [
            DropDown("calc",
                     MY_TERM + " -t calc -e '/home/dimus/.rbenv/shims/irb'",
                     x=0.05, y=0.3, width=0.3, height=0.3,
                     on_focus_lost_hide=False),
            DropDown("term",
                     MY_TERM + " -t term",
                     x=0.05, y=0.01, width=0.9, height=0.9,
                     on_focus_lost_hide=False),
            DropDown(
                "solanum",
                "alacritty -t solanum --config-file "
                "/home/dimus/.config/alacritty/sol.yml -e '/home/dimus/go/bin/solanum'",
                x=0.05, y=0.01, width=0.9, height=0.3,
                on_focus_lost_hide=False),
        ]

        return ScratchPad("scratchpad", dropdowns)
