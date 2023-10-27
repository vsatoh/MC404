.section .text
.globl _start

read:
    #a0 base, a1 string 
    la a1, input_address
    for_read:        
        la a0, base
        addi a0, a0, 2

        li t0, 1
        sb t0, 0(a0)

        addi a0, a0, 1
        lb t0, 0(a0)

        sb t0, 0(a1)
        addi a1, a1, 1

        li t1, '\n'
        beq t1, t0, fim_for_read
        j for_read
    fim_for_read: 
    ret

write:
    #a0 base, a1 string
    for_write:
        la a0, base
        lb t0, 0(a1)

        #carrega e imprime
        sb t0, 1(a0)
        li t1, 1
        sb t1, 0(a0)

        #condicao de parada
        addi a1, a1, 1
        li t1, '\n'
        beq t1, t0, fim_write 
        j for_write
    fim_write:
    ret

ret_string:
    addi sp, sp, -4
    sw ra, 0(sp)  

    jal ra, read

    lw ra, 0(sp)
    addi sp, sp, 4    

    addi sp, sp, -4
    sw ra, 0(sp)  

    jal ra, write

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

reverse_string:
    addi sp, sp, -4
    sw ra, 0(sp)

    jal ra, read

    addi sp, sp, 4
    lw ra, 0(sp)

    la a1, input_address

    li t0, '\n'
    addi sp, sp, -4
    sb t0, 0(sp)   

    for_reverse_string1:
        li t1, '\n'
        lb t0, 0(a1)
        beq t0, t1, fim_for_reverse_string1

        addi sp, sp, -4
        sb t0, 0(sp)
        addi a1, a1, 1

        j for_reverse_string1
    fim_for_reverse_string1:

    for_reverse_string2:
        la a0, base
        lb t0, 0(sp)
        addi sp, sp, 4

        #carrega e imprime
        sb t0, 1(a0)
        li t1, 1
        sb t1, 0(a0)

        #condicao de parada
        li t1, '\n'
        beq t1, t0, fim_for_reverse_string2   
        j for_reverse_string2
    fim_for_reverse_string2:
    ret

hex_representation:
    #converte para inteiro (ret em a0)
    addi sp, sp, -4
    sw ra, 0(sp)  

    jal ra, atoi

    lw ra, 0(sp)
    addi sp, sp, 4

    #converte para char, hexa (ret em a0)
    addi sp, sp, -4
    sw ra, 0(sp) 

    li a2, 16
    jal ra, itoa

    lw ra, 0(sp)
    addi sp, sp, 4

    #imprime a string
    addi sp, sp, -4
    sw ra, 0(sp) 

    jal ra, write

    lw ra, 0(sp)
    addi sp, sp, 4

    ret

calculator:

atoi:
    #(a0 char * str)
    #ignorar espacos antes e quaisquer tipo de caracter dps
    #return in a0 the value of char 
    la a0, input_address
    lb a3, 0(a0)
    for2:
        li a4, '\n'
        beq a3, a4, fim2
        li a4, 10
        mul a5, a5, a4
        addi a3, a3, -48
        add a5, a3, a5
        brk2:
        addi a0, a0, 1
        lb a3, 0(a0)
        j for2
    fim2:
    mv a0, a5
    ret

itoa:
    li t1, 0
    for_char_itoa:
        addi t1, t1, 1 #numero de digitos
        rem t0, a0, a2 #resto da divisao
        sub a0, a0, t0 #elimina a menor casa decimal do numero xyz -> xy
        div a0, a0, a2
        #verificar se resto eh maior q 10
        li t2, 10
        bge t0, t2, hexa 
        addi t0, t0, 48
        j fim_hexa
        hexa:
            addi t0, t0, 55
        fim_hexa:
        sb t0, 0(a3) #a3 armazena temporariamente a string
        addi a3, a3, 1
        #pegar resto e inverter lista
        li t0, 0
        beq t0, a0, fim_for_char_itoa
        j for_char_itoa
    fim_for_char_itoa:
    addi a3, a3, -1
    li t0, 0
    for_char_itoa2:
        beq t0, t1, fim_for_char_itoa2
        lb a4, 0(a3)
        sb a4, 0(a1)
        addi a3, a3, -1
        addi a1, a1, 1
        addi t0, t0, 1
        j for_char_itoa2
    fim_for_char_itoa2:
    li a4, '\n'
    sb a4, 0(a1)
    sub a1, a1, t1
    mv a0, a1
    ret

_start:
    jal ra, read
    jal ra, atoi

    mv t0, a0 #entrada inicial

    jal ra, ret_string

.section .data
input_address: .skip 100

.set base, 0xFFFF0100