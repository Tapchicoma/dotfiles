source /etc/profile.d/bash-completion.sh 

alias ll='ls -l'
alias git-remote-enable='ssh-agent bash; ssh-add'
alias checkstyle='checkstyle -c /usr/share/checkstyle/checks/sun_checks.xml'

# time format at history
export HISTTIMEFORMAT='%F %T '
# increase history size
export HISTSIZE=100500
# ignore dups at history
export HISTCONTROL=ignoredups

# add user bin directory
export PATH=$PATH:$HOME/.bin
