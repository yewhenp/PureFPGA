#!/bin/bash
if [ $# == 1 ] 
then
	python2 assembler/pure_assembler.py -s assembler/programs/$1.mccp -ap -v -o $1.out > dissassemble.txt
	rm a.prep
else
	echo "usage: ./shortcut_assemble.sh name_of_prg"
fi
