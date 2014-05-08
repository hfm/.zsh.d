# ========================================================
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||a |||u |||t |||o |||- |||f |||u |||. |||z |||s |||h ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#                                                         
# ========================================================
source $HOME/.zsh.d/packages/auto-fu.zsh/auto-fu.zsh
zle-line-init () {auto-fu-init;}; zle -N zle-line-init
zstyle ':completion:*' completer _oldlist _complete
zle -N zle-keymap-select auto-fu-zle-keymap-select
