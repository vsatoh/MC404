.section .text
.globl _start

move_car:
    #a0 base
    la a0, base
    li t0, 1
    sb t0, 0(a0)    

    brk1: #n avancar enquanto n terminar a leitura
        lb t0, 0(a0)
        li t1, 0
    bne t0, t1, brk1

    addi a0, a0, 32
    li t0, -14
    sb t0, 0(a0)
    addi a0, a0, 1
    li t0, 1
    sb t0, 0(a0)

    li a0, 0
    for_check_dest:
        li t0, 1
        beq a0, t0, fim_check_dest

        la a0, base
        li t0, 1
        sb t0, 0(a0)    

        brk2: 
            lb t0, 0(a0)
            li t1, 0
        bne t0, t1, brk2


        addi a0, a0, 32
        li t0, -14
        sb t0, 0(a0)
        addi a0, a0, 1
        li t0, 1
        sb t0, 0(a0)

        addi sp, sp, -4
        sw ra, 0(sp)

        jal ra, check_destiny

        lw ra, 0(sp)
        addi sp, sp, 4

        j for_check_dest
    fim_check_dest:
    la a0, base
    addi a0, a0, 34
    li t0, 1
    sb t0, 0(a0)
    ret

check_destiny:
    #a0 base, a1 x0, a2 y0, a3 z0

    la a0, base
    li t0, 1
    sb t0, 0(a0)    
    brk3: 
        lb t0, 0(a0)
        li t1, 0
    bne t0, t1, brk3

    li a1, 73
    li a2, 1
    li a3, -19

    addi a0, a0, 16
    lw t1, 0(a0) #x0
    addi a0, a0, 4
    lw t2, 0(a0) #y0
    addi a0, a0, 4
    lw t3, 0(a0) #z0
    addi a0, a0, 10

    sub t1, t1, a1 #x - x0
    sub t2, t2, a2 #y - y0
    sub t3, t3, a3 #z - z0

    mul t1, t1, t1 #(x - x0)^2
    mul t2, t2, t2 #(y - y0)^2
    mul t3, t3, t3 #(z - z0)^2

    add s0, t1, t2
    add s0, s0, t3 #s0 = (x - x0)^2 + (y - y0)^2 + (z - z0)^2

    li s1, 225 #s1 = r^2 (225)

    bge s1, s0, fim
    li a0, 0
    ret

    fim: 
        #interrompe o codigo
        li a0, 1
        ret

exit:
    li a0, 0
    li a7, 93
    ecall

_start:
    jal ra, move_car
    jal ra, exit

.data
.set base, 0xFFFF0100