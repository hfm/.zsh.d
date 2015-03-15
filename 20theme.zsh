# ,------.,------. ,-----.,--.   ,--,------.,--------.
# |  .--. |  .--. '  .-.  |   `.'   |  .--. '--.  .--'
# |  '--' |  '--'.|  | |  |  |'.'|  |  '--' |  |  |
# |  | --'|  |\  \'  '-'  |  |   |  |  | --'   |  |
# `--'    `--' '--'`-----'`--'   `--`--'       `--'

autoload -U colors && colors
autoload -Uz vcs_info
_for_prompt() {
    # git branch-name:
    # http://www.slideshare.net/tetutaro/zsh-20923001
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_

    # git stash-num:
    # http://qiita.com/items/13f85c11d3d0aa35d7ef
    local stash_num=$(git stash list 2>/dev/null | wc -l | tr -d " ")
    [ "$stash_num" -eq 0 ] || psvar[2]=$stash_num
}
add-zsh-hook precmd _for_prompt

# http://kitak.hatenablog.jp/entry/2013/05/25/103059
zstyle ':vcs_info:*' enable git svn cvs
zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "[+]"
zstyle ':vcs_info:git:*' unstagedstr "[-]"
zstyle ':vcs_info:git:*' formats '%b%c%u'
zstyle ':vcs_info:git:*' actionformats '%b|%a%c%u'

perl_version=$(perl -v | awk '/perl 5/ {print $9}' | sed 's/[(|)v]//g')
ruby_version=$(ruby -v | awk '{print $2}')
python_version=$(python -V 2>&1 | awk '{print $2}')
golang_version=$(go version 2>/dev/null | awk '{print $3}' | sed 's/go//')

# see also: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Visual-effects
color_reset='%f'
color_white='%255F'
color_cyan='%038F'
color_orange='%214F'
color_magenta='%164F'
color_vermilion='%203F'
color_lightgreen='%077F'
color_perl='%157F'
color_turquoise='%027F'
color_lightblue='%080F'
color_yellow='%226F'

# account and machine name
PROMPT="${color_white}%n@$(hostname):${color_reset} "
# current directory
PROMPT+="${color_yellow}%~${color_reset} "
# branch-name and status if repo.exist?
# see also: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Conditional-Substrings-in-Prompts
PROMPT+="%(v|${color_lightgreen}(%1v|)%2(V| @%2v|)%(v|)${color_reset} |)"
# see also: http://yonchu.hatenablog.com/entry/20120413/1334341553
PROMPT+="${color_orange}$([ -n "$TMUX" ] && tmux display -p "[#I-#P] ")${color_reset}"
# PROMPT+=$'\n'
PROMPT+='[ '
PROMPT+="${color_perl}pl:${perl_version}${color_reset} "
PROMPT+="${color_vermilion}rb:${ruby_version}${color_reset} "
PROMPT+="${color_turquoise}py:${python_version}${color_reset} "
PROMPT+="${color_lightblue}go:${golang_version}${color_reset} "
PROMPT+=']'
PROMPT+=$'\n'
PROMPT+='$ '
PROMPT2='%_> '
SPROMPT='Did you mean %B%001F%r%f%b? [n,y,a,e]: '

## rename window to repo-name
# http://blog.manaten.net/entry/tmux-repository
rename_tmux_window() {
    [ -n "$TMUX" ] || return
    LANG=en_US.UTF-8 vcs_info

    if [[ -n "${vcs_info_msg_0_}" ]]; then
        current_dir=${PWD##/*/}
        upper_dir=${${PWD%/*}##/*/}
        tmux rename-window "${upper_dir}/${current_dir}"
    elif [[ -n "$TMUX" ]]; then
        tmux rename-window $(uname -n)
    fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd rename_tmux_window

[ -n "$TMUX" ] && rename_tmux_window
