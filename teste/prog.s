	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0"
	.file	"prog.c"
	.globl	main
	.p2align	2
	.type	main,@function
main:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	li	a0, 0
	sw	a0, -12(s0)
	li	a1, 400
	sw	a1, -16(s0)
	lw	a1, -16(s0)
	srli	a2, a1, 31
	add	a1, a1, a2
	srai	a1, a1, 1
	sw	a1, -20(s0)
	sw	a0, -24(s0)
	j	.LBB0_1
.LBB0_1:
	lw	a1, -24(s0)
	li	a0, 9
	blt	a0, a1, .LBB0_4
	j	.LBB0_2
.LBB0_2:
	lw	a0, -20(s0)
	lw	a1, -16(s0)
	div	a1, a1, a0
	add	a0, a0, a1
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -20(s0)
	lw	a1, -20(s0)
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	j	.LBB0_3
.LBB0_3:
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB0_1
.LBB0_4:
	li	a0, 0
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main

	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Valor de k: %d\n"
	.size	.L.str, 16

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym printf
