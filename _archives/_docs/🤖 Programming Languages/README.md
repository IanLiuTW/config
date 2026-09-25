# asdf

[asdf](https://asdf-vm.com/) installs and switches between versions of language runtimes (Python, Node.js, Go and others) per project. These notes are for asdf 0.16 and later. Version 0.16 rewrote asdf in Go and changed several commands; the notes at the end list them.

Each language has its own page:

- [Go](go/README.md)
- [Java](java/README.md)
- [Node.js](nodejs/README.md)
- [Python](python/README.md), and the Python tools [pipx](python/pipx.md) and [Poetry](python/poetry.md)
- [Rust](rust/README.md)

## Install

| Platform | Command |
|---|---|
| macOS (Homebrew) | `brew install asdf` |
| Nix | add `asdf-vm` to your packages |
| Any, with Go | `go install github.com/asdf-vm/asdf/cmd/asdf@latest` |
| Any | download a binary from the [releases page](https://github.com/asdf-vm/asdf/releases) and put it on your `PATH` |

Then put the shims directory at the front of `PATH`. For zsh or bash, add this to `~/.zshrc` or `~/.bashrc`:

```shell
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
```

For shell completion in bash, also add:

```shell
. <(asdf completion bash)
```

For zsh, write the completion file once, then load it from `~/.zshrc` before `compinit`:

```shell
mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
```

```shell
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit
```

Check the setup with `asdf info`.

## Plugins

asdf supports a language through a plugin. Before you install a version, read the plugin's README for the build dependencies it needs.

```shell
asdf plugin list all                 # every plugin in the asdf-plugins registry
asdf plugin add <name>               # add a plugin from the registry
asdf plugin add <name> <git-url>     # add a plugin from a Git repository
asdf plugin list --urls              # installed plugins and their sources
asdf plugin update --all             # update every plugin
asdf plugin remove <name>            # remove a plugin and all its installed versions
```

## Versions

```shell
asdf list all <name> [<prefix>]      # versions you can install
asdf latest <name> [<prefix>]        # latest stable version
asdf install <name> <version>        # install one version
asdf install <name> latest[:<prefix>]
asdf list <name>                     # installed versions
asdf uninstall <name> <version>
```

## Select a version

`asdf set` writes the version to a `.tool-versions` file:

```shell
asdf set <name> <version>            # ./.tool-versions: this directory and below
asdf set -u <name> <version>         # ~/.tool-versions: your default everywhere
asdf set -p <name> <version>         # the nearest .tool-versions in a parent directory
asdf set <name> system               # use the version installed outside asdf
```

To select a version for the current shell only, set the environment variable `ASDF_<NAME>_VERSION`, for example `export ASDF_PYTHON_VERSION=3.14.0`.

```shell
asdf current                         # the version in use for every tool, and where it is set
asdf current <name>
asdf which <command>                 # the executable a shim runs
```

asdf reads `.tool-versions` in the current directory and every parent directory, up to `~/.tool-versions`. In a directory with a `.tool-versions` file, `asdf install` with no arguments installs every version that the file lists.

## Changes in asdf 0.16

If you used asdf before 0.16, note these changes:

| Before 0.16 | 0.16 and later |
|---|---|
| `git clone` into `~/.asdf` and source `asdf.sh` | Install a single binary; add only the shims directory to `PATH` |
| `asdf global <name> <version>` | `asdf set -u <name> <version>` |
| `asdf local <name> <version>` | `asdf set <name> <version>` |
| `asdf shell <name> <version>` | `export ASDF_<NAME>_VERSION=<version>` |
| `asdf update` | Update through the package manager you installed asdf with |
