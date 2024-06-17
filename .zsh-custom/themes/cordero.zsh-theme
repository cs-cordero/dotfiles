# cordero.zsh-theme
# ANSI-only colors — adapts to terminal color preset
# By Christopher Cordero (based on af-magic)

typeset +H return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function ABBREVIATED_PWD {
    echo $(sed "s:\([^/]\)[^/]*/:\1/:g" <<<${PWD/#$HOME/\~})
}

# primary prompt
PS1='%{$fg[blue]%}$(ABBREVIATED_PWD)$(git_prompt_info)$(hg_prompt_info)%{$reset_color%} '
PS1+='%{$fg[magenta]%}%(!.#.»)%{$reset_color%} '
PS2='%{$fg[red]%} %{$reset_color%}'
RPS1='${return_code}'

# right prompt
(( $+functions[virtualenv_prompt_info] )) && RPS1+='$(virtualenv_prompt_info)'
RPS1+=' %{$fg[default]%}%n@%{$fg[cyan]%}%m%{$reset_color%}'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[blue]%}(%{$fg[green]%}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[yellow]%}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" %{$fg[blue]%}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"
