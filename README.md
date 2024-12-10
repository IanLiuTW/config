# config

## Quick Setup

- This repo needs to be in the home directory.
- Setup methods:

  1. Nix

  Use `nix` and `home-manager` for the setup. The files are in the `nix`, `nix-darwin` directories.

  - [Nix](https://nixos.org/download/)
  - [nix-community/home-manager](https://nix-community.github.io/home-manager/)

  2. Manual

  See `/_scripts/dev_env` for setup scripts, and/or pick and choose additional tools.

> Note to self: The Nix way is the main way and should be up-to-date. If go with the manual way, need to update the scripts.

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

- 7-Zip: [https://www.7-zip.org/]
- ripgrep: [https://github.com/BurntSushi/ripgrep]
- jq: [https://stedolan.github.io/jq/]
- fd: [https://github.com/sharkdp/fd]
- bat: [https://github.com/sharkdp/bat]

#### Others (Optional for file preview)

- ImageMagick (image thumbnails): [https://imagemagick.org/]
- ffmpegthumbnailer (video thumbnails): [https://github.com/dirkvdb/ffmpegthumbnailer]
- Poppler (pdf preview): [https://poppler.freedesktop.org/]

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

#### Raycast

- [https://raycast.com/]

#### HammerSpoon

- [https://www.hammerspoon.org/]

- Use `Hammerspoon` for kitty to have a iTerm2 hotkey window experience on MacOS

## Not currently in use

### Stow

- [GNU Stow](https://www.gnu.org/software/stow/)

Use Stow to install the configs. (Need to place this config repo in the home directory)

- Arch: Run `sudo pacman -S stow`
- Homebrew: Run `brew install stow`
- Others: do search

### VS Code

- [Visual Studio Code](https://code.visualstudio.com/download)

### Zed

- [Zed](https://zed.dev/)

### Zellij (use kitty if possible)

- [https://github.com/zellij-org/zellij]

### lsd

- [https://github.com/lsd-rs/lsd]
