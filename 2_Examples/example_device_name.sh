#!/bin/bash
mac="E0:B2:9B:3E:45:F2"
tmux send -t miband 'char-read-hnd 0003' ENTER;
sleep 1;
out=$(tmux capture-pane -p -S -| sed '/^$/d' | tail -n 2  | grep -zoP "Characteristic value/descriptor: .*" | cut -c 33-)
echo $out

python ../helper.py -V="$out"

