#!/bin/bash
contador=0
virsh --connect qemu:///system list --all | while read linea
do
	if [ $contador -eq 0 ] || [ $contador -eq 1 ]
	then
		contador=$(($contador+1))
	else
		echo $linea | cut -d" " -f2
		contador=$(($contador+1))
	fi
done
