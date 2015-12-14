#
# Z Shell prompt
#

prompt_sep() {
    echo -n ' %F{black}%B┅%b%f '
}

prompt_root() {
    echo -n '%F{red}%B%n%b%f'   # username
    echo -n '%F{yellow}⚡%f'     # high voltage
    echo -n '%F{red}%m%f'       # host
}

prompt_userhost() {
    echo -n '%F{cyan}%B%n%b%f'  # username
    echo -n '%F{black}%B@%b%f'  # @
    echo -n '%F{cyan}%m%f'      # host
}

prompt_dir() {
    echo -n '%F{blue}%B%d%b%f'
}

prompt_time() {
    echo -n '%F{magenta}%B%D{%K:%M}%b%f'
}

prompt_input() {
    echo -n '%(?|%F{green}%B➜%b%f|%F{red}%B✘%b%f) '
}

build_prompt() {
    prompt_dir      # current directory
    prompt_sep
    echo -n "%(!|$(prompt_root)|$(prompt_userhost))"    # userhost
    prompt_sep
    prompt_time
    echo ''     # newline
    prompt_input
}

build_rprompt() {
    echo -n '%(?||%F{red}%B%?%b%f %F{red}↲%f)'
}

build_ps2() {
    echo -n '%F{black}%B%_ %b%f'
}

PROMPT="$(build_prompt)"
RPROMPT="$(build_rprompt)"
PS2="$(build_ps2)"
