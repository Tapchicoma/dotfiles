source ~/.bin/git-prompt.sh
source /etc/bash/bashrc.d/bash_completion.sh 

# Command prompt
if [[ $EUID -eq 0 ]]; then
    export PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w$(__git_ps1 " (%s)") \$\[\033[00m\] '
else
    export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w$(__git_ps1 " (%s)") \$\[\033[00m\] '
fi

alias ll='ls -l'
alias git-remote-enable='ssh-agent bash; ssh-add'
alias http-dir-server='python -m SimpleHTTPServer'
alias nicemount='mount | column -t'
alias myip='curl ifconfig.me'
alias dirsize='du -hd 0'
alias contsize='du -hd 1'

# time format at history
export HISTTIMEFORMAT='%F %T '
# increase history size
export HISTSIZE=100500
# ignore dups at history
export HISTCONTROL=ignoredups

# add user bin directory
export PATH=$PATH:$HOME/.bin

### Virtulaenvwrapper settings
if [ -f /usr/bin/virtualenvwrapper.sh ]
then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi

# local bashrc
source $HOME/.bashrc_local

# android helpers
source $HOME/.bashrc_android
