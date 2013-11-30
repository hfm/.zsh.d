alias be='bundle exec'
alias cp='cp -i'
alias du='du -h'
alias df='df -h'
alias grep='grep --color'
alias ll='ls -hal'
alias mv='mv -i -v'
alias rm='rm -i'
alias ssh='TERM=xterm ssh'
alias vi='vim'
alias -s {txt,md,markdown,xml}=lv

#                .-')   ) (`-.      
#               ( OO ).  ( OO ).    
#  .-'),-----. (_)---\_)(_/.  \_)-. 
# ( OO'  .-.  '/    _ |  \  `.'  /  
# /   |  | |  |\  :` `.   \     /\  
# \_) |  |\|  | '..`''.)   \   \ |  
#   \ |  | |  |.-._)   \  .'    \_) 
#    `'  '-'  '\       / /  .'.  \  
#      `-----'  `-----' '--'   '--' 
if [ `uname -s` = 'Darwin' ]; then
  alias bu='brew update'
  alias bi='brew info'
  alias br='brew upgrade'
  alias bs='brew -S'

  alias preview='open -a Preview'
  alias -s {gif,png,jpg,bmp,pdf,GIF,PNG,JPG,BMP,PDF}=preview

  alias chrome='open -a Google\ Chrome'
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
  function runcpp () {
    g++ -O2 $1;
    ./a.out
  }
  alias -s {c,cpp}=runcpp
fi
