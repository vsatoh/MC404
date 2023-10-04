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
        li a4, '\n'
        j for1

    num_neg:
        addi a1, a1, 1
        li a4, '\n'
        lb a3, 0(a1)
        for2:
            beq a3, a4, fim2
            li a4, 10
            mul a5, a5, a4
            addi a3, a3, -48
            add a5, a3, a5
            addi a1, a1, 1
            lb a3, 0(a1)
            li a4, '\n'
            j for2
        fim2:
        li a4, -1
        mul a5, a5, a4
    fim:
    ret
    
num_digit:
    mv t2, t1
    li t3, 0 #num de digitos
    li t4, 10
    for_num_digit:
        addi t3, t3, 1
        blt t2, t4, fim_for_num_digit
        rem t2, t2, t4
        j for_num_digit
    fim_for_num_digit:
    ret    

pow:
    li t4, 10
    li t5, 1
    li t6, 1
    for_pow:
        beq t6, t3, fim_pow
        mul t5, t5, t4
        addi t6,t6, 1
        j for_pow
    fim_pow:
    ret

int_char:
    mv s0, ra

    la a1, output_address
    li t2, -1
    beq t1, t2, imp_neg
    li t2, 0
    for_int_char:
        beq t2, t3, fim_for_int_char
        jal ra, pow
        div a2, t1, t5 #digito
        rem t1, t1, t5
        addi a2, a2, 48
        sb a2, 0(a1)
        addi a1, a1, 1
        addi t3, t3, -1
        j for_int_char
    fim_for_int_char:
    li t2, '\n'
    sb t2, 0(a1)
    j fim_int_char
    imp_neg:
        li t2, '-'
        sb t2, 0(a1)
        li t2, '1'
        sb t2, 1(a1)
        li t2, '\n'
        sb t2, 2(a1)
    fim_int_char:
    
    mv ra, s0
    ret

compara:
    la a3, head_node
    li t1, -1
    li t2, 0 #contador
    lw s0, 0(a3)
    for_comp:
        li t0, 0
        beq s0, t0, fim_comp
        lw s0, 0(a3)
        lw s1, 4(a3)
        add s0, s1, s0
        beq a5, s0, guarda_ind 
        addi t2, t2, 1
        lw a3, 8(a3)
        lw s0, 0(a3)
        j for_comp
    guarda_ind:
        mv t1, t2
    fim_comp:
    ret

_start:
    jal ra, read
    jal ra, converte_int
    jal ra, compara
    jal ra, num_digit
    jal ra, int_char
    jal ra, write

.section .data
input_address: .skip 7
output_address: .skip 7