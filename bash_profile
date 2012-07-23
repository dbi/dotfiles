# vim: set filetype=sh

function conflict {
  git st |grep both|awk '{print $3}'|xargs $EDITOR
}

# http://railstips.org/blog/archives/2009/02/02/bedazzle-your-bash-prompt-with-git-info/
function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [ ref ]; then
    echo " "${ref#refs/heads/}""
  fi
}

# display current git branch and possibly git author
function parse_git_branch {
  BRANCH=$(git symbolic-ref HEAD 2> /dev/null | awk -F"/" '{ print $3 }')
  if [ -z $GIT_AUTHOR_EMAIL ]; then
    USER=$(git config --get user.email)
  else
    USER=$GIT_AUTHOR_EMAIL
  fi
  USER=${USER%%@*}
  if [ $USER = "david.billskog" -o $USER = "billskog" ]; then
    [[ $BRANCH ]] && echo " $BRANCH"
  else
    [[ $BRANCH ]] && echo " $USER@$BRANCH"
  fi
}

YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
BLUE="\[\033[0;34m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
WHITE="\[\033[1;37m\]"
NO_COLOUR="\[\033[0m\]"

export PS1="$YELLOW\w$GREEN\$(parse_git_branch)$NO_COLOUR$ "
export CLICOLOR='true'
export LSCOLORS=fxgxcxdxbxegedabagacfx
export EDITOR=vim
export LESS="-r"

# make bash autocomplete with up arrow/down arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# readline settings
bind "set completion-ignore-case on" 
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# vim bindings in bash
#set -o vi

# git stuff http://www.benmabey.com/2008/05/07/git-bash-completion-git-aliases/
source ~/.dotfiles/autocomplete/git-completion.bash
complete -o default -o nospace -F _git_checkout gco

alias grep="grep --color=auto"
alias preview="open -a /Applications/Preview.app/"
alias safari="open -a /Applications/Safari.app/"
alias firefox="open -a /Applications/Firefox.app/"
alias gitx="open -a GitX ."
alias t="term -t"
alias ttr="touch tmp/restart.txt"
alias testbot="bundle exec rake testbot:rspec 2>&1 | tee /tmp/output.txt | grep \"^\(Finished.*\.$\|rspec\|\d\+ examples\)\""
alias gitbr='for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1`\\t$k;done|sort -r'

# common
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -GhF'
alias l='ls -GlAhF'
alias ll='ls -GlAhFtr'
alias ..='cd ..'
alias ...='cd ../..'
alias ?='echo $?'
alias ps?='ps ax | grep '
alias fn='find . -name'
alias hi='history | tail -20'
alias du1='du -h -d 1'
alias sd='svn diff > /tmp/svn.diff;mate /tmp/svn.diff'
alias gco='git co'

# open Textmate with only the dirs we normally want to work with
alias e='mate `ls -Fa | grep -v .svn/ | grep -v .git/ | grep -v script/ | grep -v .DS_Store | grep -v _site/ | grep -v log/ | grep -v tmp/ | grep -v vendor/ | grep -v "\./"`'
alias er='mate README app/ config/ db/ lib/ public/ test/ spec/ vendor/plugins .gems '

# Make it possible to send SIGQUIT on swedish keyboards (used in the rugy gem guard)
stty quit "^R"

# Make less play nice with git
export LESS="-F -X -R"
