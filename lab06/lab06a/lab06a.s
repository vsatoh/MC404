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
        
    sqrt:

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        div  a5, s1, a3
        add a3, a3, a5
        li t2, 2
        div a3, a3, t2

        ret

    char_int:

        li s1, 0

        la a1, input_address
        add a1, a1, s7
        
        lb a3, 0(a1)
        addi a3, a3, -48
        li t2, 1000
        mul a3, a3, t2
        add s1, s1, a3 

        lb a3, 1(a1)
        addi a3, a3, -48
        li t2, 100
        mul a3, a3, t2
        add s1, s1, a3 

        lb a3, 2(a1)
        addi a3, a3, -48
        li t2, 10
        mul a3, a3, t2
        add s1, s1, a3 

        lb a3, 3(a1)
        addi a3, a3, -48
        add s1, s1, a3 
        ret

    int_char:
        
        la a1, output_address

        li t2, 1000
        divu s6, a3, t2
        remu a3, a3, t2
        addi s6, s6, 48
        sb s6, 0(a1)

        li t2, 100
        divu s6, a3, t2
        remu a3, a3, t2
        addi s6, s6, 48
        sb s6, 1(a1)

        li t2, 10
        divu s6, a3, t2
        remu a3, a3, t2
        addi s6, s6, 48
        sb s6, 2(a1)

        li t2, 1
        divu s6, a3, t2
        remu a3, a3, t2
        addi s6, s6, 48
        sb s6, 3(a1)

        ret


    _start:

        jal ra, read

        li s7, 0
        jal ra, char_int
        li t2, 2
        div a3, s1, t2
        jal ra, sqrt
        jal ra, int_char
        li t2, ' '
        sb t2, 4(a1)
        jal ra, write

        li s7, 5
        jal ra, char_int
        li t2, 2
        div a3, s1, t2
        jal ra, sqrt
        jal ra, int_char
        li t2, ' '
        sb t2, 4(a1)
        jal ra, write

        li s7, 10
        jal ra, char_int
        li t2, 2
        div a3, s1, t2
        jal ra, sqrt
        jal ra, int_char
        li t2, ' '
        sb t2, 4(a1)
        jal ra, write

        li s7, 15
        jal ra, char_int
        li t2, 2
        div a3, s1, t2
        jal ra, sqrt
        jal ra, int_char
        li t2, '\n'
        sb t2, 4(a1)
        jal ra, write
        
        li a0, 0
        li a7, 93
        ecall

.section .data
    input_address: .skip 20 
    output_address: .skip 20
