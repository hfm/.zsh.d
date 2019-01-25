umask 002
bindkey -e

autoload -Uz add-zsh-hook
setopt auto_cd
setopt auto_menu
setopt auto_param_keys
setopt auto_pushd
setopt auto_remove_slash
setopt complete_aliases
setopt correct
setopt extended_glob
setopt ignore_eof
setopt list_packed
setopt list_types
setopt long_list_jobs
setopt magic_equal_subst
setopt no_beep
setopt no_flow_control
setopt no_global_rcs
setopt prompt_subst
setopt pushd_ignore_dups
setopt zle


# completions
fpath=($ZDOTDIR/packages/my-zsh-completions/src $ZDOTDIR/packages/zsh-completions/src $fpath)
[ -d "${BREW_PATH}/share/zsh/site-functions" ] && fpath+="${BREW_PATH}/share/zsh/site-functions"

autoload -U compinit && compinit -u
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-separator '=>'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*:descriptions' format '%B[%d]%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches: %d'
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:sudo:*' command-path "${BREW_PATH}/sbin" "${BREW_PATH}/bin" /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# file separator
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# cdr list
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

HISTFILE=~/.backup/zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history #added timestamp
setopt hist_ignore_dups #ignore duplication command history list
setopt hist_ignore_all_dups #remove an older from history if duplication command.
setopt share_history #share command history data

[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
