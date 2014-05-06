_percol_clean_prompt() {
    if [[ -n $TMUX ]]; then
        zle reset-prompt
    else
        zle -R -c
    fi
}

percol_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    output=$(fc -l -n 1 | eval $tac | percol --match-method migemo --query "$LBUFFER")

    if [ "$output" -n ]; then
        BUFFER=$output
        CURSOR=$#BUFFER
    fi

    _percol_clean_prompt
}
zle -N percol_select_history
bindkey '^R' percol_select_history

### http://piyopiyoducky.net/blog/2013/08/17/cdr-with-percol/
### search a destination from cdr list
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

percol-get-destination-from-cdr() {
    cdr -l | \
        sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
        percol --match-method migemo --query "$LBUFFER"
}

### search a destination from cdr list and cd the destination
percol-cdr() {
    local destination="$(percol-get-destination-from-cdr)"
    BUFFER="cd $destination"
    CURSOR=$#BUFFER
    _percol_clean_prompt
}
zle -N percol-cdr
bindkey '^@' percol-cdr

# =========================================================
#                                                      _   
#    __      ___    _ __    _ __    __ _    _ _     __| |  
#   / _|    / _ \  | '  \  | '  \  / _` |  | ' \   / _` |  
#   \__|_   \___/  |_|_|_| |_|_|_| \__,_|  |_||_|  \__,_|  
# _|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| 
# "`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' 
# =========================================================

ppgrep() {
    if [ -z $1 ]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""
    else
        QUERY=$1
        [[ $# > 0 ]] && shift
    fi

    ppgrep $QUERY | xargs echo $*
}
