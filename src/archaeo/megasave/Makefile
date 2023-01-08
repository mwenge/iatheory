.PHONY: all clean run

D64_IMAGE = "loader.prg"

all: loader.prg

sources: loader.asm
	64tass -Wall -Wno-implied-reg --cbm-prg -o loader.prg -L list-co1.txt  loader.asm

sources2: loader.asm
	64tass -Wall -Wno-implied-reg --cbm-prg -o loader.prg -L list-co1.txt  loader2.asm

loader.prg: sources2
	echo "0f233769b1cb4bfd1b21bd59e20949e6  loader.prg" | md5sum -c

