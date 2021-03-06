#!/bin/bash

# this script's directory
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# .dotfiles directory
dotfiles_dir="$(dirname "$script_dir")"

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
while IFS= read -d $'\0' -r file; do
    # link target
    src="${file#$HOME/}"
    # link name
    dst="$(basename "$file")"
    dst="$HOME/.${dst%.symlink}"
    name="$(basename "$dst")"
    # if file already exists
    if [[ -e "$dst" ]]; then
        # if file is symbolic link
        if [[ -h "$dst" ]]; then
            target="$(readlink "$dst")"
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
    ln -s "$src" "$dst"
    success "Linked $name"
done < <(find "$dotfiles_dir" \( -type f -o -type l \) -name '*.symlink' -print0)

# run install scripts
while IFS= read -d $'\0' -r file; do
    DOTFILES="$dotfiles_dir" "$file"
    if [[ $? -ne 0 ]]; then
        warn "Failed to execute $(basename $(dirname "$s")) install script"
    fi
done < <(find "$dotfiles_dir" \( -type d -name $(basename "$script_dir") \) -prune -o \
    -type f -name 'install.sh' -executable -print0)
