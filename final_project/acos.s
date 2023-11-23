.text
.globl _start

int_handler:
  ###### Syscall and Interrupts handler ######
  
    csrrw sp, mscratch, sp # Troca sp com mscratch
    addi sp, sp, -32 # Aloca espaço na pilha

    sw a3, 0(sp)
    sw a4, 4(sp) 
    sw a5, 8(sp)
    sw t0, 12(sp)
    sw t1, 16(sp) 
    sw t2, 20(sp)
    sw t3, 24(sp)
    sw t4, 28(sp)

    li t0, 10 
    beq a7, t0, Syscall_set_engine_and_steering
    li t0, 11 
    beq a7, t0, Syscall_set_handbrake
    li t0, 12
    beq a7, t0, Syscall_read_sensors
    li t0, 13
    beq a7, t0, Syscall_read_sensor_distance
    li t0, 15
    beq a7, t0, Syscall_get_position
    li t0, 16
    beq a7, t0, Syscall_get_rotation
    li t0, 17
    beq a7, t0, Syscall_read_serial
    li t0, 18
    beq a7, t0, Syscall_write_seral
    li t0, 20
    beq a7, t0, Syscall_get_systime

    j fim_syscall

    Syscall_set_engine_and_steering:

        li t0, 127
        blt t0, a1, fail_set_engine_and_steering
        li t0, -127
        blt a1, t0, fail_set_engine_and_steering

        li t0, 2
        bge a0, t0, fail_set_engine_and_steering
        li t0, -1
        blt a0, t0, fail_set_engine_and_steering

        la a3, base_car

        sb a0, 33(a3)
        sb a1, 32(a3)
        li a0, 0
        j fim_syscall

        fail_set_engine_and_steering:
            li a0, -1
            j fim_syscall

    Syscall_set_handbrake:

        li t0, 0
        beq t0, a0, check_handbrake
        li t0, 1
        beq t0, a0, check_handbrake
        li a0, -1
        j fim_syscall

        check_handbrake:
        la a3, base_car
        addi a3, a3, 34
        sb a0, 0(a3)

        li a0, 0

        j fim_syscall

    Syscall_read_sensors:

        la a3, base_car
        mv t3, a0 #salva o ponteiro para a0

        li t0, 1
        sb t0, 1(a3)

        busy_waiting_read_sensors: #n avancar enquanto n terminar a leitura
            lb t0, 1(a3)
            li t1, 0
        bne t0, t1, busy_waiting_read_sensors

        #copiar os dados lidos
        li t0, 0
        li t1, 256
        addi a3, a3, 36
        copy_read_sensors:
            bge t0, t1, fim_copy_read_sensors
            lb t2, 0(a3)
            sb t2, 0(a0)
            addi t0, t0, 1
            addi a3, a3, 1
            addi a0, a0, 1
            j copy_read_sensors
        fim_copy_read_sensors:
            mv a0, t3 #volta a apontar para o inicio do vetor
        j fim_syscall

    Syscall_read_sensor_distance:
        la a3, base_car
        li t0, 1
        sb t0, 2(a3)

        busy_waiting_read_sensors_distance: #n avancar enquanto n terminar a leitura
            lb t0, 0(a3)
            li t1, 0
        bne t0, t1, busy_waiting_read_sensors_distance      

        #Se n tiver nd em 20 m, ret -1
        lw a0, 28(a3)
        j fim_syscall

    Syscall_get_position:
        #a0: address of the variable that will store the value of x position. 
        #a1: address of the variable that will store the value of y position.
        #a2: address of the variable that will store the value of z position.
        la a3, base_car
        li t0, 1
        sb t0, 0(a3)

        busy_waiting_get_position: #n avancar enquanto n terminar a leitura
            lb t0, 0(a3)
            li t1, 0
            bne t0, t1, busy_waiting_get_position

        lw t0, 16(a3) #x0
        sw t0, 0(a0)

        lw t0, 20(a3) #y0
        sw t0, 0(a1)

        lw t0, 24(a3) #z0
        sw t0, 0(a2)
        
        j fim_syscall

    Syscall_get_rotation:
        la a3, base_car
        li t0, 1
        sb t0, 0(a3)

        busy_waiting_get_rotation: #n avancar enquanto n terminar a leitura
            lb t0, 0(a3)
            li t1, 0
        bne t0, t1, busy_waiting_get_rotation

        lw t0, 4(a3) #x0
        sw t0, 0(a0)

        lw t0, 8(a3) #y0
        sw t0, 0(a1)

        lw t0, 12(a3) #z0
        sw t0, 0(a2)
        
        j fim_syscall

    Syscall_read_serial:
        #a0 buffer
        #a1 num bytes a serem lidos
        la a3, base_serial
        mv t3, a0 #salva a posicao inicial do buffer
        li t2, 0 # num de caracteres lidos
        for_read_serial:
            li t0, 1
            sb t0, 2(a3)

            busy_waiting_read_serial:
                lb t0, 2(a3)
                li t1, 0
            bne t0, t1, busy_waiting_read_serial

            lb t0, 3(a3)
            sb t0, 0(a0)

            li t1, 0
            beq t0, t1, fim_for_read_serial

            addi a0, a0, 1
            addi t2, t2, 1

            beq t2, a1, fim_for_read_serial
            j for_read_serial
        fim_for_read_serial:
            mv a0, t3
            mv a0, t2

        j fim_syscall

    Syscall_write_seral:
        la a3, base_serial
        mv t3, a0
        li t2, 0
        for_write_serial:
            #imprime
            lb t0, 0(a0)
            sb t0, 1(a3)
            li t1, 1
            sb t1, 0(a3)

            busy_waiting_write_serial:
                lb t0, 0(a3)
                li t1, 0
            bne t0, t1, busy_waiting_write_serial 

            addi a0, a0, 1
            addi t2, t2, 1

            beq t2, a1, fim_for_write_serial
            j for_write_serial

        fim_for_write_serial:
            mv a0, t3
            j fim_syscall

    Syscall_get_systime:
        la a3, base_gpt
        li t0, 1
        sw t0, 0(a3)

        busy_waiting_get_systime:
            lw t0, 0(a3)
            li t1, 0
        bne t0, t1, busy_waiting_get_systime 

        lw a0, 4(a3)

        j fim_syscall

    fim_syscall:

    lw t4, 28(sp)
    lw t3, 24(sp)
    lw t2, 20(sp)
    lw t1, 16(sp) 
    lw t0, 12(sp)
    lw a5, 8(sp)
    lw a4, 4(sp) 
    lw a3, 0(sp)

    addi sp, sp, 32
    csrrw sp, mscratch, sp

    csrr t0, mepc  
                    
    addi t0, t0, 4
    csrw mepc, t0 
    mret          

_start:

    li sp, 0x07FFFFFC

    la t0, int_handler  
    csrw mtvec, t0     

    la a0, isr_stack_end
    csrw mscratch, a0 

    csrr t1, mie # Seta o bit 11 (MEIE)
    li t2, 0x800 # do registrador mie
    or t1, t1, t2
    csrw mie, t1

    # Habilita Interrupções Global
    csrr t1, mstatus # Seta o bit 3 (MIE)
    ori t1, t1, 0x8 # do registrador mstatus
    csrw mstatus, t1

    csrr t1, mstatus       
    li t2, ~0x1800         
    and t1, t1, t2          
    csrw mstatus, t1
 
    la t0, main       
    csrw mepc, t0  

    mret

.section .bss
.align 4
isr_stack:
.skip 1024
isr_stack_end:

.data
.set base_gpt, 0xFFFF0100
.set base_car, 0xFFFF0300
.set base_serial, 0xFFFF0500 