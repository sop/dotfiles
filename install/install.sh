#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname $DIR)"

# print success
success() {
    printf "\e[0;32mOK\e[0m $1\n"
}

# print warning
warn() {
    printf "\e[0;33mWARNING\e[0m $1\n"
}

# print error and exit
panic() {
    printf "\e[0;31mERROR\e[0m $1\n"
    exit 1
}

# make symlinks
files=$(find $ROOT -type f -name '*.symlink')
for f in $files; do
    src="$(realpath --relative-to=$HOME $f)"
    dst="$(basename $f)"
    dst="$HOME/.${dst%.symlink}"
    name="$(basename $dst)"
    # if file already exists
    if [[ -e "$dst" ]]; then
        # if file is symbolic link
        if [[ -h "$dst" ]]; then
            target="$(readlink $dst)"
            # if link already points to correct file
            if [[ "$target" == "$src" ]]; then
                success "$name already linked"
            # link exists but points to different file
            else
                warn "$name linked to $target, should be $src"
            fi
        else
            warn "$name already exists"
        fi
        continue
    fi
    ln -s $src $dst
    success "Linked $name"
done

# run install scripts
scripts=$(find $ROOT \( -type d -name $(basename $DIR) \) -prune -o \
    -type f -name 'install.sh' -executable -print)
for s in $scripts; do
    export DOTFILES=$ROOT
    $s
    if [[ $? -ne 0 ]]; then
        warn "Failed to execute $(basename $(dirname $s)) install script"
    fi
done

exit 0
