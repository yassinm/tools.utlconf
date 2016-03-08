#!/bin/bash

UTLDEV_nuclide_init(){
    alias nuclide-18='UTLDEV_nuclide_18 && atom'
}

UTLDEV_nuclide_env(){
    UTLNUCLIDE_ROOT="${UTL3RDP_APPS}/nuclide"
}

UTLDEV_nuclide_18(){
    UTLDEV_nuclide_env
    UTLATOM_conf ${UTLNUCLIDE_ROOT}/atom-1.8.0-amd64
}
