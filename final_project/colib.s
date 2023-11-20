set_engine:
    #a0 engine
    #a1 wheel ang
    #return int

    addi sp, sp, -4
    sw ra, 0(sp)  

    jal Syscall_set_engine_and_steering

    lw ra, 0(sp)
    addi sp, sp, 4

    #retornar parametro em a0

    ret

set_handbrake:
    #a0 parametro 1 ou 0
    #return int
    addi a0, a0, -48

    addi sp, sp, -4
    sw ra, 0(sp)  

    jal Syscall_set_handbrake

    lw ra, 0(sp)
    addi sp, sp, 4

    #retornar parametro em a0

    ret

read_sensor_distance:

    addi sp, sp, -4
    sw ra, 0(sp)  

    jal Syscall_read_sensor_distance

    lw ra, 0(sp)
    addi sp, sp, 4

    #retornar parametro em a0

    ret

get_position:
    #a0, a1, a2 vao receber os enderecos de memoria para x, y e z
    la t0, x_aux
    la t1, y_aux
    la t2, z_aux

    #vamos armazenar em aux, os enderecos de x, y e z
    sw a0, 0(t0)
    sw a1, 0(t1)
    sw a2, 0(t2)

    addi sp, sp, -4
    sw ra, 0(sp)  

    jal Syscall_get_position

    lw ra, 0(sp)
    addi sp, sp, 4

    lw t0, 0(a0)
    lw t1, 0(a1)
    lw t2, 0(a2)

    la a0, x_aux
    la a1, y_aux
    la a2, z_aux

    sw t0, 0(a0)
    sw t1, 0(a1)
    sw t2, 0(a2)

    ret

get_rotation:
    #a0, a1, a2 vao receber os enderecos de memoria para a_x, a_y e a_xz
    la t0, x_aux
    la t1, y_aux
    la t2, z_aux

    #vamos armazenar em aux, os enderecos de x, y e z
    sw a0, 0(t0)
    sw a1, 0(t1)
    sw a2, 0(t2)

    addi sp, sp, -4
    sw ra, 0(sp)  

    jal Syscall_get_rotation

    lw ra, 0(sp)
    addi sp, sp, 4

    lw t0, 0(a0)
    lw t1, 0(a1)
    lw t2, 0(a2)

    la a0, x_aux
    la a1, y_aux
    la a2, z_aux

    sw t0, 0(a0)
    sw t1, 0(a1)
    sw t2, 0(a2)

    ret

get_time:

    addi sp, sp, -4
    sw ra, 0(sp)  

    jal Syscall_get_systime

    lw ra, 0(sp)
    addi sp, sp, 4

    ret

gets:
    #a0 string 
    li t2, 0
    for_read:        
        la t3, base
        addi t3, t3, 2

        li t0, 1
        sb t0, 0(t3)

        brk_read: #n avancar enquanto n terminar a leitura
            lb t0, 0(t3)
            li t1, 0
        bne t0, t1, brk_read

        addi t3, t3, 1
        lb t0, 0(t3)

        sb t0, 0(a0)
        addi a0, a0, 1

        li t1, '\n'
        addi t2, t2, 1
        beq t1, t0, fim_for_read
        j for_read
    fim_for_read: 
    
    li t0, 0
    addi a0, a0, -1
    sb t0, 0(a0)

    ret

.section .data
x_aux: .skip 8
y_aux: .skip 8
z_aux: .skip 8
