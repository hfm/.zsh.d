# read function.zsh beforehand
if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --match-method migemo --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }
    zle -N percol_select_history
    bindkey '^R' percol_select_history

    function ppgrep() {
        if [[ $1 == "" ]]; then
            PERCOL=percol
        else
            PERCOL="percol --query $1"
        fi
        ps aux | eval $PERCOL | awk '{ print $2 }'
    }

    function ppkill() {
        ps ax | percol | awk '{ print $1 }' | xargs kill
    }

    ### http://piyopiyoducky.net/blog/2013/08/17/cdr-with-percol/
    ### search a destination from cdr list
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ':chpwd:*' recent-dirs-default yes
    zstyle ':completion:*' recent-dirs-insert both

    function percol-get-destination-from-cdr() {
        cdr -l | \
            sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
            percol --match-method migemo --query "$LBUFFER"
    }

    ### search a destination from cdr list and cd the destination
    function percol-cdr() {
        local destination="$(percol-get-destination-from-cdr)"
        BUFFER="cd $destination"
        CURSOR=$#BUFFER
        zle -R -c
    }
    zle -N percol-cdr
    bindkey '^@' percol-cdr
fi
