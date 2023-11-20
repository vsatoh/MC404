.text
.align 4
.globl _start
.globl control_logic

int_handler:
  ###### Syscall and Interrupts handler ######
  
  csrrw sp, mscratch, sp # Troca sp com mscratch
  addi sp, sp, -32 # Aloca espaço na pilha

  sw a0, 0(sp)
  sw a1, 4(sp) 
  sw a2, 8(sp)
  sw a3, 12(sp)
  sw a4, 16(sp) 

  sw t0, 20(sp)
  sw t1, 24(sp)
  
  sw s0, 28(sp)

  li t0, 10 
  bne a7, t0, handbrake
  #Seta o carro pra andar
  la a2, base

  addi a2, a2, 32
  sb a1, 0(a2)
  addi a2, a2, 1
  sb a0, 0(a2)

  j fim

  handbrake:
  #ativa o freio de mao
  li t0, 11 
  bne a7, t0, read_coordinates

  la a2, base
  addi a2, a2, 34
  sb a0, 0(a2)

  j fim

  read_coordinates:

  la t0, base
  li t1, 1
  sb t1, 0(t0)

  brk1: #n avancar enquanto n terminar a leitura
    lb t2, 0(t0)
    li t1, 0
  bne t2, t1, brk1

  la t1, x_pos
  addi t0, t0, 16
  lw t2, 0(t0) #x0
  sw t2, 0(t1)

  la t1, y_pos
  addi t0, t0, 4
  lw t2, 0(t0) #y0
  sw t2, 0(t1)

  la t1, z_pos
  addi t0, t0, 4
  lw t2, 0(t0) #z0
  sw t2, 0(t1)

  fim:
  
  lw s0, 28(sp)

  lw t1, 24(sp)
  lw t0, 20(sp)

  lw a4, 16(sp) 
  lw a3, 12(sp)
  lw a2, 8(sp)
  lw a1, 4(sp) 
  lw a0, 0(sp)

  addi sp, sp, 32
  csrrw sp, mscratch, sp

  csrr t0, mepc  
                 
  addi t0, t0, 4
  csrw mepc, t0 
  mret          
  
Syscall_set_engine_and_steering:
    #a0: Movement direction
    #a1: Steering wheel angle
    li a7, 10
    ecall

    ret

Syscall_set_handbrake:
    #a0 contem 0 ou 1
    li a7, 11
    ecall

    ret

Syscall_get_position:
    #a0: address of the variable that will store the value of x position. 
    #a1: address of the variable that will store the value of y position.
    #a2: address of the variable that will store the value of z position.
    li a7, 15
    ecall

    la t0, x_pos
    lw t1, 0(t0)
    sw t1, 0(a0)

    la t0, y_pos
    lw t1, 0(t0)
    sw t1, 0(a1)
    
    la t0, z_pos
    lw t1, 0(t0)
    sw t1, 0(a2)
    
    ret

check_destiny:
    #a0 x0, a1 y0, a2 z0

    li t1, 73
    li t2, 1
    li t3, -19

    sub t1, t1, a0 #x - x0
    sub t2, t2, a1 #y - y0
    sub t3, t3, a2 #z - z0

    mul t1, t1, t1 #(x - x0)^2
    mul t2, t2, t2 #(y - y0)^2
    mul t3, t3, t3 #(z - z0)^2

    add s0, t1, t2
    add s0, s0, t3 #s0 = (x - x0)^2 + (y - y0)^2 + (z - z0)^2

    li s1, 225 #s1 = r^2 (225)

    bge s1, s0, fim_check_destiny
    li a0, 0
    ret

    fim_check_destiny: 
        #interrompe o codigo
        li a0, 1
        ret

_start:

    la t0, int_handler  
    csrw mtvec, t0     

    la a0, isr_stack_end
    csrw mscratch, a0 

    csrr t1, mstatus     
    li t2, ~0x1800     
    and t1, t1, t2       
    csrw mstatus, t1
 
    la t0, user_main    
    csrw mepc, t0      

    jal user_main

control_logic:

    for_control_logic:

      li a0, 1
      li a1, -15

      addi sp, sp, -4
      sw ra, 0(sp)

      jal Syscall_set_engine_and_steering
      
      lw ra, 0(sp)
      addi sp, sp, 4


      addi sp, sp, -4
      sw ra, 0(sp)

      jal Syscall_get_position
      
      lw ra, 0(sp)
      addi sp, sp, 4


      addi sp, sp, -4
      sw ra, 0(sp)

      jal ra, check_destiny

      lw ra, 0(sp)
      addi sp, sp, 4

      li t1, 1
      beq a0, t1, fim_for_control_logic

      j for_control_logic
    fim_for_control_logic:

    addi sp, sp, -4
    sw ra, 0(sp)

    li a0, 1
    jal ra, Syscall_set_handbrake

    lw ra, 0(sp)
    addi sp, sp, 4

    ret

.section .bss
.align 4
isr_stack:
.skip 512
isr_stack_end:

.data
.set base, 0xFFFF0100

x_pos: .word 0

y_pos: .word 0

z_pos: .word 0