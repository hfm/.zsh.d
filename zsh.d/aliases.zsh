#  ____ ____  ____
# | __ ) ___||  _ \
# |  _ \___ \| | | |
# | |_) |__) | |_| |
# |____/____/|____/

alias cp="cp -i"
alias du="du -h"
alias df="df -h"
alias grep="grep --color"
alias ll="ls -hal"
alias mv="mv -i -v"
alias rl="/usr/local/bin/r"
alias rm="rm -i"
alias vi="vim"
alias gitignoring="~/.junk/gitignore_reloaded.sh"
alias -s {txt,md,markdown,xml}=lv
alias -s py=python
alias -s hs=runhaskell
alias be="bundle exec"

#   ___  ____   __  __
#  / _ \/ ___|  \ \/ /
# | | | \___ \   \  /
# | |_| |___) |  /  \
#  \___/|____/  /_/\_\

if [ `uname -s` = "Darwin" ]; then
# Homebrew
alias bu="brew update"
alias br="brew upgrade"
alias bs="brew -S"
alias bi="brew info"

# Preview
alias preview='open -a Preview'
alias -s {gif,png,jpg,bmp,pdf,GIF,PNG,JPG,BMP,PDF}=preview

# Chrome
alias google-chrome='open -a Google\ Chrome'
alias chrome='google-chrome'
alias -s html=chrome
alias git=hub
alias gitPullReq='git pull-request'
alias weechat-curses='TERM=screen-256color weechat-curses'

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
  *.tar.xz) tar Jxvf $1;;
  *.zip) unzip $1;;
  *.lzh) lha e $1;;
  *.tar.bz2|*.tbz) tar xjvf $1;;
  *.tar.Z) tar zxvf $1;;
  *.gz) gzip -dc $1;;
  *.bz2) bzip2 -dc $1;;
  *.Z) uncompress $1;;
  *.tar) tar xvf $1;;
  *.arj) unarj $1;;
  esac
}

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
function runcpp () { g++ -O2 $1; ./a.out }
alias -s {c,cpp}=runcpp
fi


#  _     _                  
# | |   (_)_ __  _   ___  __
# | |   | | '_ \| | | \ \/ /
# | |___| | | | | |_| |>  < 
# |_____|_|_| |_|\__,_/_/\_\

if [ `uname -s` = "Linux" ]; then

fi

