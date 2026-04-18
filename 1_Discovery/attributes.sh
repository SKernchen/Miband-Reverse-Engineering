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

#python helper.py --mode="encrypt" --key="45d3afdf3b3f7e58e88e71cca30cf496" -V="64 91 66 c5 24 b0 39 16 fb 6e 2b ed 7b 7c 4b ec "

