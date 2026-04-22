#!/bin/bash
unknown_handles=('002c'
'0038'
'0041'
'0044'
'004d'
'0056'
'0059'
'005c')

for i in "${unknown_handles[@]}"; do
    tmux send -t miband "char-read-hnd $i" ENTER;
    sleep 0.5;
done
tmux capture-pane -p -S - | grep -zoP "hnd .*\\n.*" 

