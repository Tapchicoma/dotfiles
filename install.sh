#!/bin/sh

# Installs all symlinks for current user
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Make symlinks to bash files (for android do it manually)
if [ -f $HOME/.bashrc ]; then
    rm $HOME/.bashrc
fi
ln -s $BASE_DIR/bash/.bashrc $HOME/.bashrc

# Install powerline shell
pip install --user --upgrade -r install.req

# Remove old powerline install
if [ -f $HOME/powerline-shell.py ]; then
    rm ~/powerline-shell.py
fi
if [ -f $HOME/powerline_shell_base.py ]; then
    rm ~/powerline_shell_base.py
fi

# Generate bash_completion file
touch $HOME/.bash_completion
echo "" > $HOME/.bash_completion
for filename in $BASE_DIR/bash/bash_completion/*; do
    echo "source ${BASE_DIR}/bash/bash_completion/${filename##*/}" >> $HOME/.bash_completion
done

# Make symlink for bin directory
ln -s $BASE_DIR/bin $HOME/.bin

# Make symlink for gitconfig
ln -s $BASE_DIR/git/.gitconfig $HOME/.gitconfig

# Make symlinks for vim
ln -s $BASE_DIR/vim/.vim $HOME/.vim
ln -s $BASE_DIR/vim/.vimrc $HOME/.vimrc

# Make symlinks for emacs
ln -s $BASE_DIR/emacs-prelude $HOME/.emacs.d

# Make go home directory
if [ ! -d $HOME/.go ]; then
    mkdir ~/.go
fi
