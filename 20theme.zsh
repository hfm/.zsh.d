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
    git stash list &>/dev/null
    [ $? -eq 0 ] && psvar[2]=$(git stash list | wc -l | tr -d " ")
}
add-zsh-hook precmd _for_prompt

# http://kitak.hatenablog.jp/entry/2013/05/25/103059
zstyle ':vcs_info:*' enable git svn cvs
zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '%b[%c%u]'
zstyle ':vcs_info:git:*' actionformats '%b|%a[%c%u]'

perl_version=$(perl -v | awk '/perl 5/ {print $9}' | sed 's/[(|)]//g')
ruby_version=$(ruby -v | awk '{print $2}')
python_version=$(python -V 2>&1 | awk '{print $2}')

color_reset='%f'
color_cyan='%038F'
color_orange='%214F'
color_magenta='%164F'
color_lightgreen='%077F'
color_perl='%157F'
color_turquoise='%027F'

PROMPT='%n@%m '
PROMPT+="${color_cyan}[%~]${color_reset} "
PROMPT+="${color_orange}$([ -n "$TMUX" ] && tmux display -p "[#I-#P] ")${color_reset}" # >> http://yonchu.hatenablog.com/entry/20120413/1334341553
PROMPT+="${color_lightgreen}%2(v|(%1v @%2v) |)${color_reset}"
PROMPT+="${color_perl}[perl ${perl_version}]${color_reset} "
PROMPT+="${color_magenta}[ruby ${ruby_version}]${color_reset} "
PROMPT+="${color_turquoise}[python ${python_version}]${color_reset} "
PROMPT+=$'\n''%B$%b '
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
