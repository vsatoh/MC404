.section .text
.globl _start



read:
    li a0, 0  
    la a1, input_address 
    li a2, 5  
    li a7, 63
    ecall
    ret

write:
    li a0, 1          
    la a1, output_address       
    li a2, 8           
    li a7, 64          
    ecall    
    ret

func_p1:    
    la a1, input_address
    lb a2, 0(a1)
    lb a3, 1(a1)
    xor a2, a3, a2
    lb a3, 2(a1)
    xor a2, a2, a3

func_p2:    
    # li s4, '1' #s4 = p2
    # li s0, 0 #num de 1
    # li s1, 1
    # la a3, input_address
    # lb a4, 0(a3)
    # addi a4, a4, -48

    # cond_p21:
    #     if_p21:
    #         beq a4, s1, else_p21
    #         j cond_p22
    #     else_p21:
    #         addi s0, s0, 1
    #         j cond_p22

    # cond_p22:
    #     lb a4, 2(a3)
    #     addi a4, a4, -48

    #     if_p22:
    #         beq a4, s1, else_p22
    #         j cond_p23
    #     else_p22:
    #         addi s0, s0, 1
    #         j cond_p23

    # cond_p23:
    #     lb a4, 3(a3)
    #     addi a4, a4, -48

    #     if_p23:
    #         beq a4, s1, else_p23
    #         j fim_condp2
    #     else_p23:
    #         addi s0, s0, 1
    #         j fim_condp2
    
    # fim_condp2:
    #     li s2, 2
    #     rem s0, s0, s2
    #     #verificar se eh impar ou par
    
    # beq s0, s1, set_bit_p2

    # fim_p2:
    #     ret

    # set_bit_p2:
    #     li s4, '0'
    #     j fim_p2
    

func_p3:   
    li s5, '1'
    li s0, 0 #num de 1
    li s1, 1
    la a3, input_address
    lb a4, 1(a3)
    addi a4, a4, -48
    
    cond_p31:
        if_p31:
            beq a4, s1, else_p31
            j cond_p32
        else_p31:
            addi s0, s0, 1
            j cond_p32

    cond_p32:
        lb a4, 2(a3)
        addi a4, a4, -48

        if_p32:
            beq a4, s1, else_p32
            j cond_p33
        else_p32:
            addi s0, s0, 1
            j cond_p33

    cond_p33:
        lb a4, 3(a3)
        addi a4, a4, -48

        if_p33:
            beq a4, s1, else_p33
            j fim_condp3
        else_p33:
            addi s0, s0, 1
            j fim_condp3
    
    fim_condp3:
        li s2, 2
        rem s0, s0, s2
        #verificar se eh impar ou par

    beq s0, s1, set_bit_p3

    fim_p3:
        ret
        
    set_bit_p3:
        li s5, '0'
        j fim_p3

encode:
    jal t0, func_p1
    mv s1, a2
    jal t0, func_p2
    jal t0, func_p3
    la a3, string
    la a1, output_address

    sb s3, 0(a1)
    sb s4, 1(a1)
    lb a4, 0(a3)
    sb a4, 2(a1)
    sb s5, 3(a1)

    lb a4, 1(a3)
    sb a4, 4(a1)

    lb a4, 2(a3)
    sb a4, 5(a1)

    lb a4, 3(a3)
    sb a4, 6(a1)

    li t2, '\n'
    sb t2, 7(a1)
    jal t0, write
    ret


_start:
    jal ra, encode
    ret

.section .data
input_address: .skip 0x14 
output_address: .skip 0x8
string: .asciz "1010"