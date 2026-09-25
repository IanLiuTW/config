# Poetry

[Poetry](https://python-poetry.org/) manages a Python project's dependencies, lockfile, virtual environment and build. These notes are for Poetry 2.x. Poetry 2.0 adopted the standard `[project]` table in `pyproject.toml` and removed or moved several commands; the notes at the end list them.

[uv](https://docs.astral.sh/uv/) covers the same tasks and is much faster. Consider it for a new project.

## Install

Install Poetry in its own environment, never into a project's environment:

```shell
pipx install poetry                  # or: uv tool install poetry
poetry --version
```

Upgrade with `pipx upgrade poetry`, and uninstall with `pipx uninstall poetry`.

Shell completion for zsh, with Oh My Zsh:

```shell
mkdir -p "$ZSH_CUSTOM/plugins/poetry"
poetry completions zsh > "$ZSH_CUSTOM/plugins/poetry/_poetry"
# then add "poetry" to plugins=(...) in ~/.zshrc
```

For bash: `poetry completions bash >> ~/.bash_completion`.

## Recommended configuration

```shell
poetry config virtualenvs.in-project true   # create the environment in ./.venv
poetry config --list                        # show every setting
```

If Poetry hangs or fails with a keyring prompt on a headless machine, turn off the keyring:

```shell
poetry config keyring.enabled false
```

## Create a project

```shell
poetry new my-project                 # src layout (the default in 2.x)
poetry new my-project --flat          # package at the root instead of under src/
poetry new my-folder --name my_package
poetry init                           # add pyproject.toml to an existing directory
```

## Dependencies

```shell
poetry add requests                   # latest compatible version
poetry add "requests>=2.32,<3"        # with a constraint
poetry add requests@^2.32
poetry add "requests[socks]"          # with extras
poetry add git+https://github.com/<user>/<repo>.git#<branch-or-tag>
poetry add ../my-package/             # a local path
poetry add --group dev pytest ruff    # into a dependency group (-G dev)
poetry remove requests
poetry remove --group dev pytest
```

```shell
poetry install                        # install from poetry.lock, including the project
poetry install --without dev          # skip a group
poetry install --only main            # only the runtime dependencies
poetry sync                           # install, and also remove packages not in the lockfile
poetry update                         # upgrade within the constraints, and rewrite poetry.lock
poetry update requests                # upgrade some packages only
poetry lock                           # refresh poetry.lock after you edit pyproject.toml by hand
poetry lock --regenerate              # rebuild poetry.lock from scratch
poetry check                          # validate pyproject.toml and its consistency with poetry.lock
```

```shell
poetry show                           # installed packages
poetry show --tree                    # dependency tree
poetry show --outdated
poetry show --top-level               # only direct dependencies
poetry search <name>
```

## Run commands in the environment

```shell
poetry run python script.py
poetry run pytest
eval $(poetry env activate)           # activate the environment in the current shell
```

## Environments

```shell
poetry env info                       # details of the current environment
poetry env info --path                # its path only
poetry env list
poetry env use 3.13                   # create or switch to an environment with Python 3.13
poetry env use /full/path/to/python
poetry env remove 3.13
poetry env remove --all
```

## Package sources

```shell
poetry source add <name> <url>
poetry source add --priority=explicit <name> <url>   # used only for packages that name it
poetry source show
```

See [Repositories](https://python-poetry.org/docs/repositories/) for priorities and credentials.

## Export to requirements.txt

Poetry 2 no longer includes `export`. Install the plugin first:

```shell
pipx inject poetry poetry-plugin-export      # or: poetry self add poetry-plugin-export
poetry export -f requirements.txt --output requirements.txt
poetry export --without-hashes -f requirements.txt --output requirements.txt
```

## Changes in Poetry 2.0

| Poetry 1.x | Poetry 2.x |
|---|---|
| `poetry shell` | `eval $(poetry env activate)`, or install the `poetry-plugin-shell` plugin |
| `poetry export` built in | `poetry-plugin-export` plugin |
| `poetry add -D` or `--dev` | `poetry add --group dev` (`-D` still works as a shortcut) |
| `poetry install --no-dev` | `poetry install --without dev` or `--only main` |
| `poetry install --remove-untracked` | `poetry sync` |
| `poetry lock --no-update` | `poetry lock` (it no longer upgrades by default); `--regenerate` rebuilds |
| Metadata in `[tool.poetry]` | Metadata in the standard `[project]` table |
