UTLAPPS_gitconf_init(){
  alias git-conf-global="UTLAPPS_gitconf_global"
  alias git-conf-yassinm="UTLAPPS_gitconf_yassinm"
}

UTLAPPS_gitconf_yassinm(){
  git config --local user.name "yassinm"
  git config --local user.email "yassinm_tw@gmail.com"
}

UTLAPPS_gitconf_global(){

  if [ -e ~/.gitconfig ] ; then
    sed -i '\:#globalStart:,\:#globalEnd:d' ~/.gitconfig
  fi

  git config --global core.autocrlf input
  # git config --global url.ssh://git@github.com/hypersuite/.insteadOf https://github.com/hypersuite/

cat <<"E_O_F">>~/.gitconfig

#globalStart
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

[push]
  # git push` instead of `git push --set-upstream origin BRANCH-123`
  #default = current

[pull]
  # git pull` instead of `git pull --set-upstream origin BRANCH-123`
  #default = current

[url "ssh://git@github.com/hypersuite/"]
	insteadOf = https://github.com/hypersuite/

[url "ssh://git@github.com/yassinm/"]
	insteadOf = https://github.com/yassinm/

[alias]
  s = status
  b = branch
  t = tag -l
  a = branch -av
  m = checkout master
  l = log -10 --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd, %an %ae)%Creset' --abbrev-commit --date=local

  co = checkout
  cp = cherry-pick --no-commit
  wip = commit --amend --no-edit

  pending = status --porcelain

  #git worktree add ../wspace-reviews FEATURE-10738
  
  #force push to master
  #git push -f <remote-name> HEAD:master

  #force push to master
  #git push -f <remote-name> HEAD:master

  #force push to an experimental branch
  #git push -f <remote-name> HEAD:exp/yassinm/projectname
  
  #add remote
  #git remote add localgit ssh://ymo@192.168.2.21:29418/local.utlconf.git

  uall = remote -v
  uset = !git branch --set-upstream-to
  uget = rev-parse --abbrev-ref --symbolic-full-name @{u}
  #uorigin = !git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`

  gr1 = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an)%Creset' --abbrev-commit
  # gr+time, which may be so long that it wraps lines
  gr2 = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd, %an)%Creset' --abbrev-commit --date=local

  # see http://stackoverflow.com/a/16740731/152061
  #delbr = !sh -c 'git branch -D $1 && git push origin --delete $1' -

#globalEnd
E_O_F
}
