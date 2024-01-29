# pipx

## **Installation**

### **Install pipx**

```bash
python -m pip install --user pipx
```

The default binary location for pipx-installed apps is `~/.local/bin`. This can be overridden with the environment variable `PIPX_BIN_DIR`.

pipx's default virtual environment location is `~/.local/pipx`. This can be overridden with the environment variable `PIPX_HOME`.

```bash
python -m pipx ensurepath
```

```bash
source ~/.bashrc # if needed after ensurepath
```

### **Check for version**

```bash
pipx --version
```

### **Shell Completion**

```bash
pipx completions
```

Edit the ~/.bashrc and add:

```bash
sudo vim ~/.bashrc
```

```bash
# pipx
eval "$(register-python-argcomplete pipx)"
```

```bash
source ~/.bashrc
```

### **Upgrade pipx**

```bash
python -m pip install --user -U pipx
```

## **Usage**

### **Install**

```bash
pipx install PACKAGE
```

for example

```bash
pipx install pycowsay
```

### **List**

```bash
pipx list
```

### **Upgrade**

```bash
pipx upgrade PACKAGE
```

### **Run (you can run a program without installing it)**

```bash
pipx run pycowsay moooo!
```

### **Uninstall**

```bash
pipx uninstall PACKAGE
```

## **Docs**

```bash
pipx --help
usage: pipx [-h] [--version]
            {install,inject,upgrade,upgrade-all,uninstall,uninstall-all,reinstall,reinstall-all,list,run,runpip,ensurepath,completions}
            ...

Install and execute apps from Python packages.

Binaries can either be installed globally into isolated Virtual Environments
or run directly in a temporary Virtual Environment.

Virtual Environment location is /opt/pipx/venvs.
Symlinks to apps are placed in /opt/pipx_bin.

optional environment variables:
  PIPX_HOME             Overrides default pipx location. Virtual Environments
                        will be installed to $PIPX_HOME/venvs.
  PIPX_BIN_DIR          Overrides location of app installations. Apps are
                        symlinked or copied here.
  USE_EMOJI             Overrides emoji behavior. Default value varies based
                        on platform.
  PIPX_DEFAULT_PYTHON   Overrides default python used for commands.

optional arguments:
  -h, --help            show this help message and exit
  --version             Print version and exit

subcommands:
  Get help for commands with pipx COMMAND --help

  {install,inject,upgrade,upgrade-all,uninstall,uninstall-all,reinstall,reinstall-all,list,run,runpip,ensurepath,completions}
    install             Install a package
    inject              Install packages into an existing Virtual Environment
    upgrade             Upgrade a package
    upgrade-all         Upgrade all packages. Runs `pip install -U <pkgname>`for each package.
    uninstall           Uninstall a package
    uninstall-all       Uninstall all packages
    reinstall           Reinstall a package
    reinstall-all       Reinstall all packages
    list                List installed packages
    run                 Download the latest version of a package to a
                        temporary virtual environment, then run an app from
                        it. Also compatible with local `__pypackages__`
                        directory (experimental).
    runpip              Run pip in an existing pipx-managed Virtual
                        Environment
    ensurepath          Ensure directories necessary for pipx operation are in
                        your PATH environment variable.
    completions         Print instructions on enabling shell completions for
                        pipx
```

### **pipx install**

