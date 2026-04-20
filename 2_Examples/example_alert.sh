#!/bin/bash
mac="E0:B2:9B:3E:45:F2"
text="hallo"
if [ $# -eq 1 ]
  then
    text=$1
fi
hex=$(python ../helper.py --mode="sth" -V="$text")
tmux send -t miband "char-write-req 001c 0501$hex" ENTER;
sleep 1;

