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
    li a2, 20        
    li a7, 64          
    ecall    
    ret

func_p1:    
    la a1, input_address
    lb a2, 0(a1)
    lb a3, 1(a1)

    addi a2, a2, -48
    addi a3, a3, -48

    xor a2, a3, a2
    lb a3, 3(a1)
    addi a3, a3, -48
    xor a2, a2, a3
    addi a2, a2, 48
    ret

func_p2:    
    la a1, input_address
    lb a2, 0(a1)
    lb a3, 2(a1)

    addi a2, a2, -48
    addi a3, a3, -48

    xor a2, a3, a2
    lb a3, 3(a1)
    addi a3, a3, -48
    xor a2, a2, a3
    addi a2, a2, 48
    ret

func_p3:   
    la a1, input_address
    lb a2, 1(a1)
    lb a3, 2(a1)

    addi a2, a2, -48
    addi a3, a3, -48

    xor a2, a3, a2
    lb a3, 3(a1)
    addi a3, a3, -48
    xor a2, a2, a3
    addi a2, a2, 48
    ret

encode:
    mv t0, ra
    jal ra, func_p1
    mv s1, a2
    jal ra, func_p2
    mv s2, a2
    jal ra, func_p3
    mv s3, a2
    la a3, input_address
    la a1, output_address

    sb s1, 0(a1)
    sb s2, 1(a1)
    lb a4, 0(a3)
    sb a4, 2(a1)
    sb s3, 3(a1)

    lb a4, 1(a3)
    sb a4, 4(a1)

    lb a4, 2(a3)
    sb a4, 5(a1)

    lb a4, 3(a3)
    sb a4, 6(a1)

    li t2, '\n'
    sb t2, 7(a1)
    jal ra, write
    mv ra, t0
    ret

decode:
    mv t0, ra
    la a3, input_address
    la a1, output_address2
    addi a3, a3, 5    

    lb a4, 2(a3)
    sb a4, 0(a1)

    lb a4, 4(a3)
    sb a4, 1(a1)

    lb a4, 5(a3)
    sb a4, 2(a1)

    lb a4, 6(a3)
    sb a4, 3(a1)

    li t2, '\n'
    sb t2, 4(a1)
    li a0, 1          
    la a1, output_address2     
    li a2, 20        
    li a7, 64          
    ecall    

    mv ra, t0
    ret

err_detector:
    mv t0, ra
    la a3, input_address
    la a1, output_address3
    addi a3, a3, 5

    #func1
    lb s1, 0(a3)
    addi s1, s1, -48
    lb s2, 2(a3)
    addi s2, s2, -48
    xor s1, s1, s2

    lb s2, 4(a3)
    addi s2, s2, -48
    xor s1, s1, s2

    lb s2, 6(a3)
    addi s2, s2, -48
    xor s1, s1, s2

    #func2
    lb s3, 1(a3)
    addi s3, s3, -48
    lb s2, 2(a3)
    addi s2, s2, -48
    xor s3, s3, s2

    lb s2, 5(a3)
    addi s2, s2, -48
    xor s3, s3, s2

    lb s2, 6(a3)
    addi s2, s2, -48
    xor s3, s3, s2

    #func3
    lb s4, 3(a3)
    addi s4, s4, -48
    lb s2, 4(a3)
    addi s2, s2, -48
    xor s4, s4, s2

    lb s2, 5(a3)
    addi s2, s2, -48
    xor s4, s4, s2

    lb s2, 6(a3)
    addi s2, s2, -48
    xor s4, s4, s2

    or s1, s1, s3
    or s1, s1, s4


    addi s1, s1, 48
    sb s1, 0(a1)
    li t2, '\n'
    sb t2, 1(a1)

    li a0, 1          
    la a1, output_address3
    li a2, 20        
    li a7, 64          
    ecall    

    mv ra, t0
    ret

_start:
    jal ra, read
    jal ra, encode
    jal ra, decode
    jal ra, err_detector
    li a0, 0
    li a7, 93
    ecall

.section .data
input_address: .skip 20
output_address: .skip 20
output_address2: .skip 20
output_address3: .skip 20

string: .asciz "1010\n"