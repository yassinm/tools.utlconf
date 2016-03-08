UTLAPPS_vscode_install(){
  #for spelling make sure you do this
  ln -s /usr/share/hunspell ~/.config/Code/Dictionaries
  ln -s /usr/share/hunspell ~/.config/Code\ -\ Insiders/Dictionaries
}

UTLAPPS_vscode_install(){
  (
    set +x
      sudo apt-get install liballegro5-dev libicu-dev libtinyxml2-dev cmake build-essential git libunwind8-dev
  )
}
