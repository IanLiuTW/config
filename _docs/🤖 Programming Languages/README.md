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

### ****Languages Installation Guide****

Remember to check dependencies from the plugin page before install a version. Check the document for each language in the directory.

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
