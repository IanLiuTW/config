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
zinit ice atload'unalias zi'
# [Plugins] Basics
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# [Plugins] OMZ's
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::archlinux
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
# zinit snippet OMZP::aws
zinit snippet OMZP::asdf
# [Plugins] Loading up
autoload -U compinit && compinit
bindkey '^y' autosuggest-accept
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
eval "$(zoxide init zsh)" # zoixide
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # fzf
if command -v devpod &> /dev/null; then # devpod
    source <(devpod completion zsh)
fi

# [Alias] Basics
alias q="exit"
alias f="fg"
alias g="git"
alias v="nvim"
alias c="clear"
alias m="make"
alias b="bat"
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
alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."
alias .....="z ../../../.."
alias Z="zi"
# [Alias] eza
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"

# [Commands] Start
nerdfetch && echo ""
