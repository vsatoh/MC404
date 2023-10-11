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
        li a4, '\0'
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



char_itoa:
    #(a0 int value,a1 char * str,a2 int base )
    #preciso saber se eh negativo ou n 
    li t0, -1
    li t1, 0
    blt t0, a0, for_char_itoa # se t0 < a0 -> a0 eh positivo
    mul a0, a0, t0
    li t0, '-'
    sb t0, 0(a1)
    addi a1, a1, 1
    for_char_itoa:
        li t0, 0
        beq t0, a0, fim_for_char_itoa
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
            addi t0, t0, 87
        fim_hexa:
        sb t0, 0(a3) #a3 armazena temporariamente a string
        addi a3, a3, 1
        #pegar resto e inverter lista
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
    ret

_start:
    li a0, 54
    li a2, 10
    la a1, output_address
    jal ra, char_itoa
    jal ra, write
.section .data
input_address: .skip 7
output_address: .skip 7