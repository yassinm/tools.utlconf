UTLAPPS_gitutl_init(){
  alias git-utl-squash="UTLAPPS_gitutl_squash"
  alias git-utl-mkrepo="UTLAPPS_gitutl_mkrepo"
}

UTLAPPS_gitutl_branching(){
  #create a new branch from where you are
  git checkout -b BRANCH-1234-backup
  git checkout BRANCH-1234
  #if something goes wrong reset BRANCH-1234  so it points back to BRANCH-1234-backup

}

UTLAPPS_gitutl_squash(){
    local tag=${1}
    if [ -z ${tag} ] ; then
       echo "tag index must be provided" ; return 1
    fi

    local tagMessage=${2}
    if [ -z ${tagMessage} ] ; then
       echo "A commit message provided" ; return 1
    fi

    git add . &&
      git reset --soft ${tag} &&
      git commit -m "${tagMessage}"

}

UTLAPPS_gitutl_mkrepo(){
  (
    set -e
    if [ -e .git ] ; then
      echo ".git directory already exists"; return
    fi

    git init
    git add .gitignore

    git config --local user.name "Yassin Mohamed"
    git config --local user.email "yassinm@yassinm.github.io"

    git commit -m "Initial import"

  )
}
