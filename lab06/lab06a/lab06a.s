read:
    li a0, 0  // file descriptor = 0 (stdin)
    la a1, input_address //  buffer to write the data carregar em outro lugar
    li a2, 1   // size (reads only 1 byte)
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

// a1 entrada
// a6 vetor cortado

sqrt:
    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2
    addi a4, a4, 1
    li t2, 10
    blt a4, t2, sqrt

pow:
    li t2, 10
    mul a3, a3, t2
    addi s3, s3, 1
    blt s3, s4, pow //lim s4

char_int:
    li t2, 1
    sub s2, s2, t2 // s2 aux
    lb a3, 0(a6)
    li t2, 48
    sub a3, a3, t2
    li s3, 0 // s3 aux2
    jal ra, pow
    add a6, a6, 1
    add s1, s1, a3 //s1 int
    li t2, 0
    bge s2, t2, char_int

int_char:
    
    li s5, 1000
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 0(a2)

    li s5, 100
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 1(a2)

    li s5, 10
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 2(a2)

    li s5, 1
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 3(a2)


oper:
    lw a6, 0(a1)
    jal t0, char_int
    li t2, 2
    divu a3, s1, t2
    jal t0, sqrt

.globl _start

_start:

    jal t1, read

    li s4, 4
    li s2, 4
    lw a6, 0(a1)
    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    addi a2, a2, 5

    li s4, 3
    li s2, 4
    lw a6, 0(a1)
    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    addi a2, a2, 5

    li s4, 2
    li s2, 4
    lw a6, 0(a1)
    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    addi a2, a2, 5

    li s4, 1
    li s2, 4
    lw a6, 0(a1)
    jal t1, oper
    jal t1, int_char

    jal t1, write