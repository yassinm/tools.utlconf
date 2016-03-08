#!/usr/bin/env python2.7

import logging
import sys
from pprint import pformat

import i3ipc

i3 = i3ipc.Connection()
LOG = logging.getLogger()


# noinspection SpellCheckingInspection
def get_current_wspace():
    """Get workspace that is currently focused"""
    cur_wspaces = i3.get_workspaces()
    actives = [wk for wk in cur_wspaces if wk['focused']]
    assert len(actives) == 1
    return actives[0]


def setup_logger(level):
    """Initializes logger with debug level"""
    LOG.setLevel(level)
    # LOG.setLevel(logging.DEBUG)

    channel = logging.StreamHandler(sys.stdout)
    channel.setLevel(level)

    formatter = logging.Formatter('[%(levelname)s] %(message)s')
    channel.setFormatter(formatter)
    LOG.addHandler(channel)


def change_workspace():
    """
    Switches to workspace num like xmonad.

    Always sets focused output to workspace num. If the workspace is on
    another output, then the workspaces are "shifted" among the outputs.
    """

    # new_wspace = 'dev000'

    outputs = i3.get_outputs()
    curscr = get_current_wspace()['output']
    scrlst = [activescr for activescr in filter(lambda o: o.active, outputs)]

    # LOG.debug('Active screens : \n' + pformat(activescr))

    for idx, scrobj in enumerate(scrlst):
        # Focus on wanted workspace
        wscmd = 'workspace l_%d' % idx
        execmd = 'exec "{}"'.format('gnome-terminal --hide-menubar')
        i3cmd = '{} ; {} '.format(wscmd, execmd)

        scrname = scrobj['name']
        if scrname != curscr:
            i3cmd = '%s ; move workspace to output %s' % (i3cmd, scrname)

        i3.command(i3cmd)
        LOG.debug('Command :%s' % i3cmd)

        cur_wspace = get_current_wspace()
        LOG.debug('Current workspace:%s' % cur_wspace )

        # focused = i3.get_tree().find_focused()
        # print('Focused window %s is on workspace %s' %
        #       (focused.name, focused.workspace().name))


if __name__ == '__main__':
    setup_logger(logging.DEBUG)
    change_workspace()
