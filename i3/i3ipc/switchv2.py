#!/usr/bin/env python2.7

import logging
import sys

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
    # new_wspace = 'dev000'

    outputlst = i3.get_outputs()
    curws = get_current_wspace()
    curoutput = curws['output']

    scrlst = [lst for lst in filter(lambda o: o.active, outputlst)]

    # LOG.debug('Active screens : \n' + pformat(activescr))

    for idx, wsobj in enumerate(scrlst):
        # Focus on wanted workspace
        wsname = wsobj['name']

        execmd = ' {} ; {} '.format(
            'workspace l%d' % idx,
            'exec "gnome-terminal --hide-menubar" '
        )

        LOG.debug('Command wsname:%s curoutput:%s' % (curoutput, wsname))

        if wsname == curoutput:
            execmd = "exec 'i3-msg \"{}\" '".format(execmd)
        else:
            execmd = "exec 'i3-msg '{} , move workspace to output {}' ".format(execmd, wsname)

        i3.command(execmd)
        LOG.debug('Command execmd:%s' % execmd)

        cur_wspace = get_current_wspace()
        LOG.debug('Current workspace:%s' % cur_wspace)

        # focused = i3.get_tree().find_focused()
        # print('Focused window %s is on workspace %s' %
        #       (focused.name, focused.workspace().name))


if __name__ == '__main__':
    setup_logger(logging.DEBUG)
    change_workspace()
