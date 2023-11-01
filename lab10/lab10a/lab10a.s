.section .text
.globl puts
.globl gets
.globl atoi
.globl itoa
.globl linked_list_search
.globl exit

puts:
    #Muda 0 para n
    #string comes in a0
    #needs to write the string
    li t0, 0
    mv t3, a0 #salva o ponteiro de a0 (posicao inicial)
    li t2, 0 #numero de elementos de a0
    for_void_puts:
        lb t1, 0(a0)
        beq t0, t1, fim_void_puts
        addi t2, t2, 1
        addi a0, a0, 1
        j for_void_puts
    fim_void_puts:
    li t0, '\n'
    sb t0, 0(a0)
    mv a0, t3
    addi t2, t2, 1

    mv a1, a0
    mv a2, t2
    li a0, 1                    
    li a7, 64          
    ecall   

    mv a0, t3 #coloca a0 em sua posicao inicial
    li t0, 0
    add a0, a0, t2 #acessa o ultimo elemento (\n)
    sb t0, 0(a0)

    ret

gets:
    #Muda \n para 0
    #string return em a0
    mv t2, a0 #a0 eh o ponteiro pro buffer
    mv a1, a0
    li t0, '\n'
    for_str_gets:

        li a0, 0
        li a2, 1 # size (reads only 1 byte)
        li a7, 63 # syscall read (63)
        ecall   

        lb t1, 0(a1)
        addi a1, a1, 1
        beq t0, t1, fim_str_gets
        j for_str_gets

    fim_str_gets:
    li t0, 0
    sb t0, 0(a1)  

    mv a0, t2 #coloca a0 em sua posicao inicial
    ret

atoi:
    #(a0 char * str)
    #ignorar espacos antes e quaisquer tipo de caracter dps
    #return in a0 the value of char 
    for1:
        lb a3, 0(a0)
        li t0, ' '
        bne a3, t0, fim1
        addi a0, a0, 1
        j for1
    fim1:
    lb a3, 0(a0)
    li a5, 0 #num de entrada
    li a4, '-'
    beq a3, a4, num_neg
    li a4, 0
    for2:
        beq a3, a4, fim2
        li a4, '0'
        blt a3, a4, brk2
        li a4, 58
        bge a3, a4, brk2
        li a4, 10
        mul a5, a5, a4
        addi a3, a3, -48
        add a5, a3, a5
        brk2:
        addi a0, a0, 1
        lb a3, 0(a0)
        li a4, 0
        j for2

    num_neg:
        addi a0, a0, 1
        li a4, 0
        lb a3, 0(a0)
        for3:
            beq a3, a4, fim3
            li a4, '0'
            blt a3, a4, brk3
            li a4, 58
            bge a3, a4, brk3
            li a4, 10
            mul a5, a5, a4
            addi a3, a3, -48
            add a5, a3, a5
            brk3:
            addi a0, a0, 1
            lb a3, 0(a0)
            li a4, 0
            j for3
        fim3:
        li a4, -1
        mul a5, a5, a4
    fim2:
    mv a0, a5
    ret

itoa:
    #(a0 int value,a1 char * str,a2 int base )
    #preciso saber se eh negativo ou n 
    li t0, 0
    li t1, 0
    
    bge a0, t0, for_char_itoa # se t0 < a0 -> a0 eh positivo
    li t3, '-'
    sb t3, 0(a1)
    li t3, '1'
    sb t3, 1(a1) 
    li t3, 0
    sb t3, 2(a1) 
    mv a0, a1
    ret

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
    li a4, 0
    sb a4, 0(a1)
    sub a1, a1, t1
    mv a0, a1
    ret

linked_list_search:
    #(Node *head_node, int val)
    li t2, 0 #contador indice
    for_comp:
        li t0, 0
        lw s0, 0(a0)
        beq s0, t0, fim_comp
        lw s1, 4(a0)
        add s2, s1, s0
        beq a1, s2, guarda_ind #a1 eh o valor 
        addi t2, t2, 1
        lw a0, 8(a0)
        j for_comp
    guarda_ind:
        li a0, 0
        add a0, a0, t2
        ret
    fim_comp:
        li a0, -1
        ret

exit:
    li a0, 0
    li a7, 93
    ecall