#------------------------------------------------------------------------------
# Oh-My-Zsh Configuration
#------------------------------------------------------------------------------

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
case `uname -a` in
    CYGWIN*)
        ZSH_THEME="robbyrussell"
        ;;
    Linux*Microsoft*)
        ZSH_THEME="robbyrussell"
        ;;
    Linux*)
        ZSH_THEME="essembeh"
        ;;
esac

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git node npm colorize colored-man-pages tmux docker cp systemd docker-compose httpie ssh yarn archlinux rsync python pip history-substring-search vi-mode dotenv)

# Source Oh-My-Zsh. This needs to be done after setting plugins.
source $ZSH/oh-my-zsh.sh

#------------------------------------------------------------------------------
# Environment Variables
#------------------------------------------------------------------------------

export EDITOR='nvim'
export DISPLAY=:0
export LESS='-R --use-color -Dd+r$Du+b$'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# Set PATH
export PATH="$HOME/java/bin:$HOME/bin:~/.npm-global/bin:$PATH"

# Docker host configuration
case `uname -a` in
    *Microsoft*) # WSL
        export DOCKER_HOST=tcp://0.0.0.0:2375
        ;;
    *) # Linux
        export DOCKER_HOST="unix:///run/user/1000/docker.sock"
        ;;
esac

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------

alias -g tmux="tmux -2"
alias awsp="source _awsp"

# Colorize output on cli tools
# https://wiki.archlinux.org/title/Color_output_in_console
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls --color=auto'


#------------------------------------------------------------------------------
# Functions & Completions
#------------------------------------------------------------------------------

# uv shell completion
# As per https://github.com/astral-sh/uv/issues/8432#issuecomment-2453494736
eval "$(uv generate-shell-completion zsh)"

_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

# Modular .zshrc using a directory of scripts
# As per http://www.turnkeylinux.org/blog/generic-shell-hooks
# You can enable this by creating a ~/.zshrc.d directory and putting executable scripts in it.
run_scripts()
{
    for script in $1/*; do
        # skip non-executable snippets
        [ -x "$script" ] || continue
        # execute $script in the context of the current shell
        . $script
    done
}
# run_scripts ~/.zshrc.d
