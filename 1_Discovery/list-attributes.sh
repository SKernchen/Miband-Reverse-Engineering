#!/bin/bash
mac="E0:B2:9B:3E:45:F2"
tmux new-session -d -s list-attr 'bluetoothctl';
tmux send "connect $mac" ENTER;
sleep 3;
tmux send "pair $mac" ENTER;
sleep 1;
tmux send 'menu gatt' ENTER;
tmux send 'list-attributes' ENTER;
tmux capture-pane -p -S - > ./output.txt;

