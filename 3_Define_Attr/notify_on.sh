#!/bin/bash
unknown_handles=('0017'
'002d'
'0030'
'0033'
'0036'
'0039'
'003c'
'003f'
'0042'
'0048'
'004b'
'004e'
'0057'
'005a'
'005d'
'0061'
'0072'
'0076')

for i in "${unknown_handles[@]}"; do
    tmux send -t miband "char-write-req $i 0100" ENTER;
    sleep 0.5;
done 

