export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

setopt sharehistory hist_ignore_space hist_ignore_all_dups
setopt hist_save_no_dups hist_find_no_dups noclobber no_beep
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
WORDCHARS=${WORDCHARS//[\/.-]}

# /etc/zshrc runs brew shellenv, which prepends Homebrew. Move it behind Nix
# (so nix and devshell tools win) but ahead of the macOS system dirs.
path=(${path:#/opt/homebrew/(s|)bin})
path[${path[(i)/usr/local/bin]},0]=(/opt/homebrew/bin /opt/homebrew/sbin)

ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
unalias zi 2>/dev/null

ZVM_LAZY_KEYBINDINGS=true
ZVM_INIT_MODE=sourcing

zinit ice wait"0" lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"0" lucid
zinit light zsh-users/zsh-completions
zinit ice wait"0" lucid
zinit snippet OMZP::sudo
zinit ice wait"0" lucid
zinit light Aloxaf/fzf-tab
zinit ice wait"0" lucid depth=1
zinit light jeffreytse/zsh-vi-mode

# Cache each tool's shell init to avoid a subprocess per startup. Nix store
# mtimes are fixed, so the cache is keyed on the binary's resolved store path:
# an upgrade changes the path and regenerates the cache.
function cache_init() {
  local cache=$XDG_CACHE_HOME/$1-zsh-init.zsh bin=${commands[$1]:A}
  [[ -f $cache && -f $cache.key && $(<$cache.key) == $bin ]] && return
  "$@" >| $cache && print -r -- $bin >| $cache.key
}

FZF_ZSH_CACHE="${XDG_CACHE_HOME}/fzf-zsh-init.zsh"
cache_init fzf --zsh

# Source fzf after zvm init so zvm doesn't clobber fzf keybindings
function zvm_after_init() {
  zvm_bindkey viins '^y' autosuggest-accept
  source "$FZF_ZSH_CACHE"
  bindkey '^g' fzf-cd-widget   # remap Alt-C -> Ctrl-G (Alt-C taken by system)
}

# compinit's file-count check never matches what compdump writes (fpath holds
# duplicate and mixed-version dirs from nix + brew + zinit), so it rebuilt the
# dump on every start — ~1.7s. -C loads the dump unchecked; the age gate does a
# real rebuild once a day so new completions still get picked up.
function zicompinit_fast() {
  setopt localoptions extendedglob   # (#q...) qualifiers inside [[ ]]
  autoload -Uz compinit
  local zcd=$XDG_CACHE_HOME/zcompdump
  if [[ -n $zcd(#qN.mh+24) ]]; then compinit -d $zcd; else compinit -C -d $zcd; fi
}

# Syntax highlighting loaded last — triggers deferred compinit. This is the
# only compinit (/etc/zshrc's is off), so compdef does not exist yet when the
# zoxide init runs and zoxide skips its completion; register it here.
zinit ice wait"0" lucid atinit"zicompinit_fast; zicdreplay; compdef __zoxide_z_complete z"
zinit light zsh-users/zsh-syntax-highlighting

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' continuous-trigger 'ctrl-e'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=ctrl-y:accept
zstyle ':fzf-tab:*' switch-group 'ctrl-h' 'ctrl-l'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

cache_init starship init zsh
source "${XDG_CACHE_HOME}/starship-zsh-init.zsh"

cache_init zoxide init zsh
source "${XDG_CACHE_HOME}/zoxide-zsh-init.zsh"

export FZF_DEFAULT_OPTS="--bind shift-tab:toggle-preview"
export FZF_CTRL_R_OPTS="--bind ctrl-y:accept"

# Tab title: "<repo>:<subdir> | <program>", prefixed with a marker while a
# command runs or when the last one failed. Repo root is found by walking up
# for .git (a file in worktrees, hence -e) to avoid forking git each prompt.
function set_terminal_title() {
  local marker=$1 top=$PWD rel dir cmd
  local -a w=(${(z)2})
  if [[ ${w[1]:t} == sudo ]]; then
    shift w
    # skip sudo's own flags; -u and friends consume the following word too
    while (( $#w )) && [[ ${w[1]} == -* ]]; do
      [[ ${w[1]} == -[ugpChRTU] ]] && shift w
      (( $#w )) && shift w
    done
    cmd="#${${w[1]:t}:-sudo}"
  else
    cmd=${w[1]:t}
  fi
  while [[ $top != / && ! -e $top/.git ]]; do top=${top:h}; done
  if [[ $top == / ]]; then
    dir=${${PWD:t}:-/}
  else
    rel=${${PWD#$top}#/}
    dir="${top:t}${rel:+:$rel}"
  fi
  print -n "\e]0;${marker}${dir}${cmd:+ | $cmd}\a"
}
function preexec() { set_terminal_title '▸ ' "$1"; }
function precmd() {
  local ret=$?
  local marker=
  # 130/148 are Ctrl-C and Ctrl-Z, not failures worth flagging
  (( ret == 0 || ret == 130 || ret == 148 )) || marker="✗${ret} "
  set_terminal_title "$marker"
}

function spf() {
	case "$(uname -s)" in
		Darwin) export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir" ;;
		Linux)  export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir" ;;
	esac
	command spf "$@"
	[ ! -f "$SPF_LAST_DIR" ] || {
		. "$SPF_LAST_DIR"
		rm -f -- "$SPF_LAST_DIR"
	}
}

# [Alias] Basics
alias q="exit"
alias g="rg --hidden --no-ignore"
alias G="git"
alias f="spf"
alias v="nvim"
alias vv="nvim ."
alias e="export"
alias c="cat"
alias b="bat"
alias m="make"
alias j="just"
alias d="docker"
alias do-up="colima start --memory 4 --disk 100"
alias do-down="colima stop"
alias do-prune='docker system prune -a --filter "until=720h"'
alias do-stop='c=$(docker ps -q); [ -n "$c" ] && docker stop ${(f)c} || echo "no running containers"'
alias dp="devpod"
alias lg="lazygit"
alias ld="lazydocker"
alias k="k9s -c svc"
alias kc="kubectl"
alias fx="flux"
alias bt="btop"
alias di="dua i"
alias pc="procs"
alias po="posting"
alias ssh="TERM=xterm-256color ssh"
alias ff="fastfetch -c all"
# [Alias] Navigation
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -I"
alias rg='rg --hidden'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -='cd -'
alias zz="__zoxide_zi"
# [Alias] eza
alias ls='eza --color=auto --group-directories-first --icons=auto'
alias ll='eza -la --icons=auto --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=auto --group-directories-first --icons=auto'
alias lm='eza -lbGd --header --git --sort=modified --color=auto --group-directories-first --icons=auto'
alias la='eza --long --all --group --group-directories-first --color=auto'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=auto --group-directories-first --icons=auto'
alias lS='eza -1 --color=auto --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --color=auto --group-directories-first --icons=auto'
alias l.='eza -d .*'
# [Alias] bat
if command -v bat >/dev/null 2>&1; then
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi
# [Alias] nix
alias nix-rebuild='sudo darwin-rebuild switch --flake ~/config/nix-darwin#work'
alias nix-update='nix flake update --flake ~/config/nix-darwin/ && nix-rebuild'
alias nix-clean="sudo nix-collect-garbage -d && nix-collect-garbage -d && nix-store --optimize"
alias nix-dev='nix develop --command zsh'
alias nix-run='nix run'
# [Alias] files
alias vrc="nvim ~/.zshrc"
alias src="source ~/.zshrc"
alias todo='nvim ~/.todo.md'
alias con='cd ~/config'
alias des="cd ~/Desktop"
alias dow="cd ~/Downloads"
alias doc="cd ~/Documents"
alias pic="cd ~/Pictures"
# [Alias] dev
alias act='source .venv/bin/activate'
# [Alias] AI
alias cc='claude'
alias ccc='claude --continue'
alias ccr='claude --resume'
alias ccyolo='claude --dangerously-skip-permissions'
alias ag='agy'
alias co='codex'
alias h='herdr'

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
# pnpm comes from Nix; PNPM_HOME holds `pnpm add -g` binaries
export PNPM_HOME="$HOME/Library/pnpm"
path=($PNPM_HOME $path)

# Drop duplicate entries, keeping the first, so lookup order does not change.
# Last, because a scalar `PATH=...` assignment bypasses the unique flag.
typeset -U path fpath
