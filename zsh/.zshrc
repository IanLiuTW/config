export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export LC_ALL=en_US.UTF-8
export TMPDIR=/var/tmp/
export EDITOR="nvim"

setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups
setopt hist_save_no_dups hist_ignore_dups hist_find_no_dups noclobber no_beep
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy/mm/dd"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase

if [[ -z "$IN_NIX_SHELL" ]]; then
    if [[ -d "/opt/homebrew" ]]; then
        export HOMEBREW_PREFIX="/opt/homebrew"
        export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
        export HOMEBREW_REPOSITORY="/opt/homebrew"
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
        export MANPATH="/opt/homebrew/share/man:$MANPATH"
        export INFOPATH="/opt/homebrew/share/info:$INFOPATH"
    fi
fi

USER_PROFILE_FILE="~/.nix-profile/etc/profile.d/hm-session-vars.sh"
[ -f "$USER_PROFILE_FILE" ] && source "$USER_PROFILE_FILE"

ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
unalias zi 2>/dev/null

autoload -Uz compinit
if [[ -n "${XDG_CACHE_HOME}/zcompdump"(#qN.mh+24) ]]; then
  compinit -d "${XDG_CACHE_HOME}/zcompdump" -C
else
  compinit -d "${XDG_CACHE_HOME}/zcompdump"
fi

zinit ice wait"0" lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"0" lucid
zinit light zsh-users/zsh-completions
zinit ice wait"0" lucid
zinit snippet OMZP::sudo
zinit ice wait"0" lucid
zinit snippet OMZP::command-not-found
zinit ice wait"0" lucid
zinit light Aloxaf/fzf-tab
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit ice wait"0" lucid

function zvm_after_init() {
  zvm_bindkey viins '^y' autosuggest-accept
}

zinit light zsh-users/zsh-syntax-highlighting

bindkey ' ' magic-space
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' continuous-trigger 'ctrl-e'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=ctrl-y:accept
zstyle ':fzf-tab:*' switch-group 'ctrl-h' 'ctrl-l'
zstyle ':fzf-tab:*' worker 0 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

zinit cdreplay -q

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

eval "$(zoxide init zsh)"
export FZF_CTRL_R_OPTS="--bind ctrl-y:accept"
source <(fzf --zsh)

# if command -v devpod &> /dev/null; then
#     source <(devpod completion zsh)
# fi

function set_terminal_title() {
  print -Pn "\e]0;${PWD:t} ${1:+| $1}\a"
}
function preexec() { set_terminal_title "$1"; }
function precmd() { set_terminal_title; }

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# [Alias] Basics
alias q="exit"
alias f="fg"
alias G="git"
alias v="nvim"
alias vv="nvim ."
alias g="grep"
alias e="export"
alias c="cat"
alias b="bat"
alias m="make"
alias j="just"
alias d="docker"
alias du="colima start"
alias dd="colima stop"
alias p="podman"
alias dp="devpod"
alias lg="lazygit"
alias ld="lazydocker"
alias kc="kubectl"
alias bt="bpytop"
alias po="posting"
alias ssh="TERM=xterm-256color ssh"
alias ff="fastfetch -c all"
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
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias doc="cd ~/Documents"
alias pic="cd ~/Pictures"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias zz="__zoxide_zi"
# [Alias] eza
alias ls='eza --color=always --group-directories-first --icons=always'
alias ll='eza -la --icons=always --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons=always'
alias lm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons=always'
alias la='eza --long --all --group --group-directories-first --color=always'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons=always'
alias lS='eza -1 --color=always --group-directories-first --icons=always'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons=always'
alias l.="eza -a | grep -E '^\.'"
# [Alias] bat
if command -v bat >/dev/null 2>&1; then
  alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi
# [Alias] nix
alias nix-re='sudo darwin-rebuild switch --flake ~/config/nix-darwin#work'
alias nix-up='nix flake update --flake ~/config/nix-darwin/'
alias nix-hm='home-manager switch --flake ~/config/nix-darwin/'
alias nix-d='nix develop --command zsh'
alias nix-r='nix run'
# [Alias] files
alias vrc="nvim ~/.zshrc"
alias src="source ~/.zshrc"
alias config='cd ~/config && nvim'
alias todo='nvim ~/.todo.md'
# [Alias] dev
alias act='source .venv/bin/activate'
# [Alias] AI
alias ge='gemini'
alias co='codex'
alias cl='claude'

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
