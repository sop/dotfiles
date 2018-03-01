#
# Shared script for interactive shell sessions.
#

# add local bin directory to PATH
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
