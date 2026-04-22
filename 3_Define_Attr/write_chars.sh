#!/bin/bash
unknown_handles_write=('0047'
'0050'
'0057'
)
unknown_handles_write_no_answer=('002f'
'0035'
'0038'
'003b'
'004d'
'0053'
'0056'
'0059'
)
optcode=('1601'
'1501'
'160101'
)

for i in "${unknown_handles_write_no_answer[@]}"; do
	for k in "${optcode[@]}"; do
	    tmux send -t miband "char-write-cmd $i $k" ENTER;
	    sleep 3;
	done 
done 

