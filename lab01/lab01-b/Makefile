lab1b.s: lab1b.c
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab1b.c -S -o lab1b.s

lab1b.o: lab1b.s
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab1b.s -c -o lab1b.o

lab1b.x: lab1b.o
	ld.lld lab1b.o -o lab1b.x