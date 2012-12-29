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
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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

