read:
    li a0, 0  // file descriptor = 0 (stdin)
    la a1, input_address //  buffer to write the data
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
    divu  a5, a1, a3
    addu a3, a3, a5
    divui a3, a3, 2
    addi a4, a4, 1
    blti a4, 10, sqrt

pow:
    mul res_pow, res_pow, 10
    addi aux, aux, 1
    blt aux, lim, pow 

trans_int:
    li lim, 4
    

.globl _start

_start:

    li a0, 0  // file descriptor = 0 (stdin)
    la a1, input_address //  buffer to write the data
    li a2, 1  // size (reads only 1 byte)
    li a7, 63 // syscall read (63)
    ecall

    divui a3, a1, 2
    li a4, 0

section .data
    aux DW 1
    lim DW 0
    res_pow DW 1