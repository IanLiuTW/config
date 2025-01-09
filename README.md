# My config (AKA dotfile)

## Setup

- Clone this repo to the home directory.

### 1. Nix

- Install `nix` and `home-manager`.

  - [Nix](https://nixos.org/download/)
  - [Home Manager](https://nix-community.github.io/home-manager/)

- Refer to the flakes.

  - [nix-darwin/flake.nix](nix-darwin/flake.nix)
  - [nix-darwin/home.nix](nix-darwin/home.nix).

```bash
darwin-rebuild switch --flake ~/config/nix-darwin#work
home-manager switch --flake ~/config/nix-darwin/
```

### 2. Script

> Note to self: The Nix method preferable and up-to-date. The script method could be outdated and needs to be revised before use.

See [\_scripts/dev_env](_scripts/dev_env) for setup scripts, and/or pick and choose additional tools.

The main use of this method is to put a script in a Devcontainer config and set up basic cli tools.

```bash
git clone https://github.com/IanLiuTW/config ~/config && chmod +x ~/config/_scripts/dev_env/setup_apt.sh && ~/config/_scripts/dev_env/setup_apt.sh
```

### 3. Stow

Manually set up using `stow`. (Refer to the Nix flakes for packages to install.)

```bash
git clone https://github.com/IanLiuTW/config ~/config && cd ~/config
# Install the tools and delete their default configs
stow ghostty zsh git #... and others
```
