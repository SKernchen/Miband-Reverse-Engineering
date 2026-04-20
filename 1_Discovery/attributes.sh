#!/bin/bash
mac="E0:B2:9B:3E:45:F2"
tmux new-session -d -s test 'gatttool -I -b E0:B2:9B:3E:45:F2';
tmux send 'connect' ENTER;
sleep 2;
tmux send 'primary' ENTER;
sleep 1;
tmux send 'characteristics' ENTER;
sleep 5;
tmux capture-pane -p -S - > ./output.txt

