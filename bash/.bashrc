source /etc/profile.d/bash-completion.sh 

# Command prompt
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w$(__git_ps1 " (%s)") \$\[\033[00m\] '

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

### Virtulaenvwrapper settings
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
