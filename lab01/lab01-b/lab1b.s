	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0"
	.file	"lab1b.c"
	.globl	read
	.p2align	2
	.type	read,@function
read:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 63	# syscall write code (63) 
	ecall		# invoke syscall 
	mv	a3, a0	# move return value to ret_val

	#NO_APP
	sw	a3, -28(s0)
	lw	a0, -28(s0)
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	read, .Lfunc_end0-read

	.globl	write
	.p2align	2
	.type	write,@function
write:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 64	# syscall write (64) 
	ecall	
	#NO_APP
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	write, .Lfunc_end1-write

	.globl	exit
	.p2align	2
	.type	exit,@function
exit:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	#APP
	mv	a0, a1	# return code
	li	a7, 93	# syscall exit (64) 
	ecall	
	#NO_APP
.Lfunc_end2:
	.size	exit, .Lfunc_end2-exit

	.globl	_start
	.p2align	2
	.type	_start,@function
_start:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	call	main
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	exit
.Lfunc_end3:
	.size	_start, .Lfunc_end3-_start

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
	lui	a1, %hi(buffer)
	addi	a1, a1, %lo(buffer)
	sw	a1, -24(s0)
	li	a2, 10
	call	read
	mv	a1, a0
	lw	a0, -24(s0)
	sw	a1, -16(s0)
	lbu	a0, 2(a0)
	li	a1, 43
	bne	a0, a1, .LBB4_2
	j	.LBB4_1
.LBB4_1:
	lui	a1, %hi(buffer)
	lbu	a0, %lo(buffer)(a1)
	addi	a1, a1, %lo(buffer)
	lbu	a1, 4(a1)
	add	a0, a0, a1
	addi	a0, a0, -96
	sw	a0, -20(s0)
	j	.LBB4_8
.LBB4_2:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 2(a0)
	li	a1, 45
	bne	a0, a1, .LBB4_4
	j	.LBB4_3
.LBB4_3:
	lui	a1, %hi(buffer)
	lbu	a0, %lo(buffer)(a1)
	addi	a1, a1, %lo(buffer)
	lbu	a1, 4(a1)
	sub	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB4_7
.LBB4_4:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 2(a0)
	li	a1, 42
	bne	a0, a1, .LBB4_6
	j	.LBB4_5
.LBB4_5:
	lui	a0, %hi(buffer)
	addi	a1, a0, %lo(buffer)
	lbu	a0, %lo(buffer)(a0)
	addi	a0, a0, -48
	lbu	a1, 4(a1)
	addi	a1, a1, -48
	mul	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB4_6
.LBB4_6:
	j	.LBB4_7
.LBB4_7:
	j	.LBB4_8
.LBB4_8:
	lw	a0, -20(s0)
	lw	a2, -16(s0)
	lui	a1, %hi(buffer)
	addi	a1, a1, %lo(buffer)
	add	a2, a1, a2
	sb	a0, 0(a2)
	lw	a0, -16(s0)
	addi	a2, a0, 2
	li	a0, 1
	call	write
	li	a0, 0
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	main, .Lfunc_end4-main

	.type	buffer,@object
	.bss
	.globl	buffer
buffer:
	.zero	10
	.size	buffer, 10

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym exit
	.addrsig_sym main
	.addrsig_sym buffer
