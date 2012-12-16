#!/bin/bash
# wrapper script for tmux
# attaches to session if program is running, otherwise starts program

SESSION=""
OPTS=""
while getopts dls: OPT; do
    case "$OPT" in
        d)
            OPTS="-d"
            ;;
        l)
            tmux list-sessions 2> /dev/null
            exit $?
            ;;
        s)
            SESSION="$OPTARG"
            ;;
        ?)
            exit 1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

CMD=$*
if [[ -z $SESSION ]]; then
    SESSION=$1
fi

if [[ -z $SESSION ]]; then
    echo >&2 << EOF "usage: $(basename $0) [-l] [-d] [-s name] [cmd]
        -l list tmux sessions
        -d restrict session to one client
        -s use name as session name instead of \$1 of cmd"
EOF
    exit 1
fi

if [[ -z $(tmux list-sessions 2> /dev/null | grep "$SESSION") ]]; then
    tmux new-session -s $SESSION "$CMD"
else
    tmux attach-session $OPTS -t $SESSION
fi
