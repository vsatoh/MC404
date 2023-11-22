.section .text
######
.globl _start
_start:

    li sp, 0x07FFFFFC

    la t0, int_handler
    csrw mtvec, t0

    csrr t1, mie
    li t2, 0x800
    or t1, t1, t2
    csrw mie, t1

    csrr t1, mstatus
    ori t1, t1, 0x8
    csrw mstatus, t1

    la t4, isr_stack_end
    csrw mscratch, t4

    jal us_mode
    
    jal main
    ret

int_handler:

    csrrw sp, mscratch, sp
    addi sp, sp, -48

    sw a2, 0(sp)
    sw a3, 4(sp)
    sw a4, 8(sp)
    sw a5, 12(sp)
    sw a6, 16(sp)
    sw t0, 20(sp)
    sw t1, 24(sp)
    sw t2, 28(sp)
    sw t3, 32(sp)
    sw t4, 36(sp)
    sw t5, 40(sp)
    sw t6, 44(sp)


    li t0, 10
    beq a7, t0, syscall_set_engine_and_steering
    li t0, 11
    beq a7, t0, syscall_set_handbrake
    li t0, 12
    beq a7, t0, syscall_read_sensors
    li t0, 13
    beq a7, t0, syscall_read_sensor_distance
    li t0, 15
    beq a7, t0, syscall_get_position
    li t0, 16
    beq a7, t0, syscall_get_rotation
    li t0, 17
    beq a7, t0, syscall_read_serial
    li t0, 18
    beq a7, t0, syscall_write_serial
    li t0, 20
    beq a7, t0, syscall_get_systime
    j end_syscall

us_mode:
    csrr t1, mstatus
    li t2, ~0x1800
    and t1, t1, t2
    csrw mstatus, t1

    la t5, main
    csrw mepc, t5
    mret

#a0 -> Movement direction
#a1 -> Steering wheel angle
syscall_set_engine_and_steering:
    la a3, address_car

    li t0, 1
    beq a0, t0, set_engine_check1
    li t0, -1
    beq a0, t0, set_engine_check1
    beq a0, zero, set_engine_check1
    j set_engine_fail
    
set_engine_check1:
    li t0, -127
    blt a1, t0, set_engine_fail
    li t0, 128
    bge a1, t0, set_engine_fail

    sb a1, 32(a3)
    sb a0, 33(a3)
    li a0, 0
    j end_syscall


set_engine_fail:
    li a0, -1
    j end_syscall


#a0 -> handbrake value
syscall_set_handbrake:
    la a3, address_car
    sb a0, 34(a3)
    j end_syscall


#a0 -> address of an array with 256 elements that will store the values read by the luminosity sensor.
syscall_read_sensors:
    la a3, address_car
    mv a6, a0
    li t6, 1
    sb t6, 1(a3)
read_camera_check:
    lb t6, 1(a3)
    bne t6, zero, read_camera_check
    li t5, 256
    li t4, 0
camera_loop:
    bge t4, t5, camera_fim
    lb t3, 36(a3)
    sb t3, 0(a0)
    addi t4, t4, 1
    addi a3, a3, 1
    addi a0, a0, 1
    j camera_loop
camera_fim:
    mv a0, a6
    j end_syscall

syscall_read_sensor_distance:
    la a3, address_car
    li t6, 1
    sb t6, 2(a3)
read_sensor_check:
    lb t6, 2(a3)
    bne t6, zero, read_sensor_check

    lw a0, 28(a3)
    j end_syscall

#a0 -> x position
#a1 -> y position
#a2 -> z position
syscall_get_position:
    la a3, address_car
    li t0, 1
    sb t0, 0(a3) #Iniciando GPS

gps:
    lb t0, 0(a3)
    bne t0, zero, gps

    lw t1, 16(a3) #X
    sw t1, 0(a0)
    lw t2, 20(a3) #Y
    sw t2, 0(a1)
    lw t3, 24(a3) #Z
    sw t3, 0(a2)
    j end_syscall

#a0 -> address of the variable that will store the value of the Euler angle in x
#a1 -> address of the variable that will store the value of the Euler angle in y
#a2 -> address of the variable that will store the value of the Euler angle in z
syscall_get_rotation:
    la a5, address_car
    li t6, 1
    sb t6, 0(a5)
get_rotation_check:
    lb t6, 0(a5)
    bne t6, zero, get_rotation_check
    lw t6, 4(a5)
    sw t6, 0(a0)

    lw t6, 8(a5)
    sw t6, 0(a1)

    lw t6, 12(a5)
    sw t6, 0(a2)
    j end_syscall

#a0 -> buffer
#a1 -> size
syscall_read_serial:
    mv a3, a0
    mv t6, a1
    la a0, address_serial
    mv t3, a3
    li a5, 0
get_loop:
    bge zero, t6, gets_fim
    mv a1, a0
    li t2, 1
    sb t2, 2(a1)
    read_test:
        lb t2, 2(a1)
        bne t2, zero, read_test
    lb t1, 3(a1)
    beq t1, zero, gets_fim
    
    addi a5, a5, 1
    sb t1, 0(a3)
    addi a3, a3, 1
    addi t6, t6, -1
    j get_loop

gets_fim:
    mv a0, a5
    mv a1, t3
    j end_syscall


#a0 -> buffer
#a1 -> size
syscall_write_serial:
    la a3, address_serial
    li t5, 0
puts_loop:
    beq zero, a1, write_fim
    lb t1, 0(a0)
    sb t1, 1(a3)
    li t3, 1
    sb t3, 0(a3)
write_test:
    lb t4, 0(a3)
    bne t4, zero, write_test

    addi a0, a0, 1
    addi a1, a1, -1
    j puts_loop

write_fim:
    j end_syscall


syscall_get_systime:
    la t5, address_gpt
    li t1, 1
    sb t1, 0(t5)
gpt_check:
    lb t6, 0(t5)
    bne t6, zero, gpt_check
    lw a0, 4(t5)
    j end_syscall

end_syscall:

    lw t6, 44(sp)
    lw t5, 40(sp)
    lw t4, 36(sp)
    lw t3, 32(sp)
    lw t2, 28(sp)
    lw t1, 24(sp)
    lw t0, 20(sp)
    lw a6, 16(sp)
    lw a5, 12(sp)
    lw a4, 8(sp)
    lw a3, 4(sp)
    lw a2, 0(sp)

    addi sp, sp, 48
    csrrw sp, mscratch, sp

    csrr t0, mepc
    addi t0, t0, 4
    csrw mepc, t0
    mret

.section .bss
.align 4
isr_stack:
.skip 2048
isr_stack_end:

.set address_gpt, 0xFFFF0100 #Endereço inicial do dispositivo
.set address_car, 0xFFFF0300 #Endereço inicial do dispositivo
.set address_serial, 0xFFFF0500 #Endereço inicial do dispositivo