# vim: set filetype=sh

# http://railstips.org/blog/archives/2009/02/02/bedazzle-your-bash-prompt-with-git-info/
function git_branch {
  ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ $? -eq 0 ]; then
    echo " "${ref}""
  fi
}

function hitch_pair {
  source ~/.hitch_export_authors
  if [ `git symbolic-ref HEAD 2> /dev/null` ] && [ -n "${GIT_AUTHOR_EMAIL:+1}" ]; then
    echo $GIT_AUTHOR_EMAIL|awk -F "[+@]" '{ print " "$2"+"$3 }'
  fi
}

function jsonf {
  python -mjson.tool
}

YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
BLUE="\[\033[0;34m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
WHITE="\[\033[1;37m\]"
DARK_GRAY="\[\033[1;30m\]"
GRAY="\[\033[0;37m\]"
NO_COLOUR="\[\033[0m\]"
YELLOW_GREEN="\[\033[38;5;148m\]"

# for((color=1;color<=255;color++)); do
#   echo -e "\033[38;5;${color}mCOLOR ${color}\033[39m"
# done

# Orange/brown/yellow set
COL1="\[\033[38;5;130m\]"
COL2="\[\033[38;5;172m\]"
COL3="\[\033[38;5;178m\]"
COL4="\[\033[38;5;220m\]"

# Yellow/green set
COL1="\[\033[38;5;136m\]"
COL2="\[\033[38;5;3m\]"
COL3="\[\033[38;5;112m\]"
COL4="\[\033[38;5;2m\]"

export PS1="$COL1\A $COL2\w$COL3\$(git_branch)$COL4\$(hitch_pair)$NO_COLOUR "
export CLICOLOR='true'
export LSCOLORS=fxgxcxdxbxegedabagacfx
export EDITOR=vim

# make bash autocomplete with up arrow/down arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# readline settings
bind "set completion-ignore-case on" 
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

alias grep="grep --color=auto"
alias preview="open -a /Applications/Preview.app/"
alias safari="open -a /Applications/Safari.app/"
alias firefox="open -a /Applications/Firefox.app/"
alias gitx="open -a GitX ."
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
alias ....='cd ../../..'
alias ps?='ps ax | grep '
alias fn='find . -name'
alias du1='du -h -d 1'
alias gco='git co'

# Make less play nice with git
export LESS="-F -X -R"

# Git autocomplete
complete -o default -o nospace -F _git g
