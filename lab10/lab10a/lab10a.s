.section .text
.globl _start

void_puts:
    #Changes \0 for \n
    #string comes in a0
    #needs to write the string
    li t0, '\0'
    lb t1, 0(a0)
    li t2, 0
    for_void_puts:
        addi t2, t2, 1
        beq t0, t1, fim_void_puts
        addi a0, a0, 1
        lb t1, 0(a0)
        j for_void_puts
    fim_void_puts:
    li t0, '\n'
    sb t0, 0(a0)
    ret

str_gets:
    #Changes \n for \0
    #string return in a0
    #needs to read the string
    li t0, '\n'
    lb t1, 0(a0)
    li t2, 0
    for_str_gets:
        addi t2, t2, 1
        beq t0, t1, fim_str_gets
        addi a0, a0, 1
        lb t1, 0(a0)
        j for_str_gets
    fim_str_gets:
    li t0, '\0'
    sb t0, 0(a0)
    ret

int_atoi:
    #(a0 char * str)
    la a0, input_address
    lb a3, 0(a0)
    li a5, 0 #num de entrada
    li a4, '-'
    beq a3, a4, num_neg
    li a4, '\0'
    for1:
        beq a3, a4, fim
        li a4, 10
        mul a5, a5, a4
        addi a3, a3, -48
        add a5, a3, a5
        addi a0, a0, 1
        lb a3, 0(a0)
        li a4, '\0'
        j for1

    num_neg:
        addi a0, a0, 1
        li a4, '\n'
        lb a3, 0(a0)
        for2:
            beq a3, a4, fim2
            li a4, 10
            mul a5, a5, a4
            addi a3, a3, -48
            add a5, a3, a5
            addi a0, a0, 1
            lb a3, 0(a0)
            li a4, '\0'
            j for2
        fim2:
        li a4, -1
        mul a5, a5, a4
    fim:
    mv a0, a5
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

char_itoa:
    #(a0 int value,a1 char * str,a2 int base )
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