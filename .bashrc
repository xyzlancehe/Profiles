# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

export PATH=$PATH:'~/bin'

# quick alias for source ~/.bashrc
alias ...="source ~/.bashrc"

# escaped control sequences
Style_Reset='\[\033[0m\]'       # reset
Style_Off='\[\033[0m\]'         # alias for reset
Style_Bold='\[\033[01m\]'       # bold
Style_Dim='\[\033[02m\]'        # dim
Style_Underlined='\[\033[04m\]' # underlined
Style_Blink='\[\033[05m\]'      # blink
Style_Reverse='\[\033[07m\]'    # reverse
Style_Hidden='\[\033[08m\]'     # hidden

Color_Black='\[\033[30m\]'        # text color black
Color_Red='\[\033[31m\]'          # text color red
Color_Green='\[\033[32m\]'        # text color green
Color_Yellow='\[\033[33m\]'       # text color yellow
Color_Blue='\[\033[34m\]'         # text color blue
Color_Magenta='\[\033[35m\]'      # text color magenta
Color_Cyan='\[\033[36m\]'         # text color cyan
Color_LightGray='\[\033[37m\]'    # text color light gray
Color_DarkGray='\[\033[90m\]'     # text color dark gray
Color_LightRed='\[\033[91m\]'     # text color light red
Color_LightGreen='\[\033[92m\]'   # text color light green
Color_LightYellow='\[\033[93m\]'  # text color light yellow
Color_LightBlue='\[\033[94m\]'    # text color light blue
Color_LightMagenta='\[\033[95m\]' # text color light magenta
Color_LightCyan='\[\033[96m\]'    # text color light cyan
Color_White='\[\033[97m\]'        # text color white

Background_Black='\[\033[40m\]'         # background color black
Background_Red='\[\033[41m\]'           # background color red
Background_Green='\[\033[42m\]'         # background color green
Background_Yellow='\[\033[43m\]'        # background color yellow
Background_Blue='\[\033[44m\]'          # background color blue
Background_Magenta='\[\033[45m\]'       # background color magenta
Background_Cyan='\[\033[46m\]'          # background color cyan
Background_LightGray='\[\033[47m\]'     # background color light gray
Background_DarkGray='\[\033[100m\]'     # background color dark gray
Background_LightRed='\[\033[101m\]'     # background color light red
Background_LightGreen='\[\033[102m\]'   # background color light green
Background_LightYellow='\[\033[103m\]'  # background color light yellow
Background_LightBlue='\[\033[104m\]'    # background color light blue
Background_LightMagenta='\[\033[105m\]' # background color light magenta
Background_LightCyan='\[\033[106m\]'    # background color light cyan
Background_White='\[\033[107m\]'        # background color white

function get_rainbow_text() {
    local text="$1"
    local wrap="${2:-1}"
    local length=${#text}
    local result=""
    
    # RGB values for the rainbow colors
    local -a R=(255 255 255   0   0  75 148)
    local -a G=(  0 127 255 255   0   0   0)
    local -a B=(  0   0   0   0 255 130 211)

    if [ "$length" -le 1 ]; then
        echo "$text"
        return
    fi

    for (( i=0; i<length; i++ )); do
        t=$(awk "BEGIN { print $i / ($length - 1) }")
        seg=$(awk "BEGIN { print int($t * 6) }")
        local_t=$(awk "BEGIN { print ($t * 6) - $seg }")

        if [ "$seg" -ge 6 ]; then
            seg=5
            local_t=1
        fi

        r1=${R[$seg]};   r2=${R[$((seg+1))]}
        g1=${G[$seg]};   g2=${G[$((seg+1))]}
        b1=${B[$seg]};   b2=${B[$((seg+1))]}

        r=$(awk "BEGIN { printf \"%d\", (1 - $local_t) * $r1 + $local_t * $r2 }")
        g=$(awk "BEGIN { printf \"%d\", (1 - $local_t) * $g1 + $local_t * $g2 }")
        b=$(awk "BEGIN { printf \"%d\", (1 - $local_t) * $b1 + $local_t * $b2 }")

        char="${text:$i:1}"
        if [ "$wrap" = "1" ]; then
            ansi="\[\033[38;2;${r};${g};${b}m\]${char}"
        else
            ansi="\033[38;2;${r};${g};${b}m${char}"
        fi
        result+="$ansi"
    done

    if [ "$wrap" = "1" ]; then
        result+="\[\033[0m\]"  # reset
    else
        result+="\033[0m"
    fi
    echo "$result"
}


function set_terminal_title() {
    title=$@
    if [ -z "$BASH_SOURCE" ]; then
        echo "\[\033]0;${title}\007\]"
    else
        echo -ne "\033]0;${title}\007"
    fi
}

# custom prompt
PromptHostName='\h'
PromptUserName='\u'
PromptWorkingDirectory='\w'
PromptSymbol='\$'
PromptTermTitle="${PromptUserName}@${PromptHostName}: ${PromptWorkingDirectory}"
if [[ -n "$MSYSTEM" ]]; then
    PromptTermTitle="${MSYSTEM}: ${PromptWorkingDirectory}"
fi
PromptIdentity="$(get_rainbow_text $(whoami)@$(hostname))"

export PS1="${debian_chroot:+($debian_chroot)}${Color_LightYellow}Bash ${Style_Bold}${PromptIdentity}${Style_Off} ${Style_Bold}${Color_Blue}${PromptWorkingDirectory}${MSYSTEM:+ ${Color_Magenta}${MSYSTEM} }${Style_Off}${PromptSymbol} "

# cd with title
TermUserName="${USER}"
TermHostName="${HOSTNAME}"
function cd() {
    builtin cd "$@"
    set_terminal_title "${TermUserName}@${TermHostName}: $(pwd)"
}
set_terminal_title "${TermUserName}@${TermHostName}: $(pwd)"

# screen helpers
function scr() {
    sub_command=$1
    case $sub_command in
    "l" | "ls" | "list")
        shift 1
        screen -ls $@
        ;;
    "s" | "start")
        shift 1
        screen -S $@
        ;;
    "r" | "a" | "attach")
        shift 1
        screen -r $@
        ;;
    "d" | "detach")
        shift 1
        screen -d $@
        ;;
    "h" | "help")
        screen --help
        ;;
    *)
        echo "available commands: l/ls/list, s/start, r/a/attach, d/detach, h/help"
        ;;
    esac
}

# conda helpers
function activate() {
    if [[ -f ~/bin/map_conda_environment ]]; then
        mapped_env=$(~/bin/map_conda_environment $@)
        conda activate $mapped_env
    else
        conda activate $@
    fi
}

function deactivate() {
    conda deactivate
}

alias act=activate
alias deact=deactivate

# some shortcuts
function nv() {
    nvidia-smi $@
}

function svr() {
    service_name=$1
    sudo service $service_name restart
}

