
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


################################################################################
#   Bash Prompt
################################################################################

color_prompt=false
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=true
fi

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PROMPT_COMMAND='PS1X=$(sed "s:\([^/]\)[^/]*/:\1/:g" <<<${PWD/#$HOME/\~})'
PROMPT_CHROOT="${debian_chroot:+(${debian_chroot})}"
if [ "$color_prompt" = true ]; then
    PS1='\[\033[00m\]${PROMPT_CHROOT}'  # appears if we are chroot'd
    PS1+='\[\033[01;32m\]\u'            # username
    PS1+='\[\033[00;32m\]@\h'           # host
    PS1+='\[\033[00m\]:'                # : symbol
    PS1+='\[\033[01;34m\]${PS1X}'       # minified directory path
    PS1+='\[\033[00m\]\$ '              # $ symbol
else
    PS1='${PROMPT_CHROOT}\u@\h:${PS1X}$ '
fi

unset color_prompt


################################################################################
#   History Options
################################################################################

# see bash(1) for explanations of these options
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend


################################################################################
#   Other Options
################################################################################

# automatically adjusts LINES and COLUMNS based on the window size
shopt -s checkwinsize

# allows usage of ** in filepaths only valid in bash
[[ "$OSTYPE" == "darwin"* ]] || shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && \
            eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# setup for symlinks
set -o physical
export CDPATH="$CDPATH:$HOME/.symlinks"


################################################################################
#   Command Aliases
################################################################################

# ubuntu command aliases
alias shutdown='shutdown now'
alias powersleep='systemctl suspend'

# git command aliases
alias gs='git status $*'
alias gl='git log --oneline --decorate -10 $*'
alias ga='git add $*'
alias gc='git commit $*'
alias go='git checkout $*'
alias gb='git branch $*'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

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

# open arbitrary files
if [[ "$OSTYPE" != "darwin"* ]]; then
    function alt_open {
        nohup xdg-open "$@" &>/dev/null &
    }
    alias open='alt_open'
fi

# did file
alias did="vim +'normal ggO' +'r!date' ~/did.txt"

################################################################################
#   Python Venv Wrapper
################################################################################

if [[ -f ~/.pyvenvwrapper/.pyvenvwrapper ]]; then
    . ~/.pyvenvwrapper/.pyvenvwrapper
fi


################################################################################
#   Sensible Python Configs
################################################################################

function copy_sensible_python_config_files {
    cp ~/.sensible_python_configs/* ./
    cp ~/.sensible_python_configs/.[^.]* ./
}


################################################################################
#   Bash Aliases
################################################################################

# use a bash_aliases file for directory aliases or environment-specific settings
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

################################################################################
#   Git Completion
################################################################################

# sets up git completion, the __git_complete sets it up to work with our aliases
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    __git_complete go _git_checkout
    __git_complete gb _git_branch
fi

################################################################################
#   .gitignore Auto Generation
################################################################################

function generate_gitignore {
    if [[ $# -le 0 ]]; then
        printf "E: Requires at least one argument.  (Supported: python, node)\n" >&2;
        return 1;
    fi

    PYTHON=0
    NODE=0
    for val in "$@"; do
        if [[ "$val" == "python" ]]; then
            PYTHON=1
            echo "$val $PYTHON $NODE"
        elif [[ "$val" == "node" ]]; then
            NODE=1
            echo "$val $PYTHON $NODE"
        else
            printf "E: Unknown argument $val\n" >&2;
        fi
    done

    if [[ $PYTHON -eq 1 ]]; then
        curl https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore >> .gitignore
        echo "Appended default Python .gitignore from github into .gitignore!"
    fi
    if [[ $NODE -eq 1 ]]; then
        curl https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore >> .gitignore
        echo "Appended default Node .gitignore from github into .gitignore!"
    fi
    return 0
}

################################################################################
#   DB_DATABASE Environment Variable
################################################################################

function db() {
    if [[ -z $DB_DATABASE ]]; then
        echo "E: No DB_DATABASE set!"
    else
        echo $DB_DATABASE
    fi
}

function godb() {
    export DB_DATABASE=$1
    echo "DB_DATABASE changed to: $1"
}

################################################################################
#   Loading env files wrapped with set -a
################################################################################

function loadenv {
    if [[ $# -le 0 ]]; then
        printf "E: Requires a filename.\n" >&2;
        printf "Usage: loadenv filename [arguments]\n";
        return 1;
    fi

    set -a
    . $@
    set +a
}

################################################################################
#   Install nvm and pyenv
################################################################################

function installnvm {
    set -e
    which nvm && echo "nvm seems to already be installed" && exit 1
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh > /tmp/nvm-install.sh
    bash /tmp/nvm-install.sh
    NVM_DIR=$HOME/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && chmod +x "$NVM_DIR/nvm.sh"
    command printf "\n" >> "$HOME/.bash_aliases"
    command printf 'export NVM_DIR=$HOME/.nvm\n' >> "$HOME/.bash_aliases"
    command printf '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"\n' >> "$HOME/.bash_aliases"
    command printf '[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"\n' >> "$HOME/.bash_aliases"
    [ -s "/tmp/nvm-install.sh" ] && rm /tmp/nvm-install.sh
    echo "Success.  The install script might have appended commands to your .bashrc or .bash_profile, though.  You may want to delete that."
}

################################################################################
#   Removing git submodules (kind of shaky)
################################################################################

function removegitsubmodule {
    if [[ $# -le 0 ]]; then
        printf "E: Requires a submodule path from the git root.\n" >&2;
        printf "Usage: removegitsubmodule submodulepath\n";
        return 1;
    fi

    if [[ ! -e .git/ ]]; then
        printf "E: Run this command from your root git folder.\n" >&2;
        return 1;
    fi

    if [[ ! -e $1 ]]; then
        printf "E: Cannot locate $1.\n" >&2;
        return 1;
    fi

    if [[ "$1" = /* ]]; then
        printf "E: As a safety precaution, no absolute pathing it must be relative"
        return 1;
    fi

    SUBMODULEPATH=$1
    git stash --quiet
    git config -f .git/config --remove-section submodule.$SUBMODULEPATH
    git config -f .gitmodules --remove-section submodule.$SUBMODULEPATH
    rm -rf $SUBMODULEPATH
    rm -rf .git/modules/$SUBMODULEPATH
    git rm --cached $SUBMODULEPATH
    git add .gitmodules
    git add $SUBMODULEPATH
    git commit -m "Removed submodule $1."
    git stash pop --quiet
}

################################################################################
################################################################################
