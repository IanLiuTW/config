# Oh My Zsh

## ****Installation****

<https://ohmyz.sh/>

<https://github.com/ohmyzsh/ohmyzsh/wiki/Themes>

<https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins>

### Install Font

```shell
brew tap homebrew/cask-fonts && brew install --cask font-caskaydia-cove-nerd-font
```

## Configuration

- Install `zsh-autosuggestions` and `zsh-syntax-highlighting`
```
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#in-your-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- Copy the `.zshrc` file

```shell
vim ~/.zshrc
```

- Optional: `fzf`

<https://github.com/junegunn/fzf?tab=readme-ov-file>

