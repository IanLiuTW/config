# Oh My Posh

## ****Installation****

### ****Installation (Windows)****

### ****Install `Nerd Fonts`**

Go to [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.1.0)

**Install `OhMyPosh`**

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

For updating the module

```powershell
winget upgrade JanDeDobbeleer.OhMyPosh -s winget
```

**Adjust Windows Terminal config**

- In `Settings` => `PowerShell Core`, `Windows PowerShell`, `WSL` => `Appearance`: Change the `Font face` to `CaskaydiaCove Nerd Font Mono` (or other desired font).

**Setting `Oh My Posh` theme**

```powershell
New-Item -Path '~/.ohmyposhv1-ian.omp.json' -ItemType File
notepad $HOME/.ohmyposhv1-ian.omp.json
```

- Copy [ohmyposhv1-ian.omp.json](https://github.com/IanLiuTW/config/blob/main/Oh%20My%20Posh/ohmyposhv1-ian.omp.json) or [montys](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/montys.omp.json) to `ohmyposhv1-ian.omp.json`

**Setting `$PROFILE`**

```powershell
notepad $PROFILE
```

```powershell
oh-my-posh init pwsh --config ~/.ohmyposhv1-ian.omp.json | Invoke-Expression
```

### ****Installation (Linux)****

**Install `Oh My Posh`**

```bash
winget install JanDeDobbeleer.OhMyPosh -s wingetsudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
```

**Install font (Not needed if using WSL)**

```bash
mkdir ~/.fonts && cd "$_"

wget -O CascadiaCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
unzip CascadiaCode.zip
rm CascadiaCode.zip

sudo fc-cache -vr
fc-list
```

**Create `ohmyposhv1-ian.omp.json`**

```bash
mkdir ~/.poshthemes
vim ~/.poshthemes/ohmyposhv1-ian.omp.json
```

- Copy [ohmyposhv1-ian.omp.json](https://github.com/IanLiuTW/config/blob/main/Oh%20My%20Posh/ohmyposhv1-ian.omp.json) or [montys](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/montys.omp.json) to `ohmyposhv1-ian.omp.json`

Add this line to `.bashrc`

```bash
# Oh My Posh theme
eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/ohmyposhv1-ian.omp.json)"
```
