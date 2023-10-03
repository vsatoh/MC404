.section .text
.globl _start

read:
    li a0, 0
    la a1, input_address #  buffer to write the data
    li a2, 7 # size (reads only 1 byte)
    li a7, 63 # syscall read (63)
    ecall
    ret

write:
    li a0, 1          
    la a1, output_address       
    li a2, 20           
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
    li t1, -1
    li t2, 0 #contador
    for_comp:
        li t0, 0
        beq a3, t0, fim_comp
        lw s0, 0(a3)
        lw s1, 4(a3)
        add s0, s1, s0
        beq a5, s0, guarda_ind 
        j fim_guarda_ind
        guarda_ind:
            mv t1, t2
            j fim_comp
        fim_guarda_ind:
        addi a3, a3, 8
    fim_comp:
    ret

_start:
    jal ra, read
    jal ra, converte_int
    jal ra, compara
    addi a5, a5, 48
    la a1, output_address
    mv a1, a5
    jal ra, write
.section .data
input_address: .skip 7

.data
head_node: 
    .word 10
    .word -4
    .word node_1
.skip 10
node_1: 
    .word 56
    .word 78
    .word node_2
.skip 5
node_3:
    .word -100
    .word -43
    .word 0
node_2:
    .word -654
    .word 590
    .word node_3
