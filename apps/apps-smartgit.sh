#/bin/bash

UTLAPPS_smartgit_init(){
    UTLAPPS_smartgit_env
    alias smartgit-7-0="${UTL3RDP_APPS}/smartgit/${smartgitVersion}/bin/smartgit.sh &"
}

UTLAPPS_smartgit_env(){
    smartgitVersion="smartgit-7.0.4"
}

