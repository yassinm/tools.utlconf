UTLAPPS_gitcmd_init(){
  alias git-fixemail="UTLAPPS_gitcmd_fixemail"
}

UTLAPPS_gitcmd_conf_reset(){
   #to unset
   git config --global --unset http.proxy
   git config --global --unset https.proxy
}

UTLAPPS_gitcmd_build(){
    (
        set -ex
        ./configure --prefix=${PWD}.dist
        make PROFILE=BUILD \
           install install-doc install-html install-info
    )
}

UTLAPPS_gitcmd_rmignore(){
    git rm -r --cached .
    git add .
}

UTLAPPS_gitcmd_fixemail(){
  local toEmail=${2}
  local fromEmail=${1}
  local toAuth="Yassin Mohamed"

  local cmdFile="/tmp/gitFixemail.sh"
  local sedFile="/tmp/gitFixemail.sed"

  (
    set -e

    if [ -z ${fromEmail} ] ; then
       echo "fromEmail must be passed"
       return
    fi

    if ! [ -z ${toEmail} ] ; then
      toEmail="${toEmail}%%:*"
    else
      toEmail="yassinm_tw@gmail.com"
    fi

    local filterCmd='
  if [ "$GIT_AUTHOR_EMAIL" = "FROMEMAIL" ];
  then
          GIT_AUTHOR_NAME="TO_AUTHOR";
          GIT_AUTHOR_EMAIL="TO_EMAIL";
          git commit-tree "$@";
  else
          git commit-tree "$@";
  fi '

cat <<E_O_F>${sedFile}
s/TO_AUTHOR/${toAuth}/g
s/TO_EMAIL/${toEmail}/g
s/FROMEMAIL/${fromEmail}/g
E_O_F

    filterCmd=$(
      echo "${filterCmd}" | sed -f ${sedFile}
    )

cat <<E_O_F>${cmdFile}
git filter-branch -f --commit-filter '${filterCmd}' HEAD
E_O_F

    source ${cmdFile}
  )

}

UTLAPPS_gitcmd_dircmd(){
    #set -x

    local dPath=""
    local gitCmd=${1}
    if [ -z "${gitCmd}" ] ; then
       echo "gitCmd name must be provided" ; return
    fi

    local gitPath=${2}
    if [ -z "${gitPath}" ] ; then
       echo "gitPath name must be provided" ; return
    fi

    for dirPath in `find ${gitPath} -maxdepth 2 -type d -path "*/.git"` ; do {
        (
            local dPath="${dirPath%/*}"
            echo "| --- ${dPath}"
            cd ${dPath}
            ${gitCmd}
        )
    } done

    #set +x

}

UTLAPPS_gitcmd_tools(){
  if [ -e ~/.gitconfig ] ; then
    sed -i '\:#ideaStart:,\:#ideaEnd:d' ~/.gitconfig
  fi


cat <<"E_O_F">>~/.gitconfig
#ideaStart
[diff]
    tool = intellij

[difftool]
    prompt = false

[merge]
    tool = intellij

[difftool "intellij"]
    cmd = gittool.sh diff $LOCAL $REMOTE

[mergetool "intellij"]
    trustExitCode = true
    cmd = gittool.sh merge $LOCAL $REMOTE

#ideaEnd
E_O_F
}

UTLAPPS_gitcmd_global(){
    #git config --global -l
    #git config --global --unset url.https://github.com/.insteadOf

    git config --global core.autocrlf input

    #proxy settings
    if [ -z "${UTL_PROXY_HTTP_HOST}" ] ; then
        return
    fi

    set -x

    #http://www.itk.org/Wiki/Git/Trouble#Firewall_Blocks_Port_9418
    git config --global url."http://".insteadOf git://
    #git config --global url.https://github.com/.insteadOf git://github.com/

    git config --global http.proxy ${UTL_PROXY_HTTP_HOST}:${UTL_PROXY_HTTP_PORT}
    git config --global https.proxy ${UTL_PROXY_HTTPS_HOST}:${UTL_PROXY_HTTPS_PORT}

    set +x

}

UTLAPPS_gitcmd_br_merge_normal(){
   local branch_name=${1}
   if [ -z ${branch_name} ] ; then
      echo "branch_name was:${branch_name} and must be passed"
      return
   fi

   #git merge ${branch_name}
   git merge --no-commit ${@}
}

UTLAPPS_gitcmd_br_merge_latest(){
   local branch_name=${1}
   if [ -z ${branch_name} ] ; then
      echo "branch_name was:${branch_name} and must be passed"
      return
   fi

   git merge -s recursive -Xtheirs ${branch_name}
   #git merge -s recursive -Xtheirs --no-commit ${branch_name}
}
