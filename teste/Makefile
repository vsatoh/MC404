prog.s: prog.c
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax prog.c -S -o prog.s

prog.o: prog.s
	clang-15 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax prog.s -c -o prog.o

prog.x: prog.o
	ld.lld prog.o -o prog.x