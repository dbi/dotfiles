# dbi dotfiles

This project was made to make it easy to install my mac configruation on a new computer.

## To install

    ln -s ~/whereeveryouputit ~/.dotfiles
    ln -s ~/.dotfiles/gitignore ~/.gitignore
    ln -s ~/.dotfiles/railsrc ~/.railsrc
    ln -s ~/.dotfiles/rvmrc ~/.rvmrc
    ln -s ~/.dotfiles/irbrc ~/.irbrc
    ln -s ~/.dotfiles/gemrc ~/.gemrc
    ln -s ~/.dotfiles/screenrc ~/.screenrc
    touch ~/.bash_profile && echo "source ~/.dotfiles/bash_profile" >> ~/.bash_profile
