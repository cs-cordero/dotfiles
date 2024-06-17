[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
export ZSH="${HOME}/.oh-my-zsh"

DEFAULT_USER=$USER
ZSH_THEME="cordero"
ZSH_CUSTOM="${HOME}/.zsh-custom"
plugins=(
    copyfile
    docker
    docker-compose
    git
    history
    pip
    python
    tmux
)

source $ZSH/oh-my-zsh.sh

bindkey '^F' forward-word
bindkey '^B' backward-word
