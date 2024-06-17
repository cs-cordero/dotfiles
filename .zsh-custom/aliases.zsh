# git aliases
alias gs='git status'
alias go='git checkout'
alias gl='git log --oneline --decorate -10'

# vim to neovim aliases
alias vi='nvim'
alias vim='nvim'

# ls aliases
unalias ll 2>/dev/null
unalias la 2>/dev/null
unalias ls 2>/dev/null
unalias l 2>/dev/null
LSPROG='ls'
LSARGS="--color=auto --group-directories-first --ignore=__pycache__"
[[ "$OSTYPE" == "darwin"* ]] && LSPROG='gls'
if ! [[ -x $(command -v $LSPROG) ]]; then
    echo "Warning:  Missing program $LSPROG."
    echo "If '$LSPROG' is 'gls' and you are on Mac, please run brew install coreutils"
    echo "If '$LSPROG' is 'ls', God help you."
else
    alias ll="$LSPROG -aAFGlh $LSARGS"
    alias la="$LSPROG -aAGh $LSARGS"
    alias ls="$LSPROG -ACFGh $LSARGS"
    alias l="$LSPROG -ACFGh $LSARGS"
fi

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# open arbitrary files (Linux only, macOS has native `open`)
if [[ "$OSTYPE" != "darwin"* ]]; then
    function alt_open {
        nohup xdg-open "$@" &>/dev/null &
    }
    alias open='alt_open'
fi
