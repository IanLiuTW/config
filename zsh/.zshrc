export XDG_CONFIG_HOME="$HOME/.config"
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
# export ARCHFLAGS="-arch x86_64"

# [Shell] Consider homebrew if on macOS
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# [Shell] Dynamically sets the terminal title to the current directory and command
DISABLE_AUTO_TITLE="true"
function set_terminal_title() {
  if [[ -n "$1" ]]; then
    print -Pn "\e]0;$PWD:t | $1\a"
  else
    print -Pn "\e]0;$PWD:t\a"
  fi
}
function preexec() { set_terminal_title "$1" }
function precmd() { set_terminal_title }
set_terminal_title

# [Plugins] Manager - zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
# Unalias zi since it's used for zoxide
if alias zi &>/dev/null; then
  zinit ice atload'unalias zi'
fi
# [Plugins] Basics
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab
# [Plugins] vi mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
zinit ice depth=1 wait"1" lucid
zinit light jeffreytse/zsh-vi-mode
# [Plugins] OMZ's
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::aws
# Only load zinit snippet for OMZP::asdf if NOT in nix-shell
if [[ ! -n $IN_NIX_SHELL ]]; then
  zinit ice wait"1" lucid
  zinit snippet OMZP::asdf
fi
# [Plugins] Loading up
autoload -U compinit && compinit
bindkey '^e' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy/mm/dd"
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zinit cdreplay -q

# [Shell] Prompt
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship # starship

# [Shell] Integrations
# zoixide
eval "$(zoxide init zsh)"
#fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# devpod
if command -v devpod &> /dev/null; then
    source <(devpod completion zsh)
fi
# Nix home-manager
USER_PROFILE_FILE="/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
if [ -f "$USER_PROFILE_FILE" ]; then
    source "$USER_PROFILE_FILE"
fi

# [Alias] Basics
alias q="exit"
alias f="fg"
alias C="clear"
alias G="git"
alias v="nvim"
alias y="yazi"
alias g="grep"
alias c="cat"
alias b="bat"
alias m="make"
alias d="docker"
alias kc="kubectl"
alias bt="bpytop"
alias lg="lazygit"
alias ld="lazydocker"
alias dp="devpod"
alias ssh="TERM=xterm-256color ssh"
alias vrc="nvim ~/.zshrc"
alias src="source ~/.zshrc"
# [Alias] Navigation
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias rg='rg --hidden'
alias desktop="cd ~/Desktop"
alias downloads="cd ~/Downloads"
alias documents="cd ~/Documents"
alias pictures="cd ~/Pictures"
alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."
alias .....="z ../../../.."
alias Z="zi"
# [Alias] eza
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias lm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons'
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"
# [Alias] bat
if command -v bat >/dev/null 2>&1; then
  alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi
# [Alias] nix
alias nix-re='darwin-rebuild switch --flake ~/config/nix-darwin#work'
# [Alias]
alias todo='nvim ~/.todo'

# [Commands] Start
nerdfetch && echo ""
