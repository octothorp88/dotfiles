# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples # this is a test for git push

green='\[\e[0;32m\]'
GREEN='\[\e[0;32m\]'
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
NC='\[\e[0m\]'
nc='\[\e[0m\]'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ $HOSTNAME = "kali" ]; then
    if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
cat << "EOF"
  ____  __.      .__  .__
 |    |/ _|____  |  | |__|
 |      < \__  \ |  | |  |
 |    |  \ / __ \|  |_|  |
 |____|__ (____  /____/__|
         \/    \/
EOF
    fi

    windowsip=`cat ~/controlpanel.txt | grep windowsip | awk '{print $2}' | tr [0123456789] [9876543210]`
    windowspassword=`cat ~/controlpanel.txt | grep windowspassword | awk '{print $2}'| base64 -d`
    alias vpn='openvpn /mnt/hgfs/OSCP-SHARE/VPN/vpn.ovpn'
    alias rdp="rdesktop -g 60% -u offsec -p ${windowspassword} ${windowsip} &"
    alias ll='ls -la'
    alias mapshare='ln -s /mnt/hgfs/OSCP-SHARE /root/SHARE'
    alias mountshare='~/bin/mount-vmware-shares.sh'
    alias webup='python -m SimpleHTTPServer 80'
    alias ss='searchsploit $1'
    alias ssx='searchsploit -x $1'
    alias shieldsup='tcpdump -i tap0 -nnvv src net 10.11.0.0/24 and dst 10.11.0.54 -w - | tee capture.pcap | tcpdump -n -r -'
    alias controlpanel="firefox \"`cat ~/controlpanel.txt | grep controlpanel | awk '{print $2}'`\"&"
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="${red}┌[\u]${nc} [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n${red}└>${nc}"
else
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1="┌[${red}\u${nc}] [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n└>"
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="${red}┌[\u@\h]${nc}$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n${red}└>${nc}"
    ;;
*)
    PS1="${red}┌[\u@\h]${nc}$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n${red}└>${nc}"
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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

[ -z "$PS1" ] && return
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

#-progs mod--
alias tmux='tmux attach || tmux new-session \; split-window -v \; split-window -h \; select-pane -t 0'
#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'
#alias ls='ls --color=auto'
alias vi=vim
#alias tmux='tmux attach || tmux new'
#------------

export PIP_REQUIRE_VIRTUALENV=true
HISTCONTROL=erasedups
HISTIGNORE=”ls:cd:exit:clear”

if [ -f ~/dotfiles/git-completion.bash ]; then
    source ~/dotfiles/git-completion.bash
fi

#if [ $(id -u) -eq 0 ];
#then
#  PS1="${RED}┌[\u]${NC} [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n${RED}└>${NC}"
#else
#  PS1="${GREEN}┌[\u]${NC} [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n${GREEN}└>${NC}"
#fi
