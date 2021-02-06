#!/bin/sh

# Installs all symlinks for current user
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Private configurations directory
SHARED_CONFIG_DIR=$HOME/cloud/shared_config/

# Make symlinks to bash files (for android do it manually)
if [ -f $HOME/.bashrc ]; then
    rm $HOME/.bashrc
fi
bashrc=$HOME/.bashrc
if ! [ -L $bashrc ]; then
    ln -s $BASE_DIR/bash/.bashrc $bashrc
fi

# Install powerline shell
pip install --user --upgrade -r install.req

# Remove old powerline install
if [ -f $HOME/powerline-shell.py ]; then
    rm $HOME/powerline-shell.py
fi
if [ -f $HOME/powerline_shell_base.py ]; then
    rm $HOME/powerline_shell_base.py
fi

# Generate bash_completion file
touch $HOME/.bash_completion
echo "" > $HOME/.bash_completion
for filename in $BASE_DIR/bash/bash_completion/*; do
    echo "source ${BASE_DIR}/bash/bash_completion/${filename##*/}" >> $HOME/.bash_completion
done

# Make symlink for bin directory
bindir=$HOME/.bin
if ! [ -L $bindir ]; then
    ln -s $BASE_DIR/bin $bindir
fi

# Make symlink for gitconfig
gitconfig=$HOME/.gitconfig
if ! [ -L $gitconfig ]; then
    ln -s $BASE_DIR/git/.gitconfig $gitconfig
fi

# Make symlinks for vim
vimconfig=$HOME/.vim
if ! [ -L $vimconfig ]; then
    ln -s $BASE_DIR/vim/.vim $vimconfig
fi
vimrc=$HOME/.vimrc
if ! [ -L $vimrc ]; then
    ln -s $BASE_DIR/vim/.vimrc $vimrc
fi

# Make go home directory
if [ ! -d $HOME/.go ]; then
    mkdir ~/.go
fi

###
# Installs emacs configuration
###
function configure_emacs {
    echo "Installing emacs configuration..."

    # Initialize doom-emacs sub-module
    git submodule init -- emacs/doom-emacs

    # Link emacs-doom
    emacs_source=$BASE_DIR/emacs/doom-emacs
    emacs_src=$HOME/.emacs.d
    if ! [ -L $emacs_src ]; then
        ln -s $emacs_source $emacs_src
    fi

    # Link private doom configuration
    emacs_shared_config=$SHARED_CONFIG_DIR/emacs/doom
    emacs_cfg=$HOME/.doom.d
    if ! [ -L $emacs_cfg ]; then
        ln -s $emacs_shared_config $emacs_cfg
    fi

    # Run doom sync
    $emacs_source/bin/doom sync

    # Run doom doctor to check installation issues
    $emacs_source/bin/doom doctor
}

###
# Ask user for installation options
###

read -p "Install emacs configuration? [y]:" emacs_answer
case ${emacs_answer:0:1} in
    n|N )
        ;;
    * )
        configure_emacs
        ;;
esac
