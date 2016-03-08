#!/bin/bash

if [ "${1}" = "local" ] ; then
    google-chrome ${UTL_PROXYPACK_URL}
elif [ "${1}" = "vnc" ] ; then
    #http://superuser.com/questions/166479/force-chrome-to-open-new-pages-in-new-window-not-tab-when-opened-from-a-progr/166494
    google-chrome ${UTL_PROXYPACK_URL} "--user-data-dir=${HOME}/.google-chrome/session${DISPLAY}"
fi
