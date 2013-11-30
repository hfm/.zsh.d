umask 002
bindkey -e

autoload -Uz add-zsh-hook
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt auto_param_keys
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
setopt prompt_subst
setopt pushd_ignore_dups
setopt zle


# completions
fpath=(~/.zsh.d/packages/zsh-completions/src $fpath)

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
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## sheet
# http://blog.glidenote.com/blog/2012/04/16/sheet/
compdef _sheets sheet
function _sheets {
  local -a cmds
  _files -W  ~/.sheets/ -P '~/.sheets/'
 
  cmds=('list' 'edit' 'copy')
  _describe -t commands "subcommand" cmds
 
  return 1;
}


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
