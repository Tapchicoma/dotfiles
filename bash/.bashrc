source ~/.bin/git-prompt.sh
source /etc/bash/bashrc.d/bash_completion.sh


# Command prompt
export PATH=$PATH:~/.local/bin
function _update_ps1() {
    PS1="$(powerline-shell $?)"
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
alias pidcat='python2.7 ~/.bin/pidcat.py'
alias gr='./gradlew'
alias gro='./gradlew --offline'

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

# Go lang specific settings
export GOPATH=~/.go
export PATH=$PATH:$GOPATH/bin
alias install-gomobile='go get golang.org/x/mobile/cmd/gomobile & gomobile init'

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
