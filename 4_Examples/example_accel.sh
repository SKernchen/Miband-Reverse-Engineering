#!/bin/bash
sensor="002f"
steps="0044"
hz="0032"
tmux send -t miband 'char-write-req 0030 0100' ENTER;
tmux send -t miband 'char-write-req 0045 0100' ENTER;
tmux send -t miband 'char-write-req 0033 0100' ENTER;
sleep 0.5;
tmux send -t miband 'char-write-cmd 002f 010119' ENTER;
sleep 2;
tmux send -t miband 'char-write-cmd 002f 02' ENTER;
time=35
if [ $# -eq 1 ]
  then
    time=$1
fi
i=0
while (( i < $time )); do
out=$(tmux capture-pane -p -S -| sed '/^$/d' | tail -n 2  | grep -zoP "0032 value: .*" | cut -c 12-)
if [[ -n $out ]];
  then
  python ../helper.py -V="$out" --no-utf 
fi
sleep 1;
i=$((i+1))
done
tmux send -t miband 'char-write-cmd 002f 010119' ENTER;

