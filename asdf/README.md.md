# asdf

- **[asdf](https://asdf-vm.com/)**
- **[Plugins](https://github.com/asdf-vm/asdf-plugins)**
- **[Docs](https://asdf-vm.com/manage/core.html#installation-setup)**

## ****Installation****

### ****Install from git****

```bash
sudo apt install curl git
```

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2
```

Edit ~/.bashrc and add the followings codes:

```bash
sudo vim ~/.bashrc
```

```bash
# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
```

```bash
source ~/.bashrc
```

### ****Quick workflow****

Remember to check dependencies from the plugin page before install a version.

[Python](https://github.com/danhper/asdf-python)

```bash
sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev libedit-dev

asdf plugin add python
asdf install python latest
asdf global python latest

python --version
python -m pip --version
```

[Node.js](https://github.com/asdf-vm/asdf-nodejs)

```bash
sudo apt install dirmngr gpg curl gawk

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

node -v
```

[Go](https://github.com/kennyp/asdf-golang)

```bash
apt install coreutils curl

asdf plugin add golang
asdf install golang latest
asdf global golang latest

go version
```

[Rust](https://github.com/asdf-community/asdf-rust)

```bash
asdf plugin add rust
asdf list all rust
asdf install rust latest
asdf global rust latest

rustc --version
```

[Java](https://github.com/halcyon/asdf-java)

```bash
asdf plugin add java
asdf list all java
asdf install java adoptopenjdk-16.0.1+9 # select version from list
asdf global java adoptopenjdk-16.0.1+9 # select version from list

java --version
```

## ****Plugins****

### ****List Plugins****

```bash
asdf plugin list
asdf plugin list --urls
asdf plugin list all
```

### **Add**

```bash
asdf plugin add <name>
asdf plugin add <name> <git-url>
```

### **Update**

```bash
asdf plugin update <name>
asdf plugin update --all
```

### **Remove**

```bash
asdf plugin remove <name>
```

## ****Versions****

### **List Versions**

```bash
asdf list <name>
asdf list <name> <version> # Limit versions to those that begin with a given string

asdf list all <name> # List All Available Versions
asdf list all <name> <version> # Limit versions to those that begin with a given string

asdf latest <name> # Show Latest Stable Version
asdf latest <name> <version> # Show latest stable version that begins with a given string
```

### **Install**

```bash
asdf install <name> <version>
asdf install <name> latest # Install Latest Stable Version
asdf install <name> latest:<version> # Install latest stable version that begins with a given string
```

### **Set Current Version**

```bash
asdf global <name> <version> [<version>...]
asdf shell <name> <version> [<version>...]
asdf local <name> <version> [<version>...]

asdf global <name> latest[:<version>]
asdf local <name> latest[:<version>]
```

`global` writes the version to `$HOME/.tool-versions`.

`shell` set the version to an environment variable named `ASDF_${LANG}_VERSION`, for the current shell session only.

`local` writes the version to `$PWD/.tool-versions`, creating it if needed.

### **Fallback to System Version**

```bash
asdf global <name> system
asdf shell <name> system
asdf local <name> system
```

### **View Current Version**

```bash
asdf current
asdf current <name>
```

### **Uninstall Version**

```bash
asdf uninstall <name> <version>
```

## ****Configurations****

### **.tool-versions**

Whenever `.tool-versions` file is present in a directory, the tool versions it declares will be used in that directory and any subdirectories. Global defaults can be set in the file `$HOME/.tool-versions`

To install all the tools defined in a `.tool-versions` file run `asdf install` with no other arguments in the directory containing the `.tool-versions` file.
