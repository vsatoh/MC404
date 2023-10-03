.section .text
.globl _start

open:
    la a0, input_file    # address for the file path
    li a1, 0             # flags (0: rdonly, 1: wronly, 2: rdwr)
    li a2, 0             # mode
    li a7, 1024          # syscall open 
    ecall
    ret

input_file: .asciz "image.pgm"

read:
    la a1, input_address #  buffer to write the data
    li a2, 262159 # size (reads only 1 byte)
    li a7, 63 # syscall read (63)
    ecall
    ret

write:
    li a0, 1          
    la a1, input_address       
    li a2, 262159       
    li a7, 64          
    ecall    
    ret

read_size:
    li t0, ' '
    li t1, 10
    li s0, 0
    for_rdsz:
        lbu a4, 0(a3)
        addi a3, a3, 1
        beq a4, t0, fim_rdsz
        mul s0, s0, t1
        addi a4, a4, -48
        add s0, s0, a4
        j for_rdsz
    fim_rdsz:    
    ret

read_size2:
    li t0, '\n'
    li t1, 10
    li s1, 0
    for_rdsz2:
        lbu a4, 0(a3)
        addi a3, a3, 1
        beq a4, t0, fim_rdsz2
        mul s1, s1, t1
        addi a4, a4, -48
        add s1, s1, a4
        j for_rdsz2
    fim_rdsz2:  
    ret

setPixel:
    mv a0, t1
    mv a1, t0
    mv a2, t2
    li a7, 2200 # syscall setPixel (2200)
    ecall
    ret

setCanvasSize:
    mv a0, s0
    mv a1, s1
    li a7, 2201
    ecall
    ret


printImg:
    mv s3, ra #armazena o valor de ra 
    li t0, 0

    for1:
        bge t0, s1, cont1
        li t1, 0
        for2:
            bge t1, s0, cont2
            #t1 = 0 ou t0 = 0 ou t1 = s0-1 ou t0 = s1-1
            li a7, 0
            beq a7, t0, else
            beq a7, t1, else

            mv a7, s0
            addi a7, a7, -1
            beq a7, t1, else

            mv a7, s1
            addi a7, a7, -1
            beq a7, t0, else

            jal ra, setFilter
            mv t6, t2

            slli t2, t2, 8
            add t2, t2, t6
            slli t2, t2, 8
            add t2,t2, t6
            slli t2, t2, 8
            addi t2, t2, 255
            j cont3

            else: 
                li t2, 0x000000ff

            cont3:
            jal ra, setPixel
            addi t1, t1, 1
            addi a3, a3, 1
            j for2
        cont2:
        addi t0, t0, 1
        j for1
    cont1:
    mv ra, s3
    ret

setFilter:
    li t5, 8
    li t2, 0
    li t3, -1
    sub a3, a3, s0

    lbu t4, 0(a3)
    mul t4, t4, t3
    add t2, t2, t4
    lbu t4, -1(a3)
    mul t4, t4, t3
    add t2, t2, t4
    lbu t4, 1(a3)
    mul t4, t4, t3
    add t2, t2, t4
    add a3, a3, s0

    lbu t4, 0(a3)
    mul t4, t4, t5
    add t2, t2, t4
    lbu t4, -1(a3)
    mul t4, t4, t3
    add t2, t2, t4
    lbu t4, 1(a3)
    mul t4, t4, t3
    add t2, t2, t4
    add a3, a3, s0


    lbu t4, 0(a3)
    mul t4, t4, t3
    add t2, t2, t4
    lbu t4, -1(a3)
    mul t4, t4, t3
    add t2, t2, t4
    lbu t4, 1(a3)
    mul t4, t4, t3
    add t2, t2, t4
    sub a3, a3, s0

    li t4, 0
    blt t2, t4, menor_que_zero

    li t4, 255
    blt t4, t2, maior_que_ff
    j fim_set

    menor_que_zero:
        li t2, 0x0
        j fim_set

    maior_que_ff:
        li t2, 0xff
        j fim_set

    fim_set:
    ret

_start:
    jal ra, open
    jal ra, read

    la a3, input_address
    addi a3, a3, 3
    #s0 widht s1 height
    jal ra, read_size

    jal ra, read_size2


    jal ra, setCanvasSize

    addi a3, a3, 4
    jal ra, printImg

    li a0, 0
    li a7, 93
    ecall

.section .data
input_address: .skip 262159