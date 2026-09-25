# Oh My Posh

[Oh My Posh](https://ohmyposh.dev/) draws a themed prompt in any shell. This folder holds the theme [`ohmyposhv1-ian.omp.json`](ohmyposhv1-ian.omp.json). The official theme [montys](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/montys.omp.json) is a close alternative.

## 1. Install Oh My Posh

Windows:

```powershell
winget install JanDeDobbeleer.OhMyPosh --source winget
# upgrade later with:
winget upgrade JanDeDobbeleer.OhMyPosh --source winget
```

Linux (installs to `~/bin` or `~/.local/bin`):

```shell
curl -s https://ohmyposh.dev/install.sh | bash -s
```

Inside WSL, follow the Linux steps.

## 2. Install a Nerd Font

The themes use icons from a [Nerd Font](https://www.nerdfonts.com/). Oh My Posh can install one:

```shell
oh-my-posh font install CascadiaCode   # installs "CaskaydiaCove Nerd Font" and "CaskaydiaCove Nerd Font Mono"
oh-my-posh font list                   # every font you can install
```

Install the font on the machine that runs the terminal window. For WSL or a container, that is the Windows host.

Then select the font in the terminal. In Windows Terminal: **Settings > Profiles > Defaults > Appearance > Font face**.

## 3. Add the theme

Copy [`ohmyposhv1-ian.omp.json`](ohmyposhv1-ian.omp.json) to your home directory as `~/.ohmyposhv1-ian.omp.json`.

## 4. Load the prompt from your shell profile

PowerShell. Open the profile with `notepad $PROFILE` and add:

```powershell
oh-my-posh init pwsh --config ~/.ohmyposhv1-ian.omp.json | Invoke-Expression
```

bash. Add to `~/.bashrc`:

```shell
eval "$(oh-my-posh init bash --config ~/.ohmyposhv1-ian.omp.json)"
```

zsh. Add to `~/.zshrc`:

```shell
eval "$(oh-my-posh init zsh --config ~/.ohmyposhv1-ian.omp.json)"
```

Open a new shell to see the prompt.
