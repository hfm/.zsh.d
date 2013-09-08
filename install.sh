#!/bin/sh

echo linking...
ln -sf $HOME/.dotfiles/myzsh/zlogin $HOME/.zlogin
ln -sf $HOME/.dotfiles/myzsh/zshenv $HOME/.zshenv
ln -sf $HOME/.dotfiles/myzsh/zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/myzsh/zsh.d $HOME/.zsh.d
echo done.
