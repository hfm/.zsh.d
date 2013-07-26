# perl
if [ -f ~/.plenv/bin/plenv ]; then
  export PATH=$HOME/.plenv/bin:$PATH
  eval "$(plenv init - zsh)"
fi

# python
if [ -f ~/.pyenv/bin/pyenv ]; then
  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
  eval "$(pyenv init - zsh)"
fi

# ruby
if [ -f ~/.rbenv/bin/rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init - zsh)"
fi

# nodejs
if [ -d ~/.nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  export NODEBREW_ROOT=$HOME/.nodebrew
fi
