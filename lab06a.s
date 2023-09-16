.section .text
.globl _start

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
    la a6, input_address
    lb a3, 0(a6)
    li t2, 48
    sub a3, a3, t2
    li t2, 1000
    mul a3, a3, t2
    add s1, s1, a3 

    lb a3, 1(a6)
    li t2, 48
    sub a3, a3, t2
    li t2, 100
    mul a3, a3, t2
    add s1, s1, a3 

    lb a3, 2(a6)
    li t2, 48
    sub a3, a3, t2
    li t2, 10
    mul a3, a3, t2
    add s1, s1, a3 

    lb a3, 3(a6)
    li t2, 48
    sub a3, a3, t2
    li t2, 1
    mul a3, a3, t2
    add s1, s1, a3 


int_char:
    
    li s5, 1000
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 0(a2)
    addi a3, a3, 1

    li s5, 100
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 1(a2)
    addi a3, a3, 1

    li s5, 10
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 2(a2)
    addi a3, a3, 1


    li s5, 1
    div s6, a3, s5
    addi s6, s6, 48
    sb s6, 3(a2)



oper:

    jal t0, char_int
    li t2, 2
    divu a3, s1, t2
    jal t0, sqrt

_start:

    li a0, 0 
    la a1, input_address 
    li a2, 20   
    li a7, 63 
    ecall

    jal t1, oper
    addi a1, a1, 5
    la s2, output_address
    jal t1, int_char
    li t2, ' '
    sb t2, 4(s2)
    addi s2, s2, 5

    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    li t2, ' '
    sb t2, 4(s2)
    addi a2, a2, 5

    jal t1, oper
    addi a1, a1, 5
    jal t1, int_char
    li t2, ' '
    sb t2, 4(a2)
    addi a2, a2, 5

    jal t1, oper
    addi a1, a1, 4
    jal t1, int_char
    li t2, '\n'
    sb t2, 4(a2)
    
    li a0, 1          
    la a1, output_address       
    li a2, 20           
    li a7, 64          
    ecall    

.section .bss

input_address: .skip 0x14  
output_address: .skip 0x14  
