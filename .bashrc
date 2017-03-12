# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi

PROMPT_COMMAND='PS1X=$(perl -pl0 -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD})'
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]${PS1X}\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u:${PS1X}$ '
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# PERSONAL edits
# ---------------

alias shutdown='shutdown now'
alias powersleep='systemctl suspend'
alias firefox='nohup firefox &>/dev/null &'
alias chrome='nohup google-chrome &>/dev/null &'
alias spotify='nohup spotify --force-device-scale-factor=2.0 &>/dev/null &'
alias godot='nohup /usr/local/bin/Godot_v2.1.2-stable_x11.64 &>/dev/null &'
alias battlenet='nohup wine /home/cs-cordero/.wine/drive_c/Program\ Files/Battle.net/Battle.net.exe &>/dev/null &'
alias steam='nohup steam &>/dev/null &'
alias tmux='tmux a'
alias ka='killall tmux'
alias v='vim'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -A -C --group-directories-first --color=auto'

# Git aliases
alias gs='git status'
alias gl='git log --oneline --decorate -10'
alias ga='git add'
alias gc='git commit -m'
alias go='git checkout'
alias gb='git branch'

function alt_open {
    nohup xdg-open "$@" &>/dev/null &
}
alias open='alt_open'

# Set-up for symlinks
set -o physical
export CDPATH="$CDPATH:/home/cs-cordero/.symlinks"

# added by Anaconda2 4.3.0 installer
export PATH="/home/cs-cordero/.anaconda2/bin:$PATH"

