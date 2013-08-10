# -*- sh -*-

source ~/.zsh.d/package.zsh

# auto-fu
package-install github hchbaw/auto-fu.zsh
if [ ! -f ~/.zsh.d/zcompiled/auto-fu.zwc ]; then
  A=$(package-directory hchbaw/auto-fu.zsh)/auto-fu.zsh
  (zsh -c "source $A;auto-fu-zcompile $A ~/.zsh.d/zcompiled")
fi

## for version < 4.3.10
bindkey -N isearch

{ . ~/.zsh.d/zcompiled/auto-fu; auto-fu-install; }

## setting
zle -N zle-keymap-select auto-fu-zle-keymap-select
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=black,bold
zstyle ':auto-fu:highlight' completion/one fg=white,bold
zstyle ':auto-fu:var' postdisplay $'\n-azfu-'
zstyle ':auto-fu:var' disable magic-space
zstyle ':completion:*' completer _oldlist _complete

## initialize
zle-line-init() { auto-fu-init; }; zle -N zle-line-init


# zaw
package-install github zsh-users/zaw
source $(package-directory zsh-users/zaw)/zaw.zsh

## cdr
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

## zaw-src-cdr
zstyle ':filter-select:highlight' matched fg=yellow,standout
zstyle ':filter-select' max-lines 10 # use 10 lines for filter-select
zstyle ':filter-select' max-lines -10 # use $LINES - 10 for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search
bindkey '^@' zaw-cdr
bindkey '^R' zaw-history


# zsh-syntax-highlighting
#package-install github zsh-users/zsh-syntax-highlighting
#source $(package-directory zsh-users/zsh-syntax-highlighting)/zsh-syntax-highlighting.zsh

# zsh-completions
package-install github zsh-users/zsh-completions
