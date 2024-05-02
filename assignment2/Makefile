a.out: main.o libass2_21CS30012.a
	gcc main.o -L. -lass2_21CS30012
main.o: main.c myl.h
	gcc -Wall -c main.c
libass2_21CS30012.a: ass2_21CS30012.o
	ar -rcs libass2_21CS30012.a ass2_21CS30012.o
ass2_21CS30012.o: ass2_21CS30012.c myl.h
	gcc -Wall -c ass2_21CS30012.c
clean:
	rm a.out main.o libass2_21CS30012.a ass2_21CS30012.o
