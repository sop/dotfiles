#
# Z Shell key bindings
#

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Alt + left/right
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Bash style delete word backwards
my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word
