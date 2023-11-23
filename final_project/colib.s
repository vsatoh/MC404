.text
.globl set_engine
.globl set_handbrake
.globl read_sensor_distance
.globl get_position
.globl get_rotation
.globl get_time
.globl gets
.globl puts
.globl itoa
.globl atoi
.globl approx_sqrt
.globl strlen_custom
.globl get_distance
.globl fill_and_pop


set_engine:
    #a0 engine
    #a1 wheel ang
    #return int
    li a7, 10
    ecall
    #retornar parametro em a0

    ret

set_handbrake:
    #a0 parametro 1 ou 0
    #return int
    li a7, 11
    ecall
    #retornar parametro em a0

    ret

read_sensor_distance:
    li a7, 13
    ecall
    #retornar parametro em a0

    ret

get_position:
    #a0, a1, a2 vao receber os enderecos de memoria para x, y e z
    li a7, 15
    ecall

    ret

get_rotation:
    #a0, a1, a2 vao receber os enderecos de memoria para a_x, a_y e a_xz
    li a7, 16
    ecall

    ret

get_time:
    li a7, 20
    ecall

    ret

 gets:
    #a0 string 
    #a1 string size
    mv t3, a0
    mv t4, a0 #ponteiro para a posicao inical do buffer

    for_gets:
        mv a0, t3
        li a1, 1
        li a7, 17
        ecall

        lb t0, 0(t3)
        li t1, 0
        beq t0, t1, fim_for_gets
        li t1, 10
        beq t0, t1, fim_for_gets
        addi t3, t3, 1
        j for_gets
    fim_for_gets:
    li t0, 0
    sb t0, 0(t3)
    mv a0, t4
    ret

puts:
    #a0 string 
    #a1 string size 
    mv t3, a0
    li a1, 0 #numero de caracteres
    for_puts:
        lb t0, 0(t3)
        li t1, 0
        beq t1, t0, fim_for_puts
        addi t3, t3, 1
        addi a1, a1, 1
        j for_puts
    fim_for_puts:
        addi a1, a1, 1
        li t0, '\n' #colocaca um \n para imprimir
        sb t0, 0(t3)

        li a7, 18
        ecall
        ret

atoi:
    #(a0 char * str)
    #return in a0 the value of char 
    lb a3, 0(a0)
    li a5, 0

    li a4, '-'
    beq a3, a4, num_neg
    for2:
        li a4, 0
        beq a3, a4, fim2
        li a4, 10
        mul a5, a5, a4
        addi a3, a3, -48
        add a5, a3, a5
        brk2:
        addi a0, a0, 1
        lb a3, 0(a0)    
        j for2

    num_neg:
        addi a0, a0, 1
        li a4, 0
        lb a3, 0(a0)
        for3:
            li a4, 0
            beq a3, a4, fim3
            li a4, 10
            mul a5, a5, a4
            addi a3, a3, -48
            add a5, a3, a5
            brk3:
            addi a0, a0, 1
            lb a3, 0(a0)
            j for3
        fim3:
        li a4, -1
        mul a5, a5, a4

    fim2:
    mv a0, a5
    ret

itoa:
    #a0 num, a1 str saida, a2 base
    mv t4, a1
    li t1, 0
    bge a0, t1, for_char_itoa

    li t1, 45
    sb t1, 0(a1)
    li t1, -1
    mul a0, a0, t1
    li t0, '-'
    sb t0, 0(a1)
    addi a1, a1, 1
    addi t1, t1, 1
    for_char_itoa:
        addi t1, t1, 1 #numero de digitos
        remu t0, a0, a2 #resto da divisao
        sub a0, a0, t0 #elimina a menor casa decimal do numero xyz -> xy
        divu a0, a0, a2
        #verificar se resto eh maior q 10
        li t2, 10
        bge t0, t2, hexa 
        addi t0, t0, 48
        j fim_hexa
        hexa:
            addi t0, t0, 55
        fim_hexa:

        addi sp, sp, -1
        sb t0, 0(sp) #a3 armazena temporariamente a string
        #pegar resto e inverter lista
        li t0, 0
        beq t0, a0, fim_for_char_itoa
        j for_char_itoa
    fim_for_char_itoa:
    li t0, 0

    for_char_itoa2:
        beq t0, t1, fim_for_char_itoa2
        lb t2, 0(sp)
        sb t2, 0(a1)
        addi sp, sp, 1
        addi t0, t0, 1
        addi a1, a1, 1
        j for_char_itoa2
    fim_for_char_itoa2:
    li t0, 0
    sb t0, 0(a1)
    mv a1, t4
    mv a0, a1
    ret

strlen_custom:
    #a0 str
    li t2, 0 #numero de caracteres
    mv t3, a0
    for_strlen_custom:
        lb t0, 0(a0)
        li t1, 0
        beq t0, t1, fim_for_strlen_custom
        addi t2, t2, 1
        addi a0, a0, 1
        j for_strlen_custom
    fim_for_strlen_custom:
    mv a0, t3
    mv a0, t2
    ret

approx_sqrt:
    #a0 valor
    #a1 num de interacoes
    li t0, 2
    div t1, a0, t0
    li t2, 0 #n interacoes

    for_approx_sqrt:
        div t3, a0, t1 #y/k
        add t1, t1, t3 #k + y/k
        div t1, t1, t0 #(k + y/k)/2

        addi t2, t2, 1

        bge t2, a1, fim_for_approx_sqrt
        j for_approx_sqrt

    fim_for_approx_sqrt:
        mv a0, t1 #passando o valor de k para a0
    ret

get_distance:
    #a0 x0, a1 y0, a2 z0, a3 x1, a4 y1, a5 z1

    sub t0, a0, a3 #x - x0
    sub t1, a1, a4 #y - y0
    sub t2, a2, a5 #z - z0

    mul t0, t0, t0 #(x - x0)^2
    mul t1, t1, t1 #(y - y0)^2
    mul t2, t2, t2 #(z - z0)^2

    add t0, t1, t0
    add t0, t0, t2 #t0 = (x - x0)^2 + (y - y0)^2 + (z - z0)^2

    mv a0, t0
    li a1, 15

    addi sp, sp, -4
    sw ra, 0(sp)

    jal approx_sqrt

    lw ra, 0(sp)
    addi sp, sp, 4

    ret

fill_and_pop:
    lw t0, 0(a0)
    sw t0, 0(a1)

    lw t0, 4(a0)
    sw t0, 4(a1)

    lw t0, 8(a0)
    sw t0, 8(a1)

    lw t0, 12(a0)
    sw t0, 12(a1)

    lw t0, 16(a0)
    sw t0, 16(a1)

    lw t0, 20(a0)
    sw t0, 20(a1)

    lw t0, 24(a0)
    sw t0, 24(a1)

    lw t0, 28(a0)
    sw t0, 28(a1)

    mv a0, t0
    ret