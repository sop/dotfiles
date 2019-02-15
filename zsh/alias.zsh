#
# Z Shell aliases
#

alias ll='ls -lFh'
alias psl='ps -e -o user,pid,ppid,stat,start_time,%cpu,cputime,sz,rss,%mem,nlwp,args -H'

# Color support
if [[ ! -z "$(command -v dircolors)" ]]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# execute last typed command with sudo
alias please='sudo zsh -c "$(fc -ln -1)"'

