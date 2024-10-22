# TODO:
# - Make Clipboard work for neovim
# - Migrate to Nix

# [Nix]
# curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi

# [asdf and some languages]
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
export ASDF_DIR="$HOME/.asdf" && . "$HOME/.asdf/asdf.sh" 
asdf plugin add lua && asdf install lua 5.1 && asdf global lua 5.1
asdf plugin add nodejs && asdf install nodejs latest && asdf global nodejs latest

# [zsh]
apt install -y zsh
sudo chsh -s /usr/bin/zsh $USER
# [eza]
wget -c https://github.com/eza-community/eza/releases/latest/download/eza_aarch64-unknown-linux-gnu.tar.gz -O - | tar xz
sudo chmod +x eza && sudo chown root:root eza && sudo mv eza /usr/local/bin/eza
# [zoxide]
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
# [fzf]
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# [nvim]
apt install -y ninja-build gettext cmake unzip curl build-essential
git clone https://github.com/neovim/neovim ~/neovim
sudo make -C ~/neovim CMAKE_BUILD_TYPE=RelWithDebInfo && make -C ~/neovim install
apt install -y ripgrep fd-find

# [nerdfetch]
sudo curl -fsSL https://raw.githubusercontent.com/ThatOneCalculator/NerdFetch/main/nerdfetch -o /usr/bin/nerdfetch
sudo chmod +x /usr/bin/nerdfetch

# [stow configs]
apt install -y stow
rm -rf ~/.zshrc ~/.gitconfig
stow -d ~/config -t ~/ zsh nvim git starship
