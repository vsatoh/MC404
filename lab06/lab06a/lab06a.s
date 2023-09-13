read:
    li a0, 0  // file descriptor = 0 (stdin)
    la a1, input_address //  buffer to write the data carregar em outro lugar
    li a2, 1  // size (reads only 1 byte)
    li a7, 63 // syscall read (63)
    ecall

input_address: .skip 0x10  // buffer

write:
    li a0, 1            // file descriptor = 1 (stdout)
    la a1, string       // buffer
    li a2, 19           // size
    li a7, 64           // syscall write (64)
    ecall    
string:  .asciz "Hello! It works!!!\n"

sqrt:
    divu  a5, soma, a3
    add a3, a3, a5
    divi a3, a3, 2
    addi a4, a4, 1
    blti a4, 10, sqrt

pow:
    mul a3, a3, 10
    addi aux2, aux2, 1
    blt aux2, lim, pow 

trans_int:
    subi aux, 1
    lb a3, 0(a6)
    subi a3, a3, 48
    li aux2, 0
    jal ra, pow
    add a6, a6, 1
    add soma, soma, a3
    bge aux, 0, trans_int

oper:
    lw a6, 0(a1)
    jal t0, trans_int
    divu a3, soma, 2
    jal t0, sqrt

.globl _start

_start:

    jal t1, read

    lw a6, 0(a1)
    jal t1, oper
    add a1, a1, 5

    lw a6, 0(a1)
    jal t1, oper
    add a1, a1, 5

    lw a6, 0(a1)
    jal t1, oper
    add a1, a1, 5
    lw a6, 0(a1)

section .data
    aux .skip 0x4
    aux2 .skip 0x4
    soma .skip 0x4