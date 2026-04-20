#!/bin/bash
heartctl="0029"
heartms="0026"
tmux send -t miband 'char-write-req 0029 150200' ENTER;
tmux send -t miband 'char-write-req 0029 150100' ENTER;
sleep 0.5;
tmux send -t miband 'char-write-req 0027 0100' ENTER;
tmux send -t miband 'char-write-req 0029 150101' ENTER;
echo "Measurement started, see green light at Mi Band sensor."
echo "This process needs some time to fuction. Please be patient."
sleep 10;
time=30
echo "Empty lines mean no notification output right now. Stay patient."
if [ $# -eq 1 ]
  then
    time=$1
fi
i=0
while (( i < $time )); do
if [ $i -eq 2 ] || [ $i -eq 14 ];
  then
  tmux send -t miband 'char-write-req 0029 16' ENTER;
fi
out=$(tmux capture-pane -p -S -| sed '/^$/d' | tail -n 2  | grep -zoP "0026 value: .*" | cut -c 12-)
if [[ -n $out ]];
  then
  python ../helper.py -V="$out" | grep -oP "[1-9][0-9]+" 
fi
sleep 1;
i=$((i+1))
done
tmux send -t miband 'char-write-req 0029 150100' ENTER;

