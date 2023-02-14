# README

## Installation

```shell
sudo apt install neovim
```

## Config Path

```shell
vim ~/.config/nvim/init.vim
```

## Vim plugins

<https://github.com/junegunn/vim-plug>

```shell
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

```shell
:PlugInstall
:checkhealth # May need to install python pyx and neovim for different versions
```
