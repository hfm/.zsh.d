# ========================================================
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||a |||u |||t |||o |||- |||f |||u |||. |||z |||s |||h ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#                                                         
# ========================================================
source $ZDOTDIR/packages/auto-fu.zsh/auto-fu.zsh
zle-line-init () {auto-fu-init;}; zle -N zle-line-init
zstyle ':completion:*' completer _oldlist _complete

zstyle ':auto-fu:var' postdisplay ''
zstyle ':auto-fu:var' autoable-function/skiplines '*rake *' 'gem *' 'git log *' 'git commit *' 'scp *'  'svn commit *' 'cap *'
zle -N zle-keymap-select auto-fu-zle-keymap-select

# ========================================================
#  ____ ____ ____ ____ ____ ____                          
# ||g |||o |||l |||a |||n |||g ||                         
# ||__|||__|||__|||__|||__|||__||                         
# |/__\|/__\|/__\|/__\|/__\|/__\|                         
#                                                         
# ========================================================
# source $(brew --cellar zsh)/*/share/zsh/functions/_go
