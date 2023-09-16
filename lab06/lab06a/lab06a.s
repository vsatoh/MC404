.section .text
.globl _start

read:
    li a0, 0  
    la a1, input_address 
    li a2, 20  
    li a7, 63
    ecall
    ret

write:
    li a0, 1          
    la a1, output_address       
    li a2, 19           
    li a7, 64          
    ecall    
    ret

sqrt:
    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

    divu  a5, s1, a3
    add a3, a3, a5
    li t2, 2
    div a3, a3, t2

pow:
    li t2, 10
    mul a3, a3, t2
    addi s3, s3, 1
    blt s3, s4, pow 

char_int:

    lb a3, 0(a1)
    addi a3, a3, -48
    li t2, 1000
    mul a3, a3, t2
    add s1, s1, a3 

    lb a3, 1(a1)
    addi a3, a3, -48
    li t2, 100
    mul a3, a3, t2
    add s1, s1, a3 

    lb a3, 2(a1)
    addi a3, a3, -48
    li t2, 10
    mul a3, a3, t2
    add s1, s1, a3 

    lb a3, 3(a1)
    addi a3, a3, -48
    li t2, 1
    mul a3, a3, t2
    add s1, s1, a3 

int_char:
    
    li s5, 1000
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 0(s2)
    
    li s5, 100
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 1(s2)
    addi a3, a3, 1

    li s5, 10
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 2(s2)
    addi a3, a3, 1

    li s5, 1
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 3(s2)


oper:
    jal t0, char_int
    li t2, 2
    divu a3, s1, t2
    jal t0, sqrt

_start:

    la s2, output_address
    jal t1, read

    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    li t2, ' '
    sb t2, 4(s2)
    jal t1, write

    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    li t2, ' '
    sb t2, 4(s2)
    jal t1, write

    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    li t2, ' '
    sb t2, 4(s2)
    jal t1, write

    jal t1, oper
    jal t1, int_char
    li t2, '\n'
    sb t2, 4(s2)
    jal t1, write

.section .bss
input_address: .skip 0x14 
output_address: .skip 0x5
intermed: .skip 0x14