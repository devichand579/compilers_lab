ass3_21CS30012_output.txt: output ass3_21CS30014_21CS30012_test.c 
	./output < ass3_21CS30014_21CS30012_test.c > ass3_21CS30014_21CS30012_output.txt

output: lex.yy.c
	gcc lex.yy.c -lfl -o output

lex.yy.c: ass3_21CS30014_21CS30012.l
	flex ass3_21CS30014_21CS30012.l ass3_21CS30014_21CS30012.c

clean:
	rm output lex.yy.c ass3_21CS30014_21CS30012_output.txt