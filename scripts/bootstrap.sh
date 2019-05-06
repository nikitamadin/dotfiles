#!/usr/bin/env bash

# Bootstrap script for installing applications and tools

# Ask for the administrator password upfront
sudo -v

export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

cd $DOTFILES/scripts
. ./brew.sh
. ./nodejs.sh
. ./vscode.sh
cd -
