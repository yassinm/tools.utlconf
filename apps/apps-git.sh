UTLAPPS_git_init(){
   alias git-alias="alias | grep git | sort"

   alias git-br-list="git branch"
   alias git-br-all="git branch -v -a"
   alias git-br-new="git checkout -b"

   alias git-reset-soft="git reset --soft"
   alias git-reset-hard="git reset --hard"
   alias git-reset-mixed="git reset --mixed"

   alias git-clean-show="git clean -ndx"
   alias git-clean-force="git clean -fdx"

   alias git-pending="git status --porcelain | awk '{print $2}'"

   alias git-br-master="git checkout master"
   alias git-br-status="git status && git log -3 --oneline"
   alias git-br-log="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an)%Creset' --abbrev-commit"
   alias git-br-log="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd, %an)%Creset' --abbrev-commit --date=local"

}
