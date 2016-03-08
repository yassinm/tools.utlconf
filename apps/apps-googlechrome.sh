
UTLAPPS_googlechrome_install(){
    #ubuntu17.04
    apt-get install -y libappindicator1  gconf-service libgconf-2-4 gconf2-common libappindicator1 gconf-service-backend libindicator7 
}

UTLAPPS_googlechrome_key(){
    Google changed the key . 
        to remove the old key ' sudo apt-key del 7FAC5991 ' .
        readd key 'wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - '

}
