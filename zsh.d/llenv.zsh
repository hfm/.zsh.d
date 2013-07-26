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
if [ -f ~/.ndenv/bin/ndenv ]; then
  export PATH=$HOME/.ndenv/bin:$HOME/.ndenv/shims:$PATH
  eval "$(ndenv init - zsh)"
fi
