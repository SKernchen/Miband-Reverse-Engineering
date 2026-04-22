#!/bin/bash
mac="E0:B2:9B:3E:45:F2"
mode="00"
if [ $# -eq 1 ]
  then
    mode=$1
fi
hex=$(python ../helper.py --mode="sth" -V="$text")
tmux send -t miband "char-write-cmd 0053 0101" ENTER;
sleep 2;
tmux send -t miband "char-write-cmd 0053 02$mode" ENTER;
sleep 1;

