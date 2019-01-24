#   (`-')   (`-').-> (`-').-> (`-')  _<-. (`-')_      (`-')
#   ( OO).->( OO)_   (OO )__  ( OO).-/   \( OO) )    _(OO )
# ,(_/----.(_)--\_) ,--. ,'-'(,------.,--./ ,--/,--.(_/,-.\
# |__,    |/    _ / |  | |  | |  .---'|   \ |  |\   \ / (_/
#  (_/   / \_..`--. |  `-'  |(|  '--. |  . '|  |)\   /   /
#  .'  .'_ .-._)   \|  .-.  | |  .--' |  |\    |_ \     /_)
# |       |\       /|  | |  | |  `---.|  | \   |\-'\   /
# `-------' `-----' `--' `--' `------'`--'  `--'    `-'

# typeset -U path
## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。
## thanks for http://www.clear-code.com/blog/2011/9/5.html
# path=(# システム用
#       /bin(N-/)
#       )

# general
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

# Homebrew
if [ -d /opt/brew ]; then
    export BREW_PATH=/opt/brew
elif [ -f /usr/local/bin/brew ]; then
    export BREW_PATH=/usr/local
fi

if [[ $PATH != *"/usr/local"* ]]; then
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

if [[ $PATH != *"${BREW_PATH}"* ]]; then
    export PATH="${BREW_PATH}/bin":"${BREW_PATH}/sbin":$PATH
fi

export SHELL="${BREW_PATH}/bin/zsh"
export EDITOR=vim
export VIMRUNTIME="${BREW_PATH}/share/vim/vim81"
export TERM=xterm-256color
export PATH=$HOME/bin:$PATH

if [ -d "${BREW_PATH}/opt/coreutils/libexec/gnubin" ]; then
    export PATH="${BREW_PATH}/opt/coreutils/libexec/gnubin:$PATH"
fi

# color
export CLICOLOR=1
export LSCOLORS=cxfxdxdxbxegedabagacad
export LS_COLORS='di=32:ln=35:so=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS

# anyenv
type anyenv &>/dev/null
if [ $? -eq 0 ]; then
    eval "$(anyenv init --no-rehash - zsh)"
elif [ -f ~/.anyenv/bin/anyenv ]; then
    export PATH=$HOME/.anyenv/bin:$PATH
    eval "$(anyenv init --no-rehash - zsh)"
fi

[ -f ~/.cargo/env ] && source $HOME/.cargo/env

# golang
#   https://gist.github.com/ivanzoid/3477252
#   http://python.matrix.jp/2013/05/09/go_start1.html
type go &>/dev/null
if [ $? -eq 0 ]; then
    export GOPATH=$HOME
fi

#lynx
[ -f $HOME/.lynx.lss ] && export LYNX_LSS=$HOME/.lynx.lss
