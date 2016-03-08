#/bin/bash

UTLAPPS_sublime_init(){
   alias sublime-alias='alias | grep sublime'
}

UTLAPPS_sublime_env(){
   SUBLIME_VERSION="sublime_text_3"
   SUBLIME_HOME="${UTL3RDP_APPS}/sublime/${SUBLIME_VERSION}"
   export PATH=${SUBLIME_HOME}:${PATH}
}

UTLAPPS_sublime_proxy(){
   local sublime=
}
