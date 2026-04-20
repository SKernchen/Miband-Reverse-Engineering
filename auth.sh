#!/bin/bash
mac="E0:B2:9B:3E:45:F2"
tmux new-session -d -s test 'gatttool -I -b E0:B2:9B:3E:45:F2';
tmux send 'connect' ENTER;
sleep 4;
tmux send 'char-write-cmd 0060 0100' ENTER;
sleep 1;
tmux send 'char-write-cmd 0060 0200' ENTER;
sleep 1;
out=$(tmux capture-pane -p -S - | grep -zoP "10 02 01.*\\n.*")
echo $out
seed=$(echo $out | cut -c 9- )
echo $seed

key=$(python helper.py --mode="encrypt" -V="$seed")
echo $key

sleep 2;
tmux send "char-write-cmd 0060 0300$key" ENTER;

tmux capture-pane -p -S - > ./output.txt

