source ~/.bin/git-prompt.sh
source /etc/bash/bashrc.d/bash_completion.sh

# Command prompt
function _update_ps1() {
    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
}
if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

alias ll='ls -l'
alias git-remote-enable='ssh-agent bash; ssh-add'
alias http-dir-server='python -m http.server'
alias nicemount='mount | column -t'
alias myip='curl ifconfig.me'
alias dirsize='du -hd 0'
alias contsize='du -hd 1'
alias pidcat='pidcat.py'
alias gr='./gradlew'

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
if [ -f $HOME/.bashrc_local ]; then
    source $HOME/.bashrc_local
fi

# android helpers
if [ -f $HOME/.bashrc_android ]; then
    source $HOME/.bashrc_android
fi
