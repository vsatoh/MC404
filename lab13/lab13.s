.section .text
.globl play_note
.globl _system_time  
.globl _start

gpt_interrupt:
    #gera uma interupcao a cada 100 milisegundos
    la a0, base_gpt
    li t0, 1
    sb t0, 0(a0)

    brk_gpt: #n avancar enquanto n terminar a leitura
        lb t0, 0(a0)
        li t1, 0
    bne t0, t1, brk_gpt

    la a2, _system_time
    lw t1, 0(a2)
    lw t0, 4(a0)
    add t0, t1, t0
    sw t0, 0(a2)

    li t0, 100
    sw t0, 8(a0)

    ret

play_note:
    #int ch - a0, int inst - a1, int note - a2, int vel - a3, int dur - a4 
    la s0, base_synth
    sh a1, 2(s0)
    sb a2, 4(s0)
    sb a3, 5(s0)
    sh a4, 6(s0)
    sb a0, 0(s0)

    ret

interrupcao:    
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

    #trata interrupcao
    jal ra, gpt_interrupt

    lw s0, 28(sp)

    lw t1, 24(sp)
    lw t0, 20(sp)

    lw a4, 16(sp) 
    lw a3, 12(sp)
    lw a2, 8(sp)
    lw a1, 4(sp) 
    lw a0, 0(sp)

    addi sp, sp, 32 # Desaloca espaço da pilha
    csrrw sp, mscratch, sp

    mret

_start:
    la t0, interrupcao
    csrw mtvec, t0 

    jal gpt_interrupt

    la t0, isr_stack_end # t0 <= base da pilha
    csrw mscratch, t0 

    # Habilita Interrupções Externas
    csrr t1, mie # Seta o bit 11 (MEIE)
    li t2, 0x800 # do registrador mie
    or t1, t1, t2
    csrw mie, t1

    # Habilita Interrupções Global
    csrr t1, mstatus # Seta o bit 3 (MIE)
    ori t1, t1, 0x8 # do registrador mstatus
    csrw mstatus, t1

    jal main

.data
_system_time: .word 0

.section .bss
.align 4
isr_stack:
.skip 512
isr_stack_end:

.text
.set base_gpt, 0xFFFF0100
.set base_synth, 0xFFFF0300