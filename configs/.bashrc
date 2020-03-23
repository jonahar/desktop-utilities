# Bash source commands
#
# jonahar@GitHub
#


# If not running interactively, don't do anything (e.g. when running a script in bash)
# [$- != *i*] checks if 'i' is a substring of $- , which includes 'i' only if running interactively
# [[ $- != *i* ]] && return


# Colors:
NORMAL='\[\033[00m\]'
RED='\[\033[01;31m\]'
GRN='\[\033[01;32m\]'
YEL='\[\033[01;33m\]'
BLU='\[\033[01;34m\]'
MAG='\[\033[01;35m\]'
CYN='\[\033[01;36m\]'
WHT='\[\033[01;37m\]'



# prompt
# -------------------------------------

# detect color support
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
fi

# set prompt
if [ "$color_prompt" = yes ]; then
    PS1="${GRN}\u@\h${NORMAL}:[${BLU}\w${NORMAL}]\$ "
else
    PS1="\u@\h:\w\$ "
fi

# if running within an ssh session change prompt to distinguish it from local terminal
if [[ ! -z "$SSH_TTY" ]] || [[ ! -z "$SSH_CONNECTION" ]] || [[ ! -z "$SSH_CLIENT" ]] ; then
    PS1="${RED}ssh:$PS1"
fi



# enable color for ls and grep
# -------------------------------------
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi



# aliases
# -------------------------------------
# ls
alias ll="ls -alh"
# git
alias g="git status"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log"
alias gps="git push"
alias gpl="git pull"
alias gd="git diff"
# change directory
alias ~="cd ~"
alias ..="cd .."
alias ...='cd ../..'
alias ....='cd ../../..'
# misc
alias where="which"
alias open="xdg-open" # opens a file or URL in the user's preferred application



# Extras
# -------------------------------------

# set vim as default editor
export VISUAL=vim
export EDITOR="$VISUAL"


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


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


# Add an "alert" alias for long running commands. Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# graphical man: open manual pages in gedit
gman () { man "$1" | gedit - ; }


# if user's bin exists and wasn't already added to PATH, add it.
if [[ -d "$HOME/bin" ]] && [[ "$PATH" != *"$HOME/bin"* ]]; then
    PATH="$HOME/bin:$PATH"
fi


# run ls after every cd
cd() {
    builtin cd "$@" && ls
}
