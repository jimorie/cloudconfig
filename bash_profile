# Locale setup

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export HISTSIZE=10000
export HISTCONTROL=ignoreboth:erasedups
export BASH_SILENCE_DEPRECATION_WARNING=1

# Prompt setup

#PS1="\n\[\033[00;32m\]\u@\h\[\033[00;33m\]\$(if [[ -n \$VIRTUAL_ENV ]]\; then echo basename \$VIRTUAL_ENV; else echo " "\; fi)\[\033[00;36m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 1) \[\033[01;34m\]\w\n\[\033[01;30m\]\$\[\033[00m\] "

PROMPT_COMMAND=prompter

function prompter() {
    export PS1="\n$(_usercolor)\u@\h$(_venv)\[\033[00;36m\] $(_pwb)\[\033[01;34m\]\w\n\[\033[01;30m\]\$\[\033[00m\] "
}

function _usercolor {
    if [[ $(id -u) -eq 0 ]]; then
        echo "\[\033[00;35m\]"
    else
        echo "\[\033[00;32m\]"
    fi
}

function pwb {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

function _pwb {
    pwb | tr '\n' ' '
}

function _venv {
    if [[ -n $VIRTUAL_ENV ]]; then
        venvroot=`dirname $VIRTUAL_ENV`
        if [[ "$PWD/" = "$venvroot/"* ]]; then
            echo "\[\033[00;33m\] `basename $venvroot`"; 
        else
            echo "\[\033[00;31m\] `basename $venvroot`"; 
        fi
    fi
}

export CLICOLOR=1;
export LSCOLORS=ExGxcxdxCxxxxxxxxxxxxx;

if [[ `uname` = "Linux" ]]; then
    alias ls='ls --color=auto'
fi
alias l='ls'
alias ll='ls -lh'
alias la='ls -a'
alias d='cd ..'

alias cloc='grep -cve "^\s*$"'

# Git setup
alias gc='git commit'
alias gd='git diff'
alias gf='git fetch'
alias gg='git grep -n'
alias gl='git --no-pager log -3'
alias gs='git status'
alias gp='git pull --ff-only'
alias ga='git add -u;git status'
alias gt='git checkout'

if [[ -d "/usr/local/git/bin" && ":$PATH:" != *":/usr/local/git/bin:"* ]]; then
    PATH="/usr/local/git/bin":$PATH
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Pyenv setup
if [[ -d "$HOME/.pyenv/bin" && ":$PATH:" != *":$HOME/.pyenv/bin:"* ]]; then
    PATH="$HOME/.pyenv/bin":$PATH
fi
if which pyenv > /dev/null 2>&1;
    then eval "$(pyenv init -)";
fi

# Virtualenv setup
alias venv='source venv/bin/activate 2> /dev/null || source .venv/bin/activate'
export VIRTUAL_ENV_DISABLE_PROMPT=1
if [[ -n $VIRTUAL_ENV ]]; then
    if [[ `which python` != "$VIRTUAL_ENV"* ]]; then
        unset VIRTUAL_ENV
    fi
fi

# Pipenv setup
export PIPENV_VENV_IN_PROJECT=1

# Go setup
export GOPATH=$HOME/Projects/go
if [[ -d "$GOPATH/bin" && ":$PATH:" != *":$GOPATH/bin:"* ]]; then
    PATH="$GOPATH/bin":$PATH
fi

# Poetry setup
if [[ -d "$HOME/.poetry/bin" && ":$PATH:" != *":$HOME/.poetry/bin:"* ]]; then
    PATH="$HOME/.poetry/bin":$PATH
fi

# Pipx setup
if [[ -d "$HOME/.local/bin" && ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    PATH=$PATH:"$HOME/.local/bin"
fi
export PATH="/usr/local/sbin:$PATH"

# Path setup

if [[ -d "$HOME/bin" && ":$PATH:" != *":$HOME/bin:"* ]]; then
    PATH="$HOME/bin":$PATH
fi
