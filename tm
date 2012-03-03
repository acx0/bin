#!/bin/bash
# wrapper script for tmux
# attaches to session if program is running, otherwise starts program
# call with '-d' to restrict session to a single client

OPTS=""
while getopts dl OPT; do
    case "$OPT" in
        d)
            OPTS="-d"
            ;;
        l)
            tmux list-sessions 2> /dev/null
            exit $?
            ;;
        ?)
            exit 1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

if [[ -z $1 ]]; then
    echo >&2 "usage: $(basename $0) [-d] [-l] [program]"
    exit 1
fi

if [[ -z $(tmux list-sessions 2> /dev/null | grep "$1") ]]; then
    tmux new-session -s $1 "$*"
else
    tmux attach-session $OPTS -t $1
fi
