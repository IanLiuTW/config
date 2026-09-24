# TODO:
# - Make Clipboard work for neovim
# - Migrate to Nix

# [Nix]
# curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi

# [apt]
sudo apt update
sudo apt upgrade
sudo apt install -y git cmake unzip curl wget build-essential libreadline-dev

# [asdf and some languages]
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
export ASDF_DIR="$HOME/.asdf" && . "$HOME/.asdf/asdf.sh" 
asdf plugin add lua && asdf install lua 5.1 && asdf global lua 5.1
asdf plugin add nodejs && asdf install nodejs latest && asdf global nodejs latest

# [zsh]
sudo apt install -y zsh
sudo chsh -s /usr/bin/zsh $USER
# [eza]
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
# [zoxide]
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
# [fzf]
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# [nvim]
apt install -y ripgrep fd-find ninja-build gettext
git clone https://github.com/neovim/neovim ~/neovim
sudo make -C ~/neovim CMAKE_BUILD_TYPE=RelWithDebInfo && make -C ~/neovim install

# [nerdfetch]
sudo curl -fsSL https://raw.githubusercontent.com/ThatOneCalculator/NerdFetch/main/nerdfetch -o /usr/bin/nerdfetch
sudo chmod +x /usr/bin/nerdfetch

# [stow configs]
sudo apt install -y stow
rm -rf ~/.zshrc ~/.gitconfig
stow -d ~/config -t ~/ zsh nvim git starship
