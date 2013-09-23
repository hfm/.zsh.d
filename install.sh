#!/bin/sh

cat <<'EOF'

,--.,--.        ,--.    ,--.                            
|  |`--',--,--, |  |,-. `--',--,--,  ,---.              
|  |,--.|      \|     / ,--.|      \| .-. |             
|  ||  ||  ||  ||  \  \ |  ||  ||  |' '-' '.--..--..--. 
`--'`--'`--''--'`--'`--'`--'`--''--'.`-  / '--''--''--' 
                                    `---'               

EOF

ln -sF $HOME/.dotfiles/myzsh/zlogin $HOME/.zlogin
ln -sF $HOME/.dotfiles/myzsh/zshenv $HOME/.zshenv
ln -sF $HOME/.dotfiles/myzsh/zshrc  $HOME/.zshrc
ln -sF $HOME/.dotfiles/myzsh/zsh.d  $HOME/.zsh.d
ls -hal ~/.zsh{.d,env,rc} ~/.zlogin

cat <<'EOF'

   ,--.                       
 ,-|  | ,---. ,--,--,  ,---.  
' .-. || .-. ||      \| .-. : 
\ `-' |' '-' '|  ||  |\   --. 
 `---'  `---' `--''--' `----' 

EOF

