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
#ZSH_THEME="essembeh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git node npm colorize colored-man-pages tmux docker cp systemd vagrant adb yarn archlinux rsync python pip history-substring-search vi-mode)

source $ZSH/oh-my-zsh.sh

# modular .bashrc as per http://www.turnkeylinux.org/blog/generic-shell-hooks
run_scripts()
{
    for script in $1/*; do

        # skip non-executable snippets
        [ -x "$script" ] || continue
        #
        #                 # execute $script in the context of the current shell
        . $script
    done
}
#run_scripts ~/.bashrc.d
#
alias -g tmux="tmux -2"
# Talk to Docker on Windows via WSL
case `uname -a` in
    *Microsoft*)
        export DOCKER_HOST=tcp://0.0.0.0:2375
        ;;
esac
export EDITOR='vim'
export PATH="$HOME/java/bin:$HOME/bin:$PATH"
export DISPLAY=:0
