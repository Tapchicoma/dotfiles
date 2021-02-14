source /etc/profile
source ~/.bin/git-prompt.sh
source /etc/bash/bashrc.d/bash_completion.sh


# Command prompt
export PATH=$PATH:~/.local/bin
function _update_ps1() {
    PS1="$(powerline-go -error $? -colorize-hostname -hostname-only-if-ssh)"
}
if [ "$TERM" != "linux" ] && [ -f "/usr/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

alias ll='ls -l'
alias git-remote-enable='ssh-agent bash; ssh-add'
alias http-dir-server='python -m http.server'
alias nicemount='mount | column -t'
alias myip='curl ifconfig.me'
alias dirsize='du -hd 0'
alias contsize='du -hd 1'
alias pidcat='python2.7 ~/.bin/pidcat.py'
alias gr='./gradlew'
alias gro='./gradlew --offline'
alias cat='bat'
alias grep='rg'
alias ls='exa'

# time format at history
export HISTTIMEFORMAT='%F %T '
# increase history size
export HISTSIZE=100500
# ignore dups at history
export HISTCONTROL=ignoredups

# add user bin directory
export PATH=$PATH:$HOME/.bin

# Always show all updates list
export EIX_LIMIT_COMPACT=0

# Better GTK apps integration into KDE
export GTK_USE_PORTAL=1

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

# Open github repository page
alias github=GitHub

function GitHub()
{
    if [ ! -d .git ] ;
    then echo "ERROR: This isnt a git directory" && return 0;
    fi

    git_url=`git config --get remote.origin.url`
    git_domain=`echo $git_url | awk -v FS="(@|:)" '{print $2}'`
    git_branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`

    if [[ $git_url == https://* ]];
    then
        url=${git_url%.git}/tree/${git_branch}
    else
        if [[ $git_url == git@* ]]
        then
            cut_off=${git_url#*:}
            url=https://${git_domain}/${cut_off%.git}/tree/${git_branch}
        else
            echo "ERROR: Remote origin is invalid" && return 0;
        fi
    fi
    xdg-open $url
}

# Run one-time command from local directory with docker
alias docker-one-time='docker run --rm -ti -w "/command" -v `pwd`:/command'

# Update every package in given portage group
function emerge-update-all() {
     emerge -avuq $(eix -cu# $1 | tr ' ' '\n')
}

