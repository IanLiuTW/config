# config

Dotfiles and system configuration for an Apple Silicon Mac (`aarch64-darwin`). [nix-darwin](https://github.com/nix-darwin/nix-darwin) manages the system packages, Homebrew and macOS settings. [Home Manager](https://github.com/nix-community/home-manager) links the dotfiles into `$HOME`.

## How it works

- [`nix-darwin/flake.nix`](nix-darwin/flake.nix) defines the system (`darwinConfigurations.work`): CLI packages, fonts, Homebrew formulae and casks through [nix-homebrew](https://github.com/zhaofengli-wip/nix-homebrew), Nix settings and garbage collection.
- [`nix-darwin/home.nix`](nix-darwin/home.nix) defines the user environment (`homeConfigurations.ianliu`): a few user packages, and one symlink from `$HOME` into this repository for each dotfile.
- The symlinks point at the working tree (`mkOutOfStoreSymlink`), not at a copy in the Nix store. An edit to a dotfile takes effect at once, with no rebuild.
- Each top-level folder mirrors the layout under `$HOME`. For example, `ghostty/.config/ghostty` links to `~/.config/ghostty`. The same layout works with GNU Stow (see [Without Nix](#without-nix)).

Homebrew is declarative. On each system rebuild, Homebrew uninstalls every formula and cask that `flake.nix` does not list (`onActivation.cleanup = "uninstall"`). To keep a package, add it to `flake.nix` instead of running `brew install`.

## Set up a new Mac

1. Install Nix with the [official installer](https://nixos.org/download/). This flake sets `nix.settings`, so nix-darwin must manage the Nix installation.

2. Clone the repository to `~/config`. `home.nix` expects this exact path.

   ```shell
   git clone https://github.com/IanLiuTW/config ~/config
   ```

3. Build and switch the system configuration. The first run uses `nix run`, because `darwin-rebuild` is not installed yet:

   ```shell
   sudo nix run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake ~/config/nix-darwin#work
   ```

4. Build and switch the user configuration. The first run uses `nix run` for the same reason:

   ```shell
   nix run github:nix-community/home-manager -- switch --flake ~/config/nix-darwin/
   ```

   If a target file already exists (for example a default `~/.zshrc`), Home Manager stops and names it. Move the file away and run the command again.

5. Open a new terminal. From now on, use the aliases below.

## Daily use

The aliases are defined in [`zsh/.zshrc`](zsh/.zshrc).

| Alias | Command | Use it after you change |
|---|---|---|
| `nix-re` | `sudo darwin-rebuild switch --flake ~/config/nix-darwin#work` | `flake.nix`: system packages, Homebrew, fonts, macOS settings |
| `nix-hm` | `home-manager switch --flake ~/config/nix-darwin/` | `home.nix`: links, user packages |
| `nix-up` | `nix flake update --flake ~/config/nix-darwin/` | Nothing. It updates `flake.lock`; run `nix-re` and `nix-hm` next |
| `nix-cl` | `nix-collect-garbage -d` (system and user) and `nix-store --optimize` | Nothing. It frees disk space |
| `nix-d` | `nix develop --command zsh` | Nothing. It enters a project's dev shell |

An edit to a linked dotfile needs no command. Some programs read their config only at startup, so restart them.

nix-darwin also runs garbage collection every Sunday at 03:00, and it deletes generations older than 7 days.

## Contents

| Folder | Linked to | What it configures |
|---|---|---|
| [`nix-darwin/`](nix-darwin) | | The flake, the Home Manager module and `flake.lock` |
| [`nix/`](nix) | `~/.config/nix` | Nix user settings |
| [`zsh/`](zsh) | `~/.zshrc` | Shell, aliases and functions |
| [`starship/`](starship) | `~/.config/starship.toml` | Prompt |
| [`ghostty/`](ghostty) | `~/.config/ghostty` | Terminal |
| [`herdr/`](herdr) | `~/.config/herdr/config.toml` | herdr |
| [`nvim/`](nvim) | `~/.config/nvim` | Neovim. Plugins are managed by lazy.nvim and pinned in `lazy-lock.json` |
| [`zed/`](zed) | `~/.config/zed/settings.json` | Zed editor |
| [`git/`](git) | `~/.gitconfig` | Git |
| [`lazygit/`](lazygit) | `~/.config/lazygit/config.yml` | lazygit |
| [`lazydocker/`](lazydocker) | `~/.config/lazydocker/config.yml` | lazydocker |
| [`k9s/`](k9s) | `~/.config/k9s` | k9s (Kubernetes TUI) |
| [`superfile/`](superfile) | `~/.config/superfile/` | superfile file manager (config and hotkeys) |
| [`aerospace/`](aerospace) | `~/.aerospace.toml` | AeroSpace tiling window manager |
| [`hammerspoon/`](hammerspoon) | `~/.hammerspoon` | Hammerspoon automation |
| [`claude/`](claude) | `~/.claude/` | Claude Code settings, instructions, output styles, status line, theme and key bindings |
| [`gemini/`](gemini) | `~/.gemini/` | Gemini CLI settings and custom commands |
| [`mcphub/`](mcphub) | `~/.config/mcphub/servers.json` | MCP server list, in the `servers.json` format of [mcphub.nvim](https://github.com/ravitemer/mcphub.nvim) |
| [`_exports/`](_exports) | Not linked | Settings to import by hand: Raycast, Tabliss, VS Code key bindings |
| [`_archives/`](_archives) | Not linked | Configs and notes that are no longer in use. They are not maintained |

`home.nix` also writes `~/.config/pycodestyle` inline, and it sets Ghostty's macOS menu shortcuts through `targets.darwin.defaults`.

## Without Nix

On a machine without Nix, link the folders with [GNU Stow](https://www.gnu.org/software/stow/). Stow's default target is the parent of the repository, so the repository must be at `~/config`:

```shell
git clone https://github.com/IanLiuTW/config ~/config
cd ~/config
stow zsh git ghostty nvim    # one folder name per package
```

Install the programs yourself. `flake.nix` lists them. Remove or move each program's default config first, or Stow refuses to replace it.

`_archives/setup_apt.sh` is an old setup script for Debian and Ubuntu dev containers. It is kept for reference only; it is out of date.

## License

[MIT](LICENSE.md)
