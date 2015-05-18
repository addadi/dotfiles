# Path to your oh-my-zsh configuration.
ZSH=$HOME/src/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
case `uname` in
    CYGWIN*)
        ZSH_THEME="robbyrussell"
        ;;
    Linux)
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
plugins=(git node npm colorize colored-man tmux)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
# Remove old kernels
# _egrep-pattern is needed by rmkernel

_egrep-pattern () {
        [ -z "$1" ] && return
        local regexp=$1
        shift
        for i in $*
        do
                regexp="$regexp|$i" 
        done
        echo ${regexp}
}

rmkernel () {
        local cur_kernel="$(uname -r)"
        local all_kernels="$(dpkg -l | grep -- linux- | egrep -- "-(image|headers|backports|modules|firmware)" \
        | grep "^ii" | awk '{print $2}')"
        local cur_kernel_pkgs="$(echo -e "$all_kernels" | grep "$cur_kernel$")"
        local cur_kernel_img=$(echo -e "$cur_kernel_pkgs" | grep image)
        local cur_kernel_hdr=$(echo -e "$cur_kernel_pkgs" | grep headers)
        if [ -z "$cur_kernel_img" ]
        then
                echo "Unable to get the current kernel package. What are you doing?" >&2
                echo "Possibly running in a chroot, eitherway aborting!" >&2
                return 1
        fi
        local cur_kernel_img_rdepends="$(apt-cache rdepends $cur_kernel_img | tail -n +3)"
        local cur_kernel_hdr_rdepends
        local cur_kernel_hdr_depends
        if [ -n "$cur_kernel_hdr" ]
        then
                cur_kernel_hdr_rdepends="$(apt-cache rdepends $cur_kernel_hdr | tail -n +3)" 
                cur_kernel_hdr_depends="$(apt-cache depends $cur_kernel_hdr | egrep 'linux-(image|headers)' | grep Depends | awk '{print $2}')" 
        fi
        local keep="$(_egrep-pattern $cur_kernel_pkgs $cur_kernel_img_rdepends $cur_kernel_hdr_rdepends $cur_kernel_hdr_depends)"
        if [ -z "$keep" ]
        then
                echo "Unable to determine which kernels to keep!" >&2
                echo "This should not happen in normal circumstances" >&2
                return 1
        fi
        local remove="$(echo -e "$all_kernels" | egrep -v "^($keep)$")"
        local rm_modules="$(find /lib/modules -mindepth 1 -maxdepth 1 -type d ! -name ${cur_kernel} )"
        if [ -n "$remove" ] || [ -n "$rm_modules" ]
        then
                echo "Going to remove the following kernel packages:" $remove
                echo "Going to remove the following kernel modules directories afterwards:" $rm_modules
                echo "Waiting 5 seconds for ctrl-c to abort mission"
                sleep 3
                echo -n ..2
                sleep 1
                echo -n ..1
                sleep 1
                echo "..Start removal"
                if [ -n "$remove" ]
                then
                        sudo aptitude -y purge $remove
                fi
                [ -n "$rm_modules" ] && sudo rm -rf $rm_modules
        fi
        return 0
}

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

export EDITOR='vim'
