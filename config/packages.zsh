# -*- sh -*-

source ~/.zsh.d/package.zsh


# zaw
package-install github zsh-users/zaw

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

source $(package-directory zsh-users/zaw)/zaw.zsh

zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' max-lines 10
zstyle ':filter-select' max-lines -10
zstyle ':filter-select:highlight' matched fg=yellow,standout

bindkey '^@' zaw-cdr
bindkey '^R' zaw-history

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
