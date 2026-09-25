# Python

Plugin: [asdf-python](https://github.com/asdf-community/asdf-python). It builds Python from source with `python-build` from pyenv.

On Debian and Ubuntu, install the build dependencies first. This list comes from the [pyenv wiki](https://github.com/pyenv/pyenv/wiki#suggested-build-environment):

```shell
sudo apt update
sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils tk-dev \
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev libzstd-dev
```

On macOS, the pyenv wiki lists the Homebrew packages to install.

```shell
asdf plugin add python
asdf install python latest
asdf set -u python latest

python --version
python -m pip --version
```

For command-line tools written in Python, see [pipx](pipx.md). For project dependencies, see [Poetry](poetry.md).

[uv](https://docs.astral.sh/uv/) can replace all three: it installs Python versions (`uv python install`), command-line tools (`uv tool install`), and project dependencies (`uv add`, `uv sync`).
