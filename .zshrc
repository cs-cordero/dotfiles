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
    my-git-aliases
)

source $ZSH/oh-my-zsh.sh
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
