#source ~/.git_completion.sh
source /etc/profile.d/bash-completion.sh 

alias ll='ls -l'
alias git-remote-enable='ssh-agent bash; ssh-add'
alias checkstyle='checkstyle -c /usr/share/checkstyle/checks/sun_checks.xml'

# git branch at bash promt
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w $(__git_ps1 "(%s)") \$\[\033[00m\] '
# time format at history
export HISTTIMEFORMAT='%F %T '
# increase history size
export HISTSIZE=100500
# ignore dups at history
export HISTCONTROL=ignoredups
