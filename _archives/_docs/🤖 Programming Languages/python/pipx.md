# pipx

[pipx](https://pipx.pypa.io/) installs Python command-line tools, each in its own virtual environment, and puts their commands on `PATH`. The tools cannot conflict with each other or with your projects.

`uv tool` does the same job with the same model: `uv tool install <package>`, `uv tool run <command>` (or `uvx <command>`), `uv tool upgrade --all`. Use one of the two, not both.

## Install

```shell
brew install pipx                    # macOS
sudo apt install pipx                # Debian and Ubuntu
python3 -m pip install --user pipx   # anywhere else

pipx ensurepath                      # add ~/.local/bin to PATH; then open a new shell
pipx --version
```

Default locations (pipx 1.3 and later). `pipx environment` prints the values in use:

| What | Linux | macOS | Override with |
|---|---|---|---|
| Virtual environments | `~/.local/share/pipx/venvs` | `~/Library/Application Support/pipx/venvs` | `PIPX_HOME` |
| Commands | `~/.local/bin` | `~/.local/bin` | `PIPX_BIN_DIR` |
| Manual pages | `~/.local/share/man` | `~/.local/share/man` | `PIPX_MAN_DIR` |

## Shell completion

`pipx completions` prints the instructions for each shell. For bash, add this to `~/.bashrc`:

```shell
eval "$(register-python-argcomplete pipx)"
```

For zsh, add this to `~/.zshrc`:

```shell
autoload -U compinit && compinit
eval "$(register-python-argcomplete pipx)"
```

With argcomplete older than 3.0, also run `autoload -U bashcompinit && bashcompinit` before the `eval` line.

## Use

```shell
pipx install <package>               # install a tool
pipx install <package>==1.2.3        # a specific version
pipx install --python 3.13 <package> # with a specific Python
pipx install git+https://github.com/<user>/<repo>.git
pipx list                            # installed tools
pipx upgrade <package>
pipx upgrade-all
pipx uninstall <package>
pipx run <package> [args]            # run once in a temporary environment (cached for 14 days)
pipx inject <package> <extra-package> # add a package to a tool's environment, for example a plugin
pipx reinstall-all                   # after an upgrade of the Python that pipx uses
```

To see every option of a command, run `pipx <command> --help`.
