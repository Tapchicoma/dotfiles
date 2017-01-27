#!/bin/sh

# Installs all symlinks for current user
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Make symlinks to bash files (for android do it manually)
ln -s $BASE_DIR/bash/.bashrc $HOME/.bashrc
ln -s $BASE_DIR/bash/powerline_shell_base.py $HOME/powerline_shell_base.py
ln -s $BASE_DIR/bash/powerline-shell.py $HOME/powerline-shell.py

# Make symlink for bin directory
ln -s $BASE_DIR/bin $HOME/.bin

# Make symlink for gitconfig
ln -s $BASE_DIR/git/.gitconfig $HOME/.gitconfig

# Make symlinks for vim
ln -s $BASE_DIR/vim/.vim $HOME/.vim
ln -s $BASE_DIR/vim/.vimrc $HOME/.vimrc