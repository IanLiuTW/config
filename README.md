# config

## Quick Setup

- This repo needs to be in the home directory.
- See `/_scripts/dev_env` for setup scripts.

```bash
git clone https://github.com/IanLiuTW/config ~/config && chmod +x ~/config/_scripts/dev_env/setup_apt.sh && ~/config/_scripts/dev_env/setup_apt.sh
```

```bash
# For MacOS ann additional tools
cd ~/config
stow kitty hammerspoon lazygit
```

## Detailed Setup

### asdf

- [https://asdf-vm.com/]
Use asdf as the tool version manager. Use `rustup` for Rust.

### Stow

- [GNU Stow](https://www.gnu.org/software/stow/)

Use Stow to install the configs. (Need to place this config repo in the home directory)

- Arch: Run `sudo pacman -S stow`
- Homebrew: Run `brew install stow`
- Others: do search

### Zsh

- [https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH]

- On Arch: [https://wiki.archlinux.org/title/Zsh]

#### Prompts

##### Starship

- [Starship](https://starship.rs/)

##### powerlevel10k

- [https://github.com/romkatv/powerlevel10k] (Optional)

### CLI Tools

#### fzf

- [https://github.com/junegunn/fzf]

#### zoxide

- [https://github.com/ajeetdsouza/zoxide]

#### eza

- [https://github.com/eza-community/eza/blob/main/INSTALL.md]

#### Others

- ripgrep: [https://github.com/BurntSushi/ripgrep]
- jq: [https://stedolan.github.io/jq/]
- fd: [https://github.com/sharkdp/fd]
- bat: [https://github.com/sharkdp/bat]

### Neovim

- [https://github.com/neovim/neovim]

## Choose your Font

- [https://github.com/ryanoasis/nerd-fonts], [https://www.nerdfonts.com/]

## Choose your terminal emulator

### Kitty (Recommended)

- [https://sw.kovidgoyal.net/kitty/]

### WezTerm (Maybe on Windows WSL)

- [https://wezfurlong.org/wezterm/index.html]

- There's a different config for Window's WSL

## Additional Setup

### Git Tools

#### Gitbutler

- [https://gitbutler.com]

#### lazygit (Optional)

- [https://github.com/jesseduffield/lazygit]

#### diff-so-fancy (Optional)

- [https://github.com/so-fancy/diff-so-fancy]

### File System

#### Yazi

- [https://yazi-rs.github.io/docs/installation/]

### Monitoring

#### btytop

- [https://github.com/aristocratos/bpytop]

### Docker Tools

#### lazydocker (Optional)

- [https://github.com/jesseduffield/lazydocker]

### Docker & Tools

#### Docker

- [https://www.docker.com/]

#### DevPod

- [https://devpod.sh/] for devcontainer and more

### API Tools

#### Postman

- [https://www.postman.com/]

### Database Tools

#### DbVisualizer

- [https://www.dbvis.com/]

#### MangoDB Compass

- [https://www.mongodb.com/products/compass]

### AI Tools

#### ChatGPT

- [https://openai.com/chatgpt/download/]

### Dev Tools

- [https://devtoys.app/]

## MacOS Area

### Automation

#### HammerSpoon

- [https://www.hammerspoon.org/]

- Use `Hammerspoon` for kitty to have a iTerm2 hotkey window experience on MacOS

## Not currently in use

### VS Code

- [Visual Studio Code](https://code.visualstudio.com/download)

### Zed

- [Zed](https://zed.dev/)

### Zellij (use kitty if possible)

- [https://github.com/zellij-org/zellij]

### lsd

- [https://github.com/lsd-rs/lsd]
