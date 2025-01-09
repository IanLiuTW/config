# Poetry

- [Poetry](https://python-poetry.org/)

## **Installation**

### **Installing with `pipx`**

```bash
pipx install poetry
```

```bash
poetry --version
```

### **Enable tab completion for Bash**

```bash
sudo install -m 777 /dev/null /etc/bash_completion.d/poetry.bash-completion
poetry completions bash > /etc/bash_completion.d/poetry.bash-completion
```

You may need to restart your shell in order for the changes to take effect.

### **(Optional) Set poetry to create the virtualenv inside the project’s root directory**

```bash
poetry config virtualenvs.in-project true
```

### **(Optional) Export** PYTHON_KEYRING_BACKEND variable to avoid `Failed to create the collection: Prompt dismissed..` issue

```bash
echo 'export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring' >> ~/.bashrc
```

See all the current config

```bash
poetry config --list
```

### **Updating & Uninstalling**

```bash
pipx upgrade poetry
```

```bash
pipx uninstall poetry
```

## **Basic usage**

The `pyproject.toml` file is what is the most important here. This will orchestrate your project and its dependencies.

### **Project setup**

```bash
poetry new project_name
```

If you want to name your project differently than the folder, you can pass the `--name` option:

```bash
poetry new my_folder --name my_package
```

If you want to use a src folder, you can use the `--src` option:

```bash
poetry new --src my_package
```

### **Initializing a pre-existing project**

```bash
poetry init
```

### **Activating the virtual environment**

```bash
poetry shell
```

```bash
exit # exit the shell
```

### **Adding dependencies**

```bash
poetry add package_name
```

To install dependencies to dev:

```bash
poetry add -D package_name
poetry add --dev package_name
```

If you do not specify a version constraint, poetry will choose a suitable one based on the available package versions. You also can specify a constraint when adding a package, like so:

```bash
poetry add requests pendulum
poetry add pendulum@^2.0.5
poetry add "pendulum>=2.0.5"
poetry add -D pytest@6.2.5
poetry add pendulum@latest
# You can also add git dependencies:
poetry add git+https://github.com/sdispater/pendulum.git
# or use ssh instead of https:
poetry add git+ssh://git@github.com/sdispater/pendulum.git
# If you need to checkout a specific branch, tag or revision, you can specify it when using add:
poetry add git+https://github.com/sdispater/pendulum.git#develop
poetry add git+https://github.com/sdispater/pendulum.git#2.0.5
# or make them point to a local directory or file:
poetry add ./my-package/
poetry add ../my-package/dist/my-package-0.1.0.tar.gz
poetry add ../my-package/dist/my_package-0.1.0.whl
# If the package(s) you want to install provide extras, you can specify them when adding the package:
poetry add requests[security,socks]
poetry add "requests[security,socks]~=2.22.0"
poetry add "git+https://github.com/pallets/flask.git@1.1.1[dotenv,dev]"
```

### **Removing dependencies**

```bash
poetry remove package_name
```

To remove dependencies from dev:

```bash
poetry remove -D package_name
# or
poetry remove --dev package_name
```

### **Installing dependencies**

```bash
poetry install
```

You can specify to the command that you do not want the development dependencies installed by passing the `--no-dev` option.

```bash
poetry install --no-dev
```

If you want to remove old dependencies no longer present in the lock file, use the `--remove-untracked` option.

```bash
poetry install --remove-untracked
```

### **Updating dependencies**

```bash
poetry update
```

This will resolve all dependencies of the project and write the exact versions into `poetry.lock`.

If you just want to update a few packages and not all, you can list them as such:

```bash
poetry update requests toml
```

Note that this will not update versions for dependencies outside their version constraints specified in the `pyproject.toml` file.

### **Showing dependencies**

```bash
poetry show
```

If you want to see the details of a certain package, you can pass the package name:

```bash
poetry show package_name
```

More parameters:

```bash
poetry show -v  # shows the location of .venv
poetry show --tree
poetry show --outdated
```

### **Checking the `pyproject.toml` file**

```bash
poetry check
```

### **Locking the `pyproject.toml` file**

By default, this will lock all dependencies to the latest available compatible versions. To only refresh the lock file, use the `--no-update` option.

```bash
poetry lock
```

```bash
poetry lock --no-update
```

### **Using `poetry run`**

```bash
poetry run python your_script.py
# or
poetry run pytest
```

### **Searching packages**

```bash
poetry search package_name
```

```bash
poetry search requests pendulum
```

## **Configuration**

### **Local configuration**

```bash
poetry config virtualenvs.create false --local
```

### **Listing the current configuration**

```bash
poetry config --list
```

### **Displaying a single configuration setting**

```bash
poetry config virtualenvs.path
```

### **Adding or updating a configuration setting**

```bash
poetry config virtualenvs.path /path/to/cache/directory/virtualenvs
```

### **Removing a specific setting**

```bash
poetry config virtualenvs.path --unset
```

### **Create the virtualenv inside the project’s root directory**

```bash
poetry config virtualenvs.in-project true
```

Defaults to `None`. If set to `true`, the virtualenv wil be created and expected in a folder named `.venv` within the root directory of the project.

If not set explicitly (default), `poetry` will use the virtualenv from the `.venv` directory when one is available. If set to `false`, `poetry` will ignore any existing `.venv` directory.

### **Set a new alternative repository**

```bash
poetry config repositories.<name>
```

See [Repositories](https://python-poetry.org/docs/repositories/) for more information.

## **Managing environments**

### **Displaying the environment information**

```bash
poetry env info
```

If you only want to know the path to the virtual environment, you can pass the `--path` option to `env info`:

```bash
poetry env info --path
```

### **Listing the environments associated with the project**

```bash
poetry env list
```

### **Switching between environments**

```bash
poetry env use /full/path/to/python
```

If you have the python executable in your `PATH` you can use it:

```bash
poetry env use python3.7
```

You can even just use the minor Python version in this case:

```bash
poetry env use 3.7
```

If you want to disable the explicitly activated virtual environment, you can use the special `system` Python version to retrieve the default behavior:

```bash
poetry env use system
```

### **Deleting the environments**

```bash
poetry env remove /full/path/to/python
poetry env remove python3.7
poetry env remove 3.7
poetry env remove test-O3eWbxRl-py3.7
```

If you remove the currently activated virtual environment, it will be automatically deactivated.

## **Export**

### **Exporting the env to the `requirements.txt` file**

```bash
poetry export -f requirements.txt --output requirements.txt
```
