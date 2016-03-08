UTLI3_apps_init(){
    l=UTLAPPS_intellij_env

    #echo 000
    #UTLI3_i3_app android-2-0 "2 dev1" "${ANDROID_ROOT}/${ANDROID_2_0}/bin/studio.sh"
    #UTLI3_i3_app intellij-15 "2 dev1" "${INTELLIJ_ROOT}/${ideaVersion15}/bin/idea.sh"

}

UTLI3_i3_bin(){
    local mod_name="${1}"
    local mod_path="${2}"
    local bin_path="${I3CFG_BIN}/${mod_name}.sh"

cat << E_O_F > ${bin_path}
#!/bin/bash
source ${UTLI3_HOME}/utlapps.sh
UTLI3_init
${mod_path}
E_O_F

    chmod u+x ${bin_path}

}

UTLI3_i3_app(){
    local mod_name="${1}"
    local mod_wspace="${2}"
    local mod_fname="${3}"

    UTLI3_i3_bin ${mod_name} "${mod_fname}"

    local bin_path="${I3CFG_BIN}/${mod_name}.sh"
    local apps_path="${I3CFG_APPS}/apps-${mod_name}"

cat << E_O_F > ${apps_path}
#!/bin/bash
/usr/bin/i3-msg "workspace number ${mod_wspace}; exec ${bin_path}"
E_O_F

    chmod u+x ${apps_path}

}
