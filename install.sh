#!/bin/bash

### Common variables

# Path to the dotfiles repository
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Private configurations directory
SHARED_CONFIG_DIR=$HOME/cloud/shared_config/

###
# Installs emacs configuration
###
configure_emacs() {
    echo "Installing emacs configuration..."

    # Initialize doom-emacs sub-module
    git submodule update -- emacs/doom-emacs

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
# Installs a list of essential packages
#
# Modify 'essential_packages' file to add/remove package
###
install_essential_packages() {
    echo "Installing essential packages"
    sudo emerge -av --autounmask y "$(/bin/grep -v -R "^#" $BASE_DIR/essential_packages)"
}

###
# Ask user for installation options
###
ask_install() {
    read -p "$1? [y] " answer
    case ${answer:0:1} in
        n|N|no|NO|No )
            ;;
        * )
            $2
            ;;
    esac
}

###
# Ask user to add TapokOverlay repository
###
add_tapok_overlay() {
    if ! eselect repository list -i | grep -q "TapokOverlay"; then
        eselect repository add TapokOverlay git https://github.com/Tapchicoma/TapokOverlay.git
        emerge --sync TapokOverlay
        echo "Overlay was added successfully"
    else
        echo "Overlay was already added"
    fi
}

###
# Install powerline prompt
###
install_powerline_prompt() {
    sudo echo "app-shells/powerline-go" | sudo tee /etc/portage/package.accept_keywords/powerline-go > /dev/null
    emerge -v powerline-go
}

###
# Configure bash shell
###
configure_bash() {
    # Make symlinks to common bash files
    if [ -f $HOME/.bashrc ]; then
        rm $HOME/.bashrc
    fi
    bashrc=$HOME/.bashrc
    if ! [ -L $bashrc ]; then
        ln -s $BASE_DIR/bash/.bashrc $bashrc
    fi

    # Generate bash_completion file
    touch $HOME/.bash_completion
    echo "" > $HOME/.bash_completion
    for filename in $BASE_DIR/bash/bash_completion/*; do
        echo "source ${BASE_DIR}/bash/bash_completion/${filename##*/}" >> $HOME/.bash_completion
    done
}

###
# Add custom binaries
###
function configure_custom_bin() {
    # Make symlink for bin directory
    bindir=$HOME/.bin
    if ! [ -L $bindir ]; then
        ln -s $BASE_DIR/bin $bindir
    fi
}

###
# Configure git
###
configure_git() {
    gitconfig=$HOME/.gitconfig
    if ! [ -L $gitconfig ]; then
        ln -s $BASE_DIR/git/.gitconfig $gitconfig
    fi
}

###
# Install vim configuration
###
configure_vim() {
    # Make symlinks for vim
    vimconfig=$HOME/.vim
    if ! [ -L $vimconfig ]; then
        ln -s $BASE_DIR/vim/.vim $vimconfig
    fi

    vimrc=$HOME/.vimrc
    if ! [ -L $vimrc ]; then
        ln -s $BASE_DIR/vim/.vimrc $vimrc
    fi
}

ask_install "Install essential packages" install_essential_packages
ask_install "Add TapokOverlay repository" add_tapok_overlay
ask_install "Install powerline shell prompt" install_powerline_prompt
ask_install "Install emacs configuration" configure_emacs
ask_install "Install vim configuration" configure_vim
ask_install "Install git configuration" configure_git
ask_install "Configure bash shell" configure_bash
ask_install "Add custom binaries" configure_custom_bin