```bash
pipx install --help
usage: pipx install [-h] [--include-deps] [--verbose] [--force]
                    [--suffix SUFFIX] [--python PYTHON]
                    [--system-site-packages] [--index-url INDEX_URL]
                    [--editable] [--pip-args PIP_ARGS]
                    package_spec

The install command is the preferred way to globally install apps
from python packages on your system. It creates an isolated virtual
environment for the package, then ensures the package's apps are
accessible on your $PATH.

The result: apps you can run from anywhere, located in packages
you can cleanly upgrade or uninstall. Guaranteed to not have
dependency version conflicts or interfere with your OS's python
packages. 'sudo' is not required to do this.

pipx install PACKAGE_NAME
pipx install --python PYTHON PACKAGE_NAME
pipx install VCS_URL
pipx install ./LOCAL_PATH
pipx install ZIP_FILE
pipx install TAR_GZ_FILE

The PACKAGE_SPEC argument is passed directly to `pip install`.

The default virtual environment location is ~/.local/pipx
and can be overridden by setting the environment variable `PIPX_HOME`
(Virtual Environments will be installed to `$PIPX_HOME/venvs`).

The default app location is ~/.local/bin and can be
overridden by setting the environment variable `PIPX_BIN_DIR`.

The default python executable used to install a package is
typically the python used to execute pipx and can be overridden
by setting the environment variable `PIPX_DEFAULT_PYTHON`.

positional arguments:
  package_spec          package name or pip installation spec

optional arguments:
  -h, --help            show this help message and exit
  --include-deps        Include apps of dependent packages
  --verbose
  --force, -f           Modify existing virtual environment and files in
                        PIPX_BIN_DIR
  --suffix SUFFIX       Optional suffix for virtual environment and executable
                        names. NOTE: The suffix feature is experimental and
                        subject to change.
  --python PYTHON       The Python executable used to create the Virtual
                        Environment and run the associated app/apps. Must be
                        v3.6+.
  --system-site-packages
                        Give the virtual environment access to the system
                        site-packages dir.
  --index-url INDEX_URL, -i INDEX_URL
                        Base URL of Python Package Index
  --editable, -e        Install a project in editable mode
  --pip-args PIP_ARGS   Arbitrary pip arguments to pass directly to pip
                        install/upgrade commands
```

### **pipx run**

```bash
pipx run --help
usage: pipx run [-h] [--no-cache] [--pypackages] [--spec SPEC] [--verbose]
                [--python PYTHON] [--system-site-packages]
                [--index-url INDEX_URL] [--editable] [--pip-args PIP_ARGS]
                app ...

Download the latest version of a package to a temporary virtual environment,
then run an app from it. The environment will be cached
and re-used for up to 14 days. This
means subsequent calls to 'run' for the same package will be faster
since they can re-use the cached Virtual Environment.

In support of PEP 582 'run' will use apps found in a local __pypackages__
directory, if present. Please note that this behavior is experimental,
and acts as a companion tool to pythonloc. It may be modified or
removed in the future. See https://github.com/cs01/pythonloc.

positional arguments:
  app ...               app/package name and any arguments to be passed to it

optional arguments:
  -h, --help            show this help message and exit
  --no-cache            Do not re-use cached virtual environment if it exists
  --pypackages          Require app to be run from local __pypackages__
                        directory
  --spec SPEC           The package name or specific installation source
                        passed to pip. Runs `pip install -U SPEC`. For example
                        `--spec mypackage==2.0.0` or `--spec
                        git+https://github.com/user/repo.git@branch`
  --verbose
  --python PYTHON       The Python version to run package's CLI app with. Must
                        be v3.6+.
  --system-site-packages
                        Give the virtual environment access to the system
                        site-packages dir.
  --index-url INDEX_URL, -i INDEX_URL
                        Base URL of Python Package Index
  --editable, -e        Install a project in editable mode
  --pip-args PIP_ARGS   Arbitrary pip arguments to pass directly to pip
                        install/upgrade commands
```

### **pipx upgrade**

```bash
pipx upgrade --help
usage: pipx upgrade [-h] [--include-injected] [--force]
                    [--system-site-packages] [--index-url INDEX_URL]
                    [--editable] [--pip-args PIP_ARGS] [--verbose]
                    package

Upgrade a package in a pipx-managed Virtual Environment by running 'pip
install --upgrade PACKAGE'

positional arguments:
  package

optional arguments:
  -h, --help            show this help message and exit
  --include-injected    Also upgrade packages injected into the main app's
                        environment
  --force, -f           Modify existing virtual environment and files in
                        PIPX_BIN_DIR
  --system-site-packages
                        Give the virtual environment access to the system
                        site-packages dir.
  --index-url INDEX_URL, -i INDEX_URL
                        Base URL of Python Package Index
  --editable, -e        Install a project in editable mode
  --pip-args PIP_ARGS   Arbitrary pip arguments to pass directly to pip
                        install/upgrade commands
  --verbose
```

### **pipx upgrade-all**

```bash
pipx upgrade-all --help
usage: pipx upgrade-all [-h] [--include-injected] [--skip SKIP [SKIP ...]]
                        [--force] [--verbose]

Upgrades all packages within their virtual environments by running 'pip
install --upgrade PACKAGE'

optional arguments:
  -h, --help            show this help message and exit
  --include-injected    Also upgrade packages injected into the main app's
                        environment
  --skip SKIP [SKIP ...]
                        skip these packages
  --force, -f           Modify existing virtual environment and files in
                        PIPX_BIN_DIR
  --verbose
```

### **pipx inject**

```bash
pipx inject --help
usage: pipx inject [-h] [--include-apps] [--include-deps]
                   [--system-site-packages] [--index-url INDEX_URL]
                   [--editable] [--pip-args PIP_ARGS] [--force] [--verbose]
                   package dependencies [dependencies ...]

Installs packages to an existing pipx-managed virtual environment.

positional arguments:
  package               Name of the existing pipx-managed Virtual Environment
                        to inject into
  dependencies          the packages to inject into the Virtual Environment--
                        either package name or pip package spec

optional arguments:
  -h, --help            show this help message and exit
  --include-apps        Add apps from the injected packages onto your PATH
  --include-deps        Include apps of dependent packages
  --system-site-packages
                        Give the virtual environment access to the system
                        site-packages dir.
  --index-url INDEX_URL, -i INDEX_URL
                        Base URL of Python Package Index
  --editable, -e        Install a project in editable mode
  --pip-args PIP_ARGS   Arbitrary pip arguments to pass directly to pip
                        install/upgrade commands
  --force, -f           Modify existing virtual environment and files in
                        PIPX_BIN_DIR
  --verbose
```

### **pipx uninstall**

```bash
pipx uninstall --help
usage: pipx uninstall [-h] [--verbose] package

Uninstalls a pipx-managed Virtual Environment by deleting it and any files
that point to its apps.

positional arguments:
  package

optional arguments:
  -h, --help  show this help message and exit
  --verbose
```

### **pipx uninstall-all**

```bash
pipx uninstall-all --help
usage: pipx uninstall-all [-h] [--verbose]

Uninstall all pipx-managed packages

optional arguments:
  -h, --help  show this help message and exit
  --verbose
```

### **pipx reinstall-all**

```bash
pipx reinstall-all --help
usage: pipx reinstall-all [-h] [--python PYTHON] [--skip SKIP [SKIP ...]]
                          [--verbose]

Reinstalls all packages.

Packages are uninstalled, then installed with pipx install PACKAGE
with the same options used in the original install of PACKAGE.
This is useful if you upgraded to a new version of Python and want
all your packages to use the latest as well.

optional arguments:
  -h, --help            show this help message and exit
  --python PYTHON       The Python executable used to recreate the Virtual
                        Environment and run the associated app/apps. Must be
                        v3.6+.
  --skip SKIP [SKIP ...]
                        skip these packages
  --verbose
```

### **pipx list**

```bash
pipx list --help
usage: pipx list [-h] [--include-injected] [--json] [--verbose]

List packages and apps installed with pipx

optional arguments:
  -h, --help          show this help message and exit
  --include-injected  Show packages injected into the main app's environment
  --json              Output rich data in json format.
  --verbose
```

### **pipx runpip**

```bash
pipx runpip --help
usage: pipx runpip [-h] [--verbose] package ...

Run pip in an existing pipx-managed Virtual Environment

positional arguments:
  package     Name of the existing pipx-managed Virtual Environment to run pip
              in
  pipargs     Arguments to forward to pip command

optional arguments:
  -h, --help  show this help message and exit
  --verbose
```
