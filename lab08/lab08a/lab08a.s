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
    li a2, 262144  # size (reads only 1 byte)
    li a7, 63 # syscall read (63)
    ecall
    ret

write:
    li a0, 1          
    la a1, input_address       
    li a2, 262144       
    li a7, 64          
    ecall    
    ret

_start:
    jal ra, open
    jal ra, read
    jal ra, write

.section .data
input_address: .skip 262144