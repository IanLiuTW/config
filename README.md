# config

Dotfiles and system configuration for an Apple Silicon Mac (`aarch64-darwin`). [nix-darwin](https://github.com/nix-darwin/nix-darwin) manages the system packages, Homebrew and Nix settings. [Home Manager](https://github.com/nix-community/home-manager) links the dotfiles into `$HOME`.

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

3. Build and switch the configuration. This applies both `flake.nix` and `home.nix`. The first run uses `nix run`, because `darwin-rebuild` is not installed yet. Flakes are not enabled until this switch, so the command enables them for itself:

   ```shell
   sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake ~/config/nix-darwin#work
   ```

   If a dotfile target already exists (for example a default `~/.zshrc`), Home Manager renames it with a `.before-hm` suffix.

4. Open a new terminal. From now on, use the aliases below.

5. Do the steps that the flake does not manage:

   - **Keyboard shortcuts.** In System Settings > Keyboard > Keyboard Shortcuts, set Mission Control to Ctrl+Option+M and Application windows to Ctrl+Option+N. Turn off "Move left a space", "Move right a space" and both Spotlight shortcuts, and set "Select the previous input source" to Cmd+Space. This frees Ctrl+arrow keys for Neovim and Cmd+Space for Raycast.
   - **Docker CLI plugins.** Homebrew's `docker-compose` and `docker-buildx` work only after you add `"cliPluginsExtraDirs": ["/opt/homebrew/lib/docker/cli-plugins"]` to `~/.docker/config.json`. Without it, `docker compose` fails with "unknown command".
   - **herdr hook for Claude Code.** Run `herdr integration install claude`. It creates `~/.claude/hooks/herdr-agent-state.sh`, which the `SessionStart` hook in `claude/.claude/settings.json` runs. Without it, every Claude Code session starts with a hook error. Check it with `herdr integration status`.

### Machine-specific files

These files are gitignored or live outside the repository, so each Mac creates its own. All are optional.

| File | Holds | Read by |
|---|---|---|
| `git/local.gitconfig` | Extra Git settings, such as `includeIf` rules for a work identity | `git/.gitconfig` includes it last, so it wins |
| `git/work.gitconfig` | A work identity, such as `user.email` | `git/local.gitconfig` includes it through `includeIf` rules |
| `~/.zshrc.local` | Machine-specific shell variables and secrets | `zsh/.zshrc` sources it near the end |
| `~/.claude/skills` | A separate, private Git clone of Claude Code skills | The daily `claude-skills-pull` agent. Without it, the agent does nothing |
| `claude/managed-settings.local.json` | Claude Code settings to keep out of this repo, such as `autoMode.environment` entries | `nix-rebuild` copies it to `/Library/Application Support/ClaudeCode/managed-settings.d/50-local.json` |
| `hammerspoon/.hammerspoon/local.lua` | `return { workProjectDir = "..." }` for the work-hours tracker | `init.lua`. Without it, the tracker stays off |
| `_exports/Raycast/Raycast.rayconfig` | The Raycast settings export | Imported by hand |

## Daily use

The aliases are defined in [`zsh/.zshrc`](zsh/.zshrc).

| Alias | Command | Use it after you change |
|---|---|---|
| `nix-rebuild` | `sudo darwin-rebuild switch --flake ~/config/nix-darwin#work` | `flake.nix` or `home.nix`: system and user packages, Homebrew, fonts, per-app macOS defaults, dotfile links |
| `nix-update` | `nix flake update --flake ~/config/nix-darwin/ && nix-rebuild` | Nothing. It updates `flake.lock` and runs `nix-rebuild` |
| `nix-clean` | `nix-collect-garbage -d` (system and user) and `nix-store --optimize` | Nothing. It frees disk space |
| `nix-dev` | `nix develop --command zsh` | Nothing. It enters a project's dev shell |
| `nix-run` | `nix run` | Nothing. It runs a flake app, such as `nix-run nixpkgs#hello` |

An edit to a linked dotfile needs no command. Some programs read their config only at startup, so restart them.

nix-darwin also runs garbage collection every Sunday at 03:00, and it deletes system generations older than 7 days. It runs as root, so it does not delete Home Manager or user-profile generations. A weekly Home Manager agent expires Home Manager generations older than 7 days; run `nix-clean` for user-profile generations.

A launchd agent, `claude-skills-pull`, runs every day at 12:00. It updates `master` in `~/.claude/skills`: `git pull` when that checkout is on `master`, otherwise `git fetch origin master:master`, which fast-forwards `master` and leaves the current branch checked out. On another branch it then runs `git merge --no-edit master`. It skips the merge, with a notification, if tracked files have uncommitted changes, and it aborts the merge, with a notification, on a conflict. It retries the update of `master` up to 3 times and posts a "Cron job failed" notification if all tries fail. Log: `~/Library/Logs/claude-skills-pull.log`.

## Contents

| Folder | Linked to | What it configures |
|---|---|---|
| [`nix-darwin/`](nix-darwin) | | The flake, the Home Manager module and `flake.lock` |
| [`zsh/`](zsh) | `~/.zshrc` | Shell, aliases and functions |
| [`starship/`](starship) | `~/.config/starship.toml` | Prompt |
| [`ghostty/`](ghostty) | `~/.config/ghostty` | Terminal |
| [`herdr/`](herdr) | `~/.config/herdr/config.toml` | herdr |
| [`nvim/`](nvim) | `~/.config/nvim` | Neovim. Plugins are managed by lazy.nvim and pinned in `lazy-lock.json` |
| [`zed/`](zed) | `~/.config/zed/settings.json` | Zed editor |
| [`git/`](git) | `~/.gitconfig` | Git |
| [`lazygit/`](lazygit) | `~/.config/lazygit/config.yml` | lazygit |
| [`k9s/`](k9s) | `~/.config/k9s` | k9s (Kubernetes TUI) |
| [`colima/`](colima) | `~/.config/colima/default/colima.yaml` | Colima VM (CPU, memory, disk). Applies on the next `colima start`, which rewrites this file |
| [`superfile/`](superfile) | `~/.config/superfile/` | superfile file manager (config and hotkeys) |
| [`omniwm/`](omniwm) | `~/.config/omniwm/settings.toml` | OmniWM tiling window manager. Changes made in its Settings window are written back to this file |
| [`hammerspoon/`](hammerspoon) | `~/.hammerspoon` | Hammerspoon automation |
| [`claude/`](claude) | `~/.claude/` | Claude Code settings, instructions, output styles, status line, theme and key bindings |
| [`_exports/`](_exports) | Not linked | Settings to import by hand: Tabliss, VS Code key bindings. The Raycast export stays local (see [Machine-specific files](#machine-specific-files)) |
| [`_archives/`](_archives) | Not linked | Configs and notes that are no longer in use. They are not maintained |

`home.nix` also writes `~/.config/pycodestyle` inline, and it sets Ghostty's macOS menu shortcuts through `targets.darwin.defaults`.

## Without Nix

On a machine without Nix, link the folders with [GNU Stow](https://www.gnu.org/software/stow/). Stow's default target is the parent of the repository, so the repository must be at `~/config`:

```shell
git clone https://github.com/IanLiuTW/config ~/config
cd ~/config
stow --no-folding zsh git ghostty nvim    # one folder name per package
```

`--no-folding` makes Stow link each file instead of a whole folder. Without it, `stow claude` links `~/.claude` to the repository, and the programs then write their runtime state and credentials into the working tree.

Install the programs yourself. `flake.nix` lists them. Remove or move each program's default config first, or Stow refuses to replace it.

`_archives/setup_apt.sh` is an old setup script for Debian and Ubuntu dev containers. It is kept for reference only; it is out of date.

## License

[MIT](LICENSE.md)
