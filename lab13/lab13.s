sleep:
    #busy waiting
    #recebe o tempo que quer ficar parado em a0
    la t0, _system_time

gpt_interrupt:
    #gera uma interupcao a cada 100 milisegundos
    la a0, base_gpt
    li t0, 1
    sb t0, 0(a0)

    lw a1, 4(a0)

    for_gpt_interrupt:

        brk_gpt: #n avancar enquanto n terminar a leitura
            lb t0, 0(a0)
            li t1, 0
        bne t0, t1, brk_gpt

        li t0, 1
        sb t0, 0(a0)

        lw a2, 4(a0)

        sub a2, a2, a1
        li t0, 100

        bge a2, t0, fim_for_gpt_interrupt
        j fim_for_gpt_interrupt
    
    fim_for_gpt_interrupt:
        #gera uma interrupacao

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

main:


_start:




.data
.set base_gpt, 0xFFFF0100
.set base_synth, 0xFFFF0300

.section .data
_system_time: .skip 100