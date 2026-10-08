# config

Dotfiles and system configuration for an Apple Silicon Mac (`aarch64-darwin`). [nix-darwin](https://github.com/nix-darwin/nix-darwin) manages the system packages, Homebrew and macOS settings. [Home Manager](https://github.com/nix-community/home-manager) links the dotfiles into `$HOME`.

## How it works

- [`nix-darwin/flake.nix`](nix-darwin/flake.nix) defines the system (`darwinConfigurations.work`): CLI packages, fonts, Homebrew formulae and casks through [nix-homebrew](https://github.com/zhaofengli-wip/nix-homebrew), Nix settings and garbage collection.
- [`nix-darwin/home.nix`](nix-darwin/home.nix) defines the user environment: a few user packages, and one symlink from `$HOME` into this repository for each dotfile. `flake.nix` loads it as a Home Manager module, so the system rebuild applies it too.
- The symlinks point at the working tree (`mkOutOfStoreSymlink`), not at a copy in the Nix store. An edit to a dotfile takes effect at once, with no rebuild.
- Each top-level folder mirrors the layout under `$HOME`. For example, `ghostty/.config/ghostty` links to `~/.config/ghostty`. The same layout works with GNU Stow (see [Without Nix](#without-nix)).

Homebrew is declarative. On each system rebuild, Homebrew uninstalls every formula and cask that `flake.nix` does not list (`onActivation.cleanup = "uninstall"`). To keep a package, add it to `flake.nix` instead of running `brew install`.

## Set up a new Mac

1. Install Nix with the [official installer](https://nixos.org/download/). This flake sets `nix.settings`, so nix-darwin must manage the Nix installation.

2. Clone the repository to `~/config`. `home.nix` expects this exact path.

   ```shell
   git clone https://github.com/IanLiuTW/config ~/config
   ```

3. Build and switch the configuration. This applies both `flake.nix` and `home.nix`. The first run uses `nix run`, because `darwin-rebuild` is not installed yet:

   ```shell
   sudo nix run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake ~/config/nix-darwin#work
   ```

   If a dotfile target already exists (for example a default `~/.zshrc`), Home Manager renames it with a `.before-hm` suffix.

4. Open a new terminal. From now on, use the aliases below.

### Machine-specific files

These files are gitignored, so each Mac creates its own. All are optional.

| File | Holds | Read by |
|---|---|---|
| `git/local.gitconfig` | Extra Git settings, such as `includeIf` rules for a work identity | `git/.gitconfig` includes it last, so it wins |
| `claude/managed-settings.local.json` | Claude Code settings to keep out of this repo, such as `autoMode.environment` entries | `nix-re` copies it to `/Library/Application Support/ClaudeCode/managed-settings.d/50-local.json` |
| `hammerspoon/.hammerspoon/local.lua` | `return { workProjectDir = "..." }` for the work-hours tracker | `init.lua`. Without it, the tracker stays off |
| `_exports/Raycast/Raycast.rayconfig` | The Raycast settings export | Imported by hand |

## Daily use

The aliases are defined in [`zsh/.zshrc`](zsh/.zshrc).

| Alias | Command | Use it after you change |
|---|---|---|
| `nix-re` | `sudo darwin-rebuild switch --flake ~/config/nix-darwin#work` | `flake.nix` or `home.nix`: system and user packages, Homebrew, fonts, macOS settings, dotfile links |
| `nix-up` | `nix flake update --flake ~/config/nix-darwin/ && nix-re` | Nothing. It updates `flake.lock` and runs `nix-re` |
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
| [`omniwm/`](omniwm) | `~/.config/omniwm/settings.toml` | OmniWM tiling window manager. Changes made in its Settings window are written back to this file |
| [`hammerspoon/`](hammerspoon) | `~/.hammerspoon` | Hammerspoon automation |
| [`claude/`](claude) | `~/.claude/` | Claude Code settings, instructions, output styles, status line, theme and key bindings |
| [`gemini/`](gemini) | `~/.gemini/` | Gemini CLI settings and custom commands |
| [`mcphub/`](mcphub) | `~/.config/mcphub/servers.json` | MCP server list, in the `servers.json` format of [mcphub.nvim](https://github.com/ravitemer/mcphub.nvim) |
| [`_exports/`](_exports) | Not linked | Settings to import by hand: Tabliss, VS Code key bindings. The Raycast export stays local (see [Machine-specific files](#machine-specific-files)) |
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
