all:
	gcc -Wall -c flatTriangle.c
	gcc -Wall -c reset.c
	gcc -Wall -c instructions.c
	gcc -Wall -c sendByte.c
	gcc -Wall -c sendInstruction.c
	gcc -Wall -c init.c
	gcc -Wall -c main.c
	gcc -o demo main.o init.o instructions.o sendInstruction.o reset.o sendByte.o flatTriangle.o -lpigpiod_if2 -lm
clean:
	rm flatTriangle.o
	rm instructions.o
	rm sendByte.o
	rm sendInstruction.o
	rm init.o
	rm main.o
	rm demo