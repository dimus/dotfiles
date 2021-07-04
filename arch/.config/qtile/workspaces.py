"""workspaces module contains code for creating groups (workspaces)"""
from libqtile.config import Group

GROUP_NAMES = [
    ("1", {'layout': 'monadtall'}),
    ("2", {'layout': 'monadtall'}),
    ("3", {'layout': 'monadtall'}),
    ("4", {'layout': 'monadtall'}),
    ("5", {'layout': 'monadtall'}),
    ("6", {'layout': 'monadtall'}),
    ("7", {'layout': 'monadtall'}),
    ("8", {'layout': 'monadtall'}),
    ("9", {'layout': 'monadtall'}),
    ("0", {'layout': 'floating'}),
]

PINNED_GROUPS = ['123456789', '0']

ALL_GROUPS = ''.join(PINNED_GROUPS)

class MyWorkspaces:
    """MyWorkspaces provides functionality needed for workspaces creation"""
    @staticmethod
    def groups():
        """groups creates all workspaces"""
        res = [Group(i, **GROUP_NAMES[ind][1])
                for ind, i in enumerate(ALL_GROUPS)]
        return res

    @staticmethod
    def pinned_groups():
        """pinned_groups return groups for each screen"""
        return PINNED_GROUPS

    @staticmethod
    def all_groups():
        """all_groups returns all workspaces"""
        return ALL_GROUPS
