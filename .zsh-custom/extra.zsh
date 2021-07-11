################################################################################
#   Python Venv Wrapper
################################################################################

if [[ -f ~/.pyvenvwrapper/.pyvenvwrapper ]]; then
    . ~/.pyvenvwrapper/.pyvenvwrapper
fi


################################################################################
# did file
################################################################################
alias did="vim +'normal ggO' +'r!date' ~/did.txt"


################################################################################
#   Sensible Python Configs
################################################################################

function copy_sensible_python_config_files {
    cp ~/.sensible_python_configs/* ./
    cp ~/.sensible_python_configs/.[^.]* ./
}


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
