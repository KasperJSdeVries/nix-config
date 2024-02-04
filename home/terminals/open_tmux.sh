#!/bin/sh

unattached_terminals=($(tmux ls -f '${?session_attached,0,1}' -F "#S"))
count=$($unattached_terminals | wc -l) 
if [[ $count = 0 ]]; then
	tmux new-session
else
	tmux attach -t '${unattached_terminals[count - 1]}'
fi
exit 0
