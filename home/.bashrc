if [ "$PS1" ]; then
        shopt -s checkwinsize
        PS1="[\u@\h \w]\\$ "
        alias ll='ls -lF'
        export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME} \007" && history -a'
fi
