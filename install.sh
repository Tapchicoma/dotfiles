#!/bin/sh

# Installs all symlinks for current user
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# Make symlinks for emacs
emacsrc=$HOME/.emacs.d
if ! [ -L $emacsrc ]; then
    ln -s $BASE_DIR/emacs-prelude $emacsrc
fi

# Make go home directory
if [ ! -d $HOME/.go ]; then
    mkdir ~/.go
fi
