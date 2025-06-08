zmodload zsh/mathfunc

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history       
setopt extended_history     
setopt hist_ignore_dups     
setopt hist_ignore_space   
setopt share_history        


# alias ls='ls --color=auto'  # Linux
alias ls='ls -G'          # macOS
alias ll='ls -lh'
alias la='ls -A'
alias grep='grep --color=auto'


function get_rainbow_text() {
    local text="$1"
    local wrap="${2:-1}"  # 默认值为 1
    local length=${#text}
    local -a r g b
    local output=""
  
    # 彩虹七色 RGB
    r=(255 255 255   0   0  75 148)
    g=(  0 127 255 255   0   0   0)
    b=(  0   0   0   0 255 130 211)

    if (( length <= 1 )); then
        print -- "$text"
        return
    fi

    for (( i = 0; i < length; i++ )); do
        local t=$(( i / (length - 1.0) ))
        local segment=$(( floor(t * 6) ))
        local local_t=$(( (t * 6) - segment ))

        if (( segment >= 6 )); then
            segment=5
            local_t=1.0
        fi

        local r_val=$(( (1 - local_t) * r[segment+1] + local_t * r[segment+2] ))
        local g_val=$(( (1 - local_t) * g[segment+1] + local_t * g[segment+2] ))
        local b_val=$(( (1 - local_t) * b[segment+1] + local_t * b[segment+2] ))

        # 用 printf 转成整数
        local r_int=$(printf "%.0f" $r_val)
        local g_int=$(printf "%.0f" $g_val)
        local b_int=$(printf "%.0f" $b_val)

        local char="${text:$i:1}"
        if (( wrap == 1 )); then
            output+="%{\033[38;2;${r_int};${g_int};${b_int}m%}${char}"
        else
            output+="\033[38;2;${r_int};${g_int};${b_int}m${char}"
        fi
    done

    if (( wrap == 1 )); then
        output+="%{\033[0m%}"  # reset
    else
        output+="\033[0m"
    fi
  print -n "$output"
}


PromptIndentity=$(get_rainbow_text "$(whoami)@$(hostname -s)")
export PROMPT="%F{yellow}Zsh%f ${PromptIndentity} %F{blue}%~%f> "