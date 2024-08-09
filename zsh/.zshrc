export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 15
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy/mm/dd"
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment the following line if you want to disable marking untracked files under VCS as dirty. 
# This makes repository status check for large repositories much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    copypath
    dirhistory
    # command-not-found
    # git
    asdf
    poetry
    web-search
)
ZSH_WEB_SEARCH_ENGINES=(
    gg "https://www.google.com/search?q="
    yt "https://www.youtube.com/results?search_query="
    imdb "https://www.imdb.com/find/?q="
)

source $ZSH/oh-my-zsh.sh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Set up asdf
fpath=(${ASDF_DIR}/completions $fpath)

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
zstyle ':completion::complete:*' gain-privileges 1

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
# export MANPATH="/usr/local/man:$MANPATH"

alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."
alias .....="zz ../../../.."
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias rg='rg --hidden'

# eza
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"

alias zshrc="nvim ~/.zshrc"
alias zshrcs="source ~/.zshrc"
alias g="git"
alias v="nvim"
alias lg="lazygit"
alias ld="lazydocker"
alias dp="devpod"
alias ssh="TERM=xterm-256color ssh"

# Alias for directories
alias zt="z ~/workspace_tupl/"
alias zp="z ~/workspace_playground/"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up zoxide
eval "$(zoxide init zsh)"

# Set up devpod completion
# source <(devpod completion zsh)

# Set up diff-so-fancy for lazygit
export PATH=$HOME/diff-so-fancy:$PATH

nerdfetch && echo ""
