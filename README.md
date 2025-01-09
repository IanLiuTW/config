# config

## Quick Setup

- Clone this repo under the home directory.

### 1. Nix

- Use `nix` and `home-manager` for the setup.

  - [Nix](https://nixos.org/download/)
  - [nix-community/home-manager](https://nix-community.github.io/home-manager/)

- See [nix-darwin/flake.nix] and [nix-darwin/home.nix].

### 2. Script

> Note to self: The Nix method preferable and up-to-date. The script method could be outdated and needs to be revised before use.

See [_scripts/dev_env] for setup scripts, and/or pick and choose additional tools.

The main use of this method is to put a script in a Devcontainer config and set up basic cli tools.

```bash
git clone https://github.com/IanLiuTW/config ~/config && chmod +x ~/config/_scripts/dev_env/setup_apt.sh && ~/config/_scripts/dev_env/setup_apt.sh
```

### 3. Stow

Manually set up using `stow`.

```bash
git clone https://github.com/IanLiuTW/config ~/config && cd ~/config
# Install the tools and delete their default configs
stow ghostty zsh git #... and others
```
