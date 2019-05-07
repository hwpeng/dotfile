# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it (-s -- If set, the
# history list is appended to the file named by the value of the
# HISTFILE variable when the shell exits, rather than overwriting the
# file)
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
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
#
#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#        # We have color support; assume it's compliant with Ecma-48
#        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#        # a case would tend to support setf rather than setaf.)
#        color_prompt=yes
#    else
#        color_prompt=
#    fi
#fi
#
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[0;31m\]\u\[\033[1;34m\]@\h\[\033[00m\]:\[\033[0;37m\]\w\[\033[00m\]'
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'
#fi
#unset color_prompt force_color_prompt
#
## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}┌──\u@\h: \w\a\]$PS1\n└──\$ "    
#    ;;
#*)
#    ;;
#esac

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
 
PS_LINE=`printf -- '- %.0s' {1..200}`
function parse_git_branch {
	PS_BRANCH=''
	PS_FILL=${PS_LINE:0:$COLUMNS}
	if [ -d .svn ]; then
		PS_BRANCH="(svn r$(svn info|awk '/Revision/{print $2}'))"
		return
	elif [ -f _FOSSIL_ -o -f .fslckout ]; then
		PS_BRANCH="(fossil $(fossil status|awk '/tags/{print $2}')) "
		return
	fi
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	PS_BRANCH="(git ${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_INFO="\u@\h$RESET:\w"
PS_GIT="\$PS_BRANCH"
PS_TIME="\[\033[\$((COLUMNS-20))G\] [\d - \A]"
export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_GIT}${PS_TIME}\n${RESET}\$ "
##################################################################################

# Extract function for common file formats, from https://ftp.gnu.org/gnu/gtypist/gtypist-2.9.tar.xz
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS
##################################################################################

# Terminal vim mode
set -o vi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias tree='tree -C'
fi

# User specific aliases and functions
alias q="exit"
alias c='clear'
alias h='history'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias diskspace="du -S | sort -n -r |more"
alias go="tmux a -t"
alias subl="~/software/sublime_text_3/sublime_text"
alias cpwd="pwd | tr -d '\n' | pbcopy && echo 'pwd copied to clipboard'"
# cd function
shopt -s cdspell
complete -d cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Source global definitions
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local 
fi

