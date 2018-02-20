
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

PROMPT_COMMAND='PS1X=$(perl -pl0 -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD})'
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

# allows usage of ** in filepaths
# on OS X, requires brew install bash. if using iTerm2 this cannot be used.
# shopt -s globstar

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

# ls aliases
# alias ll='ls -alF --color=auto'
# alias la='ls -A --color=auto'
# alias ls='ls -A -C --group-directories-first --color=auto'
# alias l='ls -CF --color=auto'

# for OS X
alias ll='ls -alFG'
alias la='ls -AG'
alias ls='ls -ACG'
alias l='ls -CFG'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# open arbitrary files
function alt_open {
    nohup xdg-open "$@" &>/dev/null &
}
alias open='alt_open'

# use a bash_aliases file for directory aliases or environment-specific settings
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

################################################################################
################################################################################
