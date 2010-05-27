# http://railstips.org/blog/archives/2009/02/02/bedazzle-your-bash-prompt-with-git-info/
function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [ ref ]; then
    echo " "${ref#refs/heads/}""
  fi
}

function display_uncommon_user {
  if [ $LOGNAME != "david.billskog" -a $LOGNAME != "billskog" ]; then
  	echo "$LOGNAME "
  fi
}

WHITE="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"

#export PS1="$WHITE[\u@$CYAN\h $YELLOW\w$WHITE] $"
export PS1="$RED\$(display_uncommon_user)$YELLOW\w$GREEN\$(git_branch)$WHITE$ "

export CLICOLOR='true'
export LSCOLORS=fxgxcxdxbxegedabagacfx

# make bash autocomplete with up arrow/down arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# readline settings
bind "set completion-ignore-case on" 
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# git stuff http://www.benmabey.com/2008/05/07/git-bash-completion-git-aliases/
source ~/.dotfiles/autocomplete/git-completion.bash
complete -o default -o nospace -F _git_checkout gco

source ~/.dotfiles/autocomplete/rake_cap_bash_autocomplete.sh

alias grep="grep --color=auto"
alias preview="open -a /Applications/Preview.app/"
alias safari="open -a /Applications/Safari.app/"
alias firefox="open -a /Applications/Firefox.app/"

# common
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -GhF'
alias ll='ls -GlhF'
alias l='ls -GlAhFtr'
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

# Rails
alias ss='script/server'
alias sc='script/console'
alias sg='script/generate'
alias sp='script/spec --color --loadby mtime --reverse'
alias rdm='rake db:migrate'
alias rdp='rake db:prepare'
alias rdr='rake db:rebuild'
alias rtp='rake db:test:prepare'
alias au='script/autospec'
alias auf='AUTOFEATURE=true script/autospec'

# brute force 'rake db:test:prepare', if you're using cucumber rails_env:
alias testreset='rake db:test:purge && rake db:test:prepare'
alias rcup='rake --trace db:drop db:create db:migrate db:seed RAILS_ENV=cucumber'
