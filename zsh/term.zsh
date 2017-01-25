#
# Terminal settings
#

# Set tab width to 4, move one line upwards to mitigate newline caused by tabs
tabs 4 && echo -ne "\033[1A"

# initialize LS_COLORS
if [[ -f "$DOTFILES/vendor/LS_COLORS/LS_COLORS" ]]; then
    eval $( dircolors -b "$DOTFILES/vendor/LS_COLORS/LS_COLORS" )
fi
