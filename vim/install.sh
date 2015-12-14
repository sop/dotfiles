#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# create .vim directory
mkdir -p $HOME/.vim ||
    { echo "Failed to create .vim directory"; exit 1; }
cd $HOME/.vim

# create subdirectories into .vim
mkdir -p bundle colors ||
    { echo "Failed to create directories in .vim"; exit 1; }

# fetch Vundle
pushd bundle > /dev/null
[[ -d "Vundle.vim" ]] ||
    git clone https://github.com/VundleVim/Vundle.vim.git
popd > /dev/null

# add link to molokai theme
pushd colors > /dev/null
[[ -e "molokai.vim" ]] ||
    ln -s $DIR/molokai.vim
popd > /dev/null

exit 0
