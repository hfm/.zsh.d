#            (`-')  _<-. (`-')_  (`-')  _   (`-')  (`-')  _           
#     .->    ( OO).-/   \( OO) ) ( OO).-/<-.(OO )  (OO ).-/    <-.    
#  ,---(`-')(,------.,--./ ,--/ (,------.,------,) / ,---.   ,--. )   
# '  .-(OO ) |  .---'|   \ |  |  |  .---'|   /`. ' | \ /`.\  |  (`-') 
# |  | .-, \(|  '--. |  . '|  |)(|  '--. |  |_.' | '-'|_.' | |  |OO ) 
# |  | '.(_/ |  .--' |  |\    |  |  .--' |  .   .'(|  .-.  |(|  '__ | 
# |  '-'  |  |  `---.|  | \   |  |  `---.|  |\  \  |  | |  | |     |' 
#  `-----'   `------'`--'  `--'  `------'`--' '--' `--' `--' `-----'  

if [ $(uname) = "Linux" ]; then
    alias ls="ls --color=auto --almost-all --classify"
else
    alias ls="ls -AFG"
fi
alias ll='ls -hl'

alias cp='cp -i'
alias du='du -h'
alias df='df -h'
alias grep='grep --color'

alias mv='mv -i -v'
alias rm='rm -i'
alias vi='vim'
alias -s {txt,md,markdown,xml}=lv

if exists hub;then
    alias git=hub
    alias gitpr='git pull-request'
fi

extract() {
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

#                .-')   ) (`-.      
#               ( OO ).  ( OO ).    
#  .-'),-----. (_)---\_)(_/.  \_)-. 
# ( OO'  .-.  '/    _ |  \  `.'  /  
# /   |  | |  |\  :` `.   \     /\  
# \_) |  |\|  | '..`''.)   \   \ |  
#   \ |  | |  |.-._)   \  .'    \_) 
#    `'  '-'  '\       / /  .'.  \  
#      `-----'  `-----' '--'   '--' 

if [ $(uname -s) = "Darwin" ]; then
    alias bu='brew update'
    alias bi='brew info'
    alias br='brew upgrade --all'
    alias bs='brew -S'

    alias preview='open -a Preview'
    alias -s {gif,png,jpg,bmp,pdf,GIF,PNG,JPG,BMP,PDF}=preview

    alias chrome='open -a Google\ Chrome'
    alias -s html=chrome

    alias weechat='TERM=screen-256color weechat'
fi
