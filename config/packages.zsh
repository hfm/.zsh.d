# -*- sh -*-

source ~/.zsh.d/package.zsh

# zsh-completions
package-install github zsh-users/zsh-completions

# auto-fu
package-install github hchbaw/auto-fu.zsh
source $(package-directory hchbaw/auto-fu.zsh)/auto-fu.zsh
zle-line-init () {auto-fu-init;}; zle -N zle-line-init
zstyle ':completion:*' completer _oldlist _complete
zle -N zle-keymap-select auto-fu-zle-keymap-select

# package-install github zsh-users/zsh-syntax-highlighting
# source $(package-directory zsh-users/zsh-syntax-highlighting)/zsh-syntax-highlighting.zsh
