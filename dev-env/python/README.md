# Python

## Installation

[Python](https://github.com/danhper/asdf-python)

```bash
sudo apt update && sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev libedit-dev --fix-missing

asdf plugin add python
asdf install python latest
asdf global python latest

python --version
python -m pip --version
```
