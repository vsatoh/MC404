.section .text
.globl _start

read:
    la a0, 0
    la a1, input_address #  buffer to write the data
    li a2, 7 # size (reads only 1 byte)
    li a7, 63 # syscall read (63)
    ecall
    ret

write:
    li a0, 1          
    la a1, input_address       
    li a2, 7       
    li a7, 64          
    ecall    
    ret

converte_int:
    la a1, input_address
    lb a3, 0(a1)
    li a5, 0 #num de entrada
    li a4, '-'
    beq a3, a4, num_neg
    li a4, '\n'
    for1:
        beq a3, a4, fim
        li a4, 10
        mul a5, a5, a4
        addi a3, a3, -48
        add a5, a3, a5
        addi a1, a1, 1
        lb a3, 0(a1)
        j for1
    num_neg:
        addi a1, a1, 1
        li a4, '\n'
        for2:
            beq a3, a4, fim
            li a4, 10
            mul a5, a5, a4
            addi a3, a3, -48
            add a5, a3, a5
            addi a1, a1, 1
            lb a3, 0(a1)
            j for2
        li a4, -1
        mul a5, a5, a4
    fim:
    ret

compara:
    la a3, head_node
    for_comp:
        lw s0, 0(a3)
        lw s1, 4(a3)
        add s0, s1, s0
        

_start:
    jal ra, read


.section .data
input_address: .skip 7
