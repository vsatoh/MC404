	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0"
	.file	"lab03.c"
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

	.globl	potencia
	.p2align	2
	.type	potencia,@function
potencia:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 1
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB4_1
.LBB4_1:
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB4_4
	j	.LBB4_2
.LBB4_2:
	lw	a1, -12(s0)
	lw	a0, -20(s0)
	mul	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB4_3
.LBB4_3:
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB4_1
.LBB4_4:
	lw	a0, -20(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	potencia, .Lfunc_end4-potencia

	.globl	converte_char_int
	.p2align	2
	.type	converte_char_int,@function
converte_char_int:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -24(s0)
	j	.LBB5_1
.LBB5_1:
	lw	a1, -24(s0)
	lw	a0, -16(s0)
	blt	a0, a1, .LBB5_4
	j	.LBB5_2
.LBB5_2:
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a1, a0
	lbu	a0, -1(a0)
	addi	a0, a0, -48
	sw	a0, -28(s0)
	lw	a0, -16(s0)
	sub	a1, a0, a1
	li	a0, 10
	call	potencia
	mv	a1, a0
	lw	a0, -28(s0)
	mul	a1, a0, a1
	lw	a0, -20(s0)
	add	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB5_3
.LBB5_3:
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB5_1
.LBB5_4:
	lw	a0, -20(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end5:
	.size	converte_char_int, .Lfunc_end5-converte_char_int

	.globl	converte_dec_bin
	.p2align	2
	.type	converte_dec_bin,@function
converte_dec_bin:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	sw	a0, -20(s0)
	j	.LBB6_1
.LBB6_1:
	lw	a0, -20(s0)
	li	a1, 0
	beq	a0, a1, .LBB6_3
	j	.LBB6_2
.LBB6_2:
	lw	a0, -20(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -20(s0)
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB6_1
.LBB6_3:
	lw	a1, -16(s0)
	addi	a0, a1, 2
	mv	a2, sp
	sw	a2, -24(s0)
	addi	a1, a1, 17
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -36(s0)
	mv	sp, a1
	sw	a0, -28(s0)
	li	a0, 48
	sb	a0, 0(a1)
	li	a0, 98
	sb	a0, 1(a1)
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB6_4
.LBB6_4:
	lw	a0, -32(s0)
	li	a1, 2
	blt	a0, a1, .LBB6_10
	j	.LBB6_5
.LBB6_5:
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a1, a0, a1
	andi	a1, a1, -2
	sub	a0, a0, a1
	li	a1, 0
	bne	a0, a1, .LBB6_7
	j	.LBB6_6
.LBB6_6:
	lw	a0, -36(s0)
	lw	a1, -32(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB6_8
.LBB6_7:
	lw	a0, -36(s0)
	lw	a1, -32(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB6_8
.LBB6_8:
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -12(s0)
	j	.LBB6_9
.LBB6_9:
	lw	a0, -32(s0)
	addi	a0, a0, -1
	sw	a0, -32(s0)
	j	.LBB6_4
.LBB6_10:
	lw	a1, -36(s0)
	lw	a0, -16(s0)
	addi	a2, a0, 2
	li	a0, 1
	call	write
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	mv	sp, a1
	addi	sp, s0, -48
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end6:
	.size	converte_dec_bin, .Lfunc_end6-converte_dec_bin

	.globl	polinomio_bin
	.p2align	2
	.type	polinomio_bin,@function
polinomio_bin:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	j	.LBB7_1
.LBB7_1:
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB7_6
	j	.LBB7_2
.LBB7_2:
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB7_4
	j	.LBB7_3
.LBB7_3:
	lw	a1, -16(s0)
	lw	a0, -24(s0)
	not	a0, a0
	add	a1, a0, a1
	li	a0, 2
	call	potencia
	mv	a1, a0
	lw	a0, -20(s0)
	add	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB7_4
.LBB7_4:
	j	.LBB7_5
.LBB7_5:
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB7_1
.LBB7_6:
	lw	a0, -20(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end7:
	.size	polinomio_bin, .Lfunc_end7-polinomio_bin

	.globl	converte_dec_bin2
	.p2align	2
	.type	converte_dec_bin2,@function
converte_dec_bin2:
	addi	sp, sp, -96
	sw	ra, 92(sp)
	sw	s0, 88(sp)
	addi	s0, sp, 96
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	sw	a0, -20(s0)
	lw	a0, -12(s0)
	sw	a0, -24(s0)
	j	.LBB8_1
.LBB8_1:
	lw	a0, -24(s0)
	li	a1, 0
	beq	a0, a1, .LBB8_3
	j	.LBB8_2
.LBB8_2:
	lw	a0, -24(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -24(s0)
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB8_1
.LBB8_3:
	lw	a0, -16(s0)
	mv	a1, sp
	sw	a1, -28(s0)
	addi	a1, a0, 15
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -92(s0)
	mv	sp, a1
	sw	a0, -32(s0)
	li	a0, 48
	sb	a0, -66(s0)
	li	a0, 98
	sb	a0, -65(s0)
	lw	a0, -16(s0)
	addi	a0, a0, -1
	sw	a0, -72(s0)
	j	.LBB8_4
.LBB8_4:
	lw	a0, -72(s0)
	li	a1, 0
	blt	a0, a1, .LBB8_10
	j	.LBB8_5
.LBB8_5:
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a1, a0, a1
	andi	a1, a1, -2
	sub	a0, a0, a1
	li	a1, 0
	bne	a0, a1, .LBB8_7
	j	.LBB8_6
.LBB8_6:
	lw	a0, -92(s0)
	lw	a1, -72(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB8_8
.LBB8_7:
	lw	a0, -92(s0)
	lw	a1, -72(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB8_8
.LBB8_8:
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -12(s0)
	j	.LBB8_9
.LBB8_9:
	lw	a0, -72(s0)
	addi	a0, a0, -1
	sw	a0, -72(s0)
	j	.LBB8_4
.LBB8_10:
	lw	a0, -16(s0)
	addi	a0, a0, -1
	sw	a0, -76(s0)
	j	.LBB8_11
.LBB8_11:
	lw	a0, -20(s0)
	li	a1, 0
	bne	a0, a1, .LBB8_16
	j	.LBB8_12
.LBB8_12:
	lw	a0, -92(s0)
	lw	a1, -76(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB8_14
	j	.LBB8_13
.LBB8_13:
	lw	a0, -92(s0)
	lw	a1, -76(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB8_15
.LBB8_14:
	lw	a0, -92(s0)
	lw	a1, -76(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB8_15
.LBB8_15:
	lw	a0, -76(s0)
	addi	a0, a0, -1
	sw	a0, -76(s0)
	j	.LBB8_11
.LBB8_16:
	li	a0, 0
	sw	a0, -80(s0)
	j	.LBB8_17
.LBB8_17:
	lw	a0, -80(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB8_23
	j	.LBB8_18
.LBB8_18:
	lw	a0, -92(s0)
	lw	a1, -80(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB8_20
	j	.LBB8_19
.LBB8_19:
	lw	a0, -92(s0)
	lw	a1, -80(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB8_21
.LBB8_20:
	lw	a0, -92(s0)
	lw	a1, -80(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB8_21
.LBB8_21:
	j	.LBB8_22
.LBB8_22:
	lw	a0, -80(s0)
	addi	a0, a0, 1
	sw	a0, -80(s0)
	j	.LBB8_17
.LBB8_23:
	li	a0, 2
	sw	a0, -84(s0)
	j	.LBB8_24
.LBB8_24:
	lw	a0, -84(s0)
	lw	a2, -16(s0)
	li	a1, 34
	sub	a1, a1, a2
	bge	a0, a1, .LBB8_27
	j	.LBB8_25
.LBB8_25:
	lw	a1, -84(s0)
	addi	a0, s0, -66
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB8_26
.LBB8_26:
	lw	a0, -84(s0)
	addi	a0, a0, 1
	sw	a0, -84(s0)
	j	.LBB8_24
.LBB8_27:
	lw	a1, -16(s0)
	li	a0, 34
	sub	a0, a0, a1
	sw	a0, -88(s0)
	j	.LBB8_28
.LBB8_28:
	lw	a1, -88(s0)
	li	a0, 33
	blt	a0, a1, .LBB8_31
	j	.LBB8_29
.LBB8_29:
	lw	a1, -92(s0)
	lw	a2, -88(s0)
	lw	a0, -16(s0)
	add	a0, a2, a0
	add	a0, a0, a1
	lb	a0, -34(a0)
	addi	a1, s0, -66
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB8_30
.LBB8_30:
	lw	a0, -88(s0)
	addi	a0, a0, 1
	sw	a0, -88(s0)
	j	.LBB8_28
.LBB8_31:
	li	a0, 1
	addi	a1, s0, -66
	li	a2, 34
	call	write
	lw	a0, -28(s0)
	mv	sp, a0
	addi	sp, s0, -96
	lw	ra, 92(sp)
	lw	s0, 88(sp)
	addi	sp, sp, 96
	ret
.Lfunc_end8:
	.size	converte_dec_bin2, .Lfunc_end8-converte_dec_bin2

	.globl	soma_um_bin
	.p2align	2
	.type	soma_um_bin,@function
soma_um_bin:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -16(s0)
	addi	a0, a0, -1
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB9_1
.LBB9_1:
	lw	a0, -24(s0)
	li	a1, 0
	bne	a0, a1, .LBB9_6
	j	.LBB9_2
.LBB9_2:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB9_4
	j	.LBB9_3
.LBB9_3:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -24(s0)
	j	.LBB9_5
.LBB9_4:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB9_5
.LBB9_5:
	lw	a0, -20(s0)
	addi	a0, a0, -1
	sw	a0, -20(s0)
	j	.LBB9_1
.LBB9_6:
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	call	polinomio_bin
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	soma_um_bin, .Lfunc_end9-soma_um_bin

	.globl	converte_bin_dec
	.p2align	2
	.type	converte_bin_dec,@function
converte_bin_dec:
	addi	sp, sp, -64
	sw	ra, 60(sp)
	sw	s0, 56(sp)
	addi	s0, sp, 64
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	sw	a0, -28(s0)
	j	.LBB10_1
.LBB10_1:
	lw	a0, -28(s0)
	li	a1, 0
	beq	a0, a1, .LBB10_3
	j	.LBB10_2
.LBB10_2:
	lw	a0, -28(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB10_1
.LBB10_3:
	lw	a0, -24(s0)
	mv	a1, sp
	sw	a1, -32(s0)
	addi	a1, a0, 15
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -56(s0)
	mv	sp, a1
	sw	a0, -36(s0)
	lw	a0, -24(s0)
	addi	a0, a0, -1
	sw	a0, -40(s0)
	j	.LBB10_4
.LBB10_4:
	lw	a0, -40(s0)
	li	a1, 0
	blt	a0, a1, .LBB10_10
	j	.LBB10_5
.LBB10_5:
	lw	a0, -20(s0)
	srli	a1, a0, 31
	add	a1, a0, a1
	andi	a1, a1, -2
	sub	a0, a0, a1
	li	a1, 0
	bne	a0, a1, .LBB10_7
	j	.LBB10_6
.LBB10_6:
	lw	a0, -56(s0)
	lw	a1, -40(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB10_8
.LBB10_7:
	lw	a0, -56(s0)
	lw	a1, -40(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB10_8
.LBB10_8:
	lw	a0, -20(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB10_9
.LBB10_9:
	lw	a0, -40(s0)
	addi	a0, a0, -1
	sw	a0, -40(s0)
	j	.LBB10_4
.LBB10_10:
	lw	a0, -56(s0)
	lw	a1, -24(s0)
	addi	a2, a1, 15
	andi	a3, a2, -16
	mv	a2, sp
	sub	a2, a2, a3
	sw	a2, -60(s0)
	mv	sp, a2
	sw	a1, -44(s0)
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB10_20
	j	.LBB10_11
.LBB10_11:
	lw	a0, -24(s0)
	li	a1, 32
	bne	a0, a1, .LBB10_20
	j	.LBB10_12
.LBB10_12:
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB10_13
.LBB10_13:
	lw	a0, -48(s0)
	lw	a1, -24(s0)
	bge	a0, a1, .LBB10_19
	j	.LBB10_14
.LBB10_14:
	lw	a0, -56(s0)
	lw	a1, -48(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB10_16
	j	.LBB10_15
.LBB10_15:
	lw	a0, -60(s0)
	lw	a1, -48(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB10_17
.LBB10_16:
	lw	a0, -60(s0)
	lw	a1, -48(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB10_17
.LBB10_17:
	j	.LBB10_18
.LBB10_18:
	lw	a0, -48(s0)
	addi	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB10_13
.LBB10_19:
	lw	a0, -60(s0)
	lw	a1, -24(s0)
	call	soma_um_bin
	sw	a0, -20(s0)
	lw	a1, -20(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -12(s0)
	li	a0, 1
	sw	a0, -52(s0)
	j	.LBB10_21
.LBB10_20:
	lw	a0, -56(s0)
	lw	a1, -24(s0)
	call	polinomio_bin
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	sw	a0, -12(s0)
	li	a0, 1
	sw	a0, -52(s0)
	j	.LBB10_21
.LBB10_21:
	lw	a0, -32(s0)
	mv	sp, a0
	lw	a0, -12(s0)
	addi	sp, s0, -64
	lw	ra, 60(sp)
	lw	s0, 56(sp)
	addi	sp, sp, 64
	ret
.Lfunc_end10:
	.size	converte_bin_dec, .Lfunc_end10-converte_bin_dec

	.globl	converte_bin_dec2
	.p2align	2
	.type	converte_bin_dec2,@function
converte_bin_dec2:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	lw	a0, -20(s0)
	mv	a1, sp
	sw	a1, -28(s0)
	addi	a1, a0, 15
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -44(s0)
	mv	sp, a1
	sw	a0, -32(s0)
	lw	a0, -16(s0)
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB11_10
	j	.LBB11_1
.LBB11_1:
	lw	a0, -20(s0)
	li	a1, 32
	bne	a0, a1, .LBB11_10
	j	.LBB11_2
.LBB11_2:
	li	a0, 0
	sw	a0, -36(s0)
	j	.LBB11_3
.LBB11_3:
	lw	a0, -36(s0)
	lw	a1, -20(s0)
	bge	a0, a1, .LBB11_9
	j	.LBB11_4
.LBB11_4:
	lw	a0, -16(s0)
	lw	a1, -36(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB11_6
	j	.LBB11_5
.LBB11_5:
	lw	a0, -44(s0)
	lw	a1, -36(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB11_7
.LBB11_6:
	lw	a0, -44(s0)
	lw	a1, -36(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB11_7
.LBB11_7:
	j	.LBB11_8
.LBB11_8:
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB11_3
.LBB11_9:
	lw	a0, -44(s0)
	lw	a1, -20(s0)
	call	soma_um_bin
	sw	a0, -24(s0)
	lw	a1, -24(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -12(s0)
	li	a0, 1
	sw	a0, -40(s0)
	j	.LBB11_11
.LBB11_10:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	call	polinomio_bin
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	li	a0, 1
	sw	a0, -40(s0)
	j	.LBB11_11
.LBB11_11:
	lw	a0, -28(s0)
	mv	sp, a0
	lw	a0, -12(s0)
	addi	sp, s0, -48
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end11:
	.size	converte_bin_dec2, .Lfunc_end11-converte_bin_dec2

	.globl	converte_hex_bin
	.p2align	2
	.type	converte_hex_bin,@function
converte_hex_bin:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lui	a0, 419414
	addi	a0, a0, 1123
	sw	a0, -20(s0)
	lui	a0, 402964
	addi	a0, a0, -1736
	sw	a0, -24(s0)
	lui	a0, 226147
	addi	a0, a0, 1332
	sw	a0, -28(s0)
	lui	a0, 209699
	addi	a0, a0, 304
	sw	a0, -32(s0)
	li	a0, 0
	sw	a0, -36(s0)
	sw	a0, -40(s0)
	j	.LBB12_1
.LBB12_1:
	lw	a0, -40(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB12_10
	j	.LBB12_2
.LBB12_2:
	li	a0, 0
	sw	a0, -44(s0)
	j	.LBB12_3
.LBB12_3:
	lw	a1, -44(s0)
	li	a0, 15
	blt	a0, a1, .LBB12_8
	j	.LBB12_4
.LBB12_4:
	lw	a0, -12(s0)
	lw	a1, -40(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -44(s0)
	addi	a1, s0, -32
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bne	a0, a1, .LBB12_6
	j	.LBB12_5
.LBB12_5:
	lw	a0, -44(s0)
	sw	a0, -48(s0)
	lw	a1, -16(s0)
	lw	a0, -40(s0)
	not	a0, a0
	add	a1, a0, a1
	li	a0, 16
	call	potencia
	mv	a1, a0
	lw	a0, -48(s0)
	mul	a1, a0, a1
	lw	a0, -36(s0)
	add	a0, a0, a1
	sw	a0, -36(s0)
	j	.LBB12_6
.LBB12_6:
	j	.LBB12_7
.LBB12_7:
	lw	a0, -44(s0)
	addi	a0, a0, 1
	sw	a0, -44(s0)
	j	.LBB12_3
.LBB12_8:
	j	.LBB12_9
.LBB12_9:
	lw	a0, -40(s0)
	addi	a0, a0, 1
	sw	a0, -40(s0)
	j	.LBB12_1
.LBB12_10:
	lw	a0, -36(s0)
	call	converte_dec_bin
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end12:
	.size	converte_hex_bin, .Lfunc_end12-converte_hex_bin

	.globl	converter_hex_dec
	.p2align	2
	.type	converter_hex_dec,@function
converter_hex_dec:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lui	a0, 419414
	addi	a0, a0, 1123
	sw	a0, -20(s0)
	lui	a0, 402964
	addi	a0, a0, -1736
	sw	a0, -24(s0)
	lui	a0, 226147
	addi	a0, a0, 1332
	sw	a0, -28(s0)
	lui	a0, 209699
	addi	a0, a0, 304
	sw	a0, -32(s0)
	li	a0, 0
	sw	a0, -36(s0)
	sw	a0, -40(s0)
	j	.LBB13_1
.LBB13_1:
	lw	a0, -40(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB13_10
	j	.LBB13_2
.LBB13_2:
	li	a0, 0
	sw	a0, -44(s0)
	j	.LBB13_3
.LBB13_3:
	lw	a1, -44(s0)
	li	a0, 15
	blt	a0, a1, .LBB13_8
	j	.LBB13_4
.LBB13_4:
	lw	a0, -12(s0)
	lw	a1, -40(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -44(s0)
	addi	a1, s0, -32
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bne	a0, a1, .LBB13_6
	j	.LBB13_5
.LBB13_5:
	lw	a0, -44(s0)
	sw	a0, -48(s0)
	lw	a1, -16(s0)
	lw	a0, -40(s0)
	not	a0, a0
	add	a1, a0, a1
	li	a0, 16
	call	potencia
	mv	a1, a0
	lw	a0, -48(s0)
	mul	a1, a0, a1
	lw	a0, -36(s0)
	add	a0, a0, a1
	sw	a0, -36(s0)
	j	.LBB13_6
.LBB13_6:
	j	.LBB13_7
.LBB13_7:
	lw	a0, -44(s0)
	addi	a0, a0, 1
	sw	a0, -44(s0)
	j	.LBB13_3
.LBB13_8:
	j	.LBB13_9
.LBB13_9:
	lw	a0, -40(s0)
	addi	a0, a0, 1
	sw	a0, -40(s0)
	j	.LBB13_1
.LBB13_10:
	lw	a0, -36(s0)
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end13:
	.size	converter_hex_dec, .Lfunc_end13-converter_hex_dec

	.globl	converter_dec_hex
	.p2align	2
	.type	converter_dec_hex,@function
converter_dec_hex:
	addi	sp, sp, -64
	sw	ra, 60(sp)
	sw	s0, 56(sp)
	addi	s0, sp, 64
	sw	a0, -12(s0)
	lui	a0, 419414
	addi	a0, a0, 1123
	sw	a0, -16(s0)
	lui	a0, 402964
	addi	a0, a0, -1736
	sw	a0, -20(s0)
	lui	a0, 226147
	addi	a0, a0, 1332
	sw	a0, -24(s0)
	lui	a0, 209699
	addi	a0, a0, 304
	sw	a0, -28(s0)
	lw	a0, -12(s0)
	sw	a0, -32(s0)
	li	a0, 0
	sw	a0, -36(s0)
	j	.LBB14_1
.LBB14_1:
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB14_3
	j	.LBB14_2
.LBB14_2:
	lw	a0, -32(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -32(s0)
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB14_1
.LBB14_3:
	lw	a1, -36(s0)
	addi	a0, a1, 2
	mv	a2, sp
	sw	a2, -40(s0)
	addi	a1, a1, 17
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -56(s0)
	mv	sp, a1
	sw	a0, -44(s0)
	li	a0, 48
	sb	a0, 0(a1)
	li	a0, 120
	sb	a0, 1(a1)
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB14_4
.LBB14_4:
	lw	a0, -48(s0)
	li	a1, 2
	blt	a0, a1, .LBB14_13
	j	.LBB14_5
.LBB14_5:
	li	a0, 0
	sw	a0, -52(s0)
	j	.LBB14_6
.LBB14_6:
	lw	a1, -52(s0)
	li	a0, 15
	blt	a0, a1, .LBB14_11
	j	.LBB14_7
.LBB14_7:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a1, a0, a1
	andi	a1, a1, -16
	sub	a0, a0, a1
	lw	a1, -52(s0)
	bne	a0, a1, .LBB14_9
	j	.LBB14_8
.LBB14_8:
	lw	a1, -56(s0)
	lw	a2, -52(s0)
	addi	a0, s0, -28
	add	a0, a0, a2
	lb	a0, 0(a0)
	lw	a2, -48(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB14_9
.LBB14_9:
	j	.LBB14_10
.LBB14_10:
	lw	a0, -52(s0)
	addi	a0, a0, 1
	sw	a0, -52(s0)
	j	.LBB14_6
.LBB14_11:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -12(s0)
	j	.LBB14_12
.LBB14_12:
	lw	a0, -48(s0)
	addi	a0, a0, -1
	sw	a0, -48(s0)
	j	.LBB14_4
.LBB14_13:
	lw	a1, -56(s0)
	lw	a0, -36(s0)
	addi	a2, a0, 2
	li	a0, 1
	call	write
	lw	a0, -40(s0)
	mv	sp, a0
	addi	sp, s0, -64
	lw	ra, 60(sp)
	lw	s0, 56(sp)
	addi	sp, sp, 64
	ret
.Lfunc_end14:
	.size	converter_dec_hex, .Lfunc_end14-converter_dec_hex

	.globl	converter_dec_hex2
	.p2align	2
	.type	converter_dec_hex2,@function
converter_dec_hex2:
	addi	sp, sp, -96
	sw	ra, 92(sp)
	sw	s0, 88(sp)
	addi	s0, sp, 96
	sw	a0, -12(s0)
	lui	a0, 419414
	addi	a0, a0, 1123
	sw	a0, -16(s0)
	lui	a0, 402964
	addi	a0, a0, -1736
	sw	a0, -20(s0)
	lui	a0, 226147
	addi	a0, a0, 1332
	sw	a0, -24(s0)
	lui	a0, 209699
	addi	a0, a0, 304
	sw	a0, -28(s0)
	lw	a0, -12(s0)
	sw	a0, -32(s0)
	li	a0, 0
	sw	a0, -36(s0)
	sw	a0, -40(s0)
	j	.LBB15_1
.LBB15_1:
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB15_3
	j	.LBB15_2
.LBB15_2:
	lw	a0, -32(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -32(s0)
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB15_1
.LBB15_3:
	lw	a0, -36(s0)
	mv	a1, sp
	sw	a1, -44(s0)
	addi	a1, a0, 15
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -84(s0)
	mv	sp, a1
	sw	a0, -48(s0)
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -52(s0)
	j	.LBB15_4
.LBB15_4:
	lw	a0, -52(s0)
	li	a1, 0
	blt	a0, a1, .LBB15_13
	j	.LBB15_5
.LBB15_5:
	li	a0, 0
	sw	a0, -56(s0)
	j	.LBB15_6
.LBB15_6:
	lw	a1, -56(s0)
	li	a0, 15
	blt	a0, a1, .LBB15_11
	j	.LBB15_7
.LBB15_7:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a1, a0, a1
	andi	a1, a1, -16
	sub	a0, a0, a1
	lw	a1, -56(s0)
	bne	a0, a1, .LBB15_9
	j	.LBB15_8
.LBB15_8:
	lw	a1, -84(s0)
	lw	a2, -56(s0)
	addi	a0, s0, -28
	add	a0, a0, a2
	lb	a0, 0(a0)
	lw	a2, -52(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB15_9
.LBB15_9:
	j	.LBB15_10
.LBB15_10:
	lw	a0, -56(s0)
	addi	a0, a0, 1
	sw	a0, -56(s0)
	j	.LBB15_6
.LBB15_11:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -12(s0)
	j	.LBB15_12
.LBB15_12:
	lw	a0, -52(s0)
	addi	a0, a0, -1
	sw	a0, -52(s0)
	j	.LBB15_4
.LBB15_13:
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -60(s0)
	li	a0, 0
	sw	a0, -64(s0)
	sw	a0, -68(s0)
	j	.LBB15_14
.LBB15_14:
	lw	a0, -40(s0)
	li	a1, 0
	bne	a0, a1, .LBB15_24
	j	.LBB15_15
.LBB15_15:
	li	a0, 0
	sw	a0, -64(s0)
	sw	a0, -68(s0)
	j	.LBB15_16
.LBB15_16:
	lw	a0, -68(s0)
	li	a1, 0
	bne	a0, a1, .LBB15_23
	j	.LBB15_17
.LBB15_17:
	lw	a0, -84(s0)
	lw	a1, -60(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB15_19
	j	.LBB15_18
.LBB15_18:
	lw	a0, -84(s0)
	lw	a1, -60(s0)
	add	a1, a0, a1
	li	a0, 102
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -68(s0)
	j	.LBB15_22
.LBB15_19:
	lw	a0, -84(s0)
	lw	a1, -60(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -64(s0)
	addi	a1, s0, -28
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bne	a0, a1, .LBB15_21
	j	.LBB15_20
.LBB15_20:
	lw	a1, -84(s0)
	lw	a0, -64(s0)
	addi	a2, s0, -28
	add	a0, a0, a2
	lb	a0, -1(a0)
	lw	a2, -60(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -68(s0)
	sw	a0, -40(s0)
	j	.LBB15_21
.LBB15_21:
	j	.LBB15_22
.LBB15_22:
	lw	a0, -64(s0)
	addi	a0, a0, 1
	sw	a0, -64(s0)
	j	.LBB15_16
.LBB15_23:
	lw	a0, -60(s0)
	addi	a0, a0, -1
	sw	a0, -60(s0)
	j	.LBB15_14
.LBB15_24:
	li	a0, 0
	sw	a0, -60(s0)
	j	.LBB15_25
.LBB15_25:
	lw	a0, -60(s0)
	lw	a1, -36(s0)
	bge	a0, a1, .LBB15_33
	j	.LBB15_26
.LBB15_26:
	li	a0, 0
	sw	a0, -64(s0)
	sw	a0, -68(s0)
	j	.LBB15_27
.LBB15_27:
	lw	a0, -68(s0)
	li	a1, 0
	bne	a0, a1, .LBB15_31
	j	.LBB15_28
.LBB15_28:
	lw	a0, -84(s0)
	lw	a1, -60(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -64(s0)
	addi	a1, s0, -28
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bne	a0, a1, .LBB15_30
	j	.LBB15_29
.LBB15_29:
	lw	a1, -84(s0)
	lw	a2, -64(s0)
	addi	a0, s0, -28
	sub	a0, a0, a2
	lb	a0, 15(a0)
	lw	a2, -60(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -68(s0)
	j	.LBB15_30
.LBB15_30:
	lw	a0, -64(s0)
	addi	a0, a0, 1
	sw	a0, -64(s0)
	j	.LBB15_27
.LBB15_31:
	j	.LBB15_32
.LBB15_32:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB15_25
.LBB15_33:
	li	a0, 48
	sb	a0, -78(s0)
	li	a0, 120
	sb	a0, -77(s0)
	li	a0, 2
	sw	a0, -60(s0)
	j	.LBB15_34
.LBB15_34:
	lw	a0, -60(s0)
	lw	a2, -36(s0)
	li	a1, 10
	sub	a1, a1, a2
	bge	a0, a1, .LBB15_37
	j	.LBB15_35
.LBB15_35:
	lw	a1, -60(s0)
	addi	a0, s0, -78
	add	a1, a0, a1
	li	a0, 102
	sb	a0, 0(a1)
	j	.LBB15_36
.LBB15_36:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB15_34
.LBB15_37:
	lw	a1, -36(s0)
	li	a0, 10
	sub	a0, a0, a1
	sw	a0, -60(s0)
	j	.LBB15_38
.LBB15_38:
	lw	a1, -60(s0)
	li	a0, 9
	blt	a0, a1, .LBB15_41
	j	.LBB15_39
.LBB15_39:
	lw	a1, -84(s0)
	lw	a2, -60(s0)
	lw	a0, -36(s0)
	add	a0, a2, a0
	add	a0, a0, a1
	lb	a0, -10(a0)
	addi	a1, s0, -78
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB15_40
.LBB15_40:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB15_38
.LBB15_41:
	li	a0, 1
	addi	a1, s0, -78
	li	a2, 10
	call	write
	lw	a0, -44(s0)
	mv	sp, a0
	addi	sp, s0, -96
	lw	ra, 92(sp)
	lw	s0, 88(sp)
	addi	sp, sp, 96
	ret
.Lfunc_end15:
	.size	converter_dec_hex2, .Lfunc_end15-converter_dec_hex2

	.globl	converte_int_char
	.p2align	2
	.type	converte_int_char,@function
converte_int_char:
	addi	sp, sp, -80
	sw	ra, 76(sp)
	sw	s0, 72(sp)
	addi	s0, sp, 80
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	sw	a0, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB16_1
.LBB16_1:
	lw	a0, -16(s0)
	li	a1, 0
	beq	a0, a1, .LBB16_3
	j	.LBB16_2
.LBB16_2:
	lw	a0, -16(s0)
	lui	a1, 419430
	addi	a1, a1, 1639
	mulh	a0, a0, a1
	srli	a1, a0, 31
	srai	a0, a0, 2
	add	a0, a0, a1
	sw	a0, -16(s0)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB16_1
.LBB16_3:
	lw	a0, -12(s0)
	li	a1, 0
	bge	a0, a1, .LBB16_9
	j	.LBB16_4
.LBB16_4:
	lw	a1, -20(s0)
	addi	a0, a1, 1
	mv	a2, sp
	sw	a2, -24(s0)
	addi	a1, a1, 16
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -48(s0)
	mv	sp, a1
	sw	a0, -28(s0)
	li	a0, 45
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -32(s0)
	j	.LBB16_5
.LBB16_5:
	lw	a0, -32(s0)
	lw	a1, -20(s0)
	bge	a0, a1, .LBB16_8
	j	.LBB16_6
.LBB16_6:
	lw	a0, -12(s0)
	sw	a0, -56(s0)
	lw	a1, -20(s0)
	lw	a0, -32(s0)
	not	a0, a0
	add	a1, a0, a1
	li	a0, 10
	sw	a0, -52(s0)
	call	potencia
	lw	a1, -56(s0)
	lw	a2, -48(s0)
	mv	a3, a0
	lw	a0, -52(s0)
	div	a1, a1, a3
	addi	a1, a1, 48
	lw	a3, -32(s0)
	add	a2, a2, a3
	sb	a1, 0(a2)
	lw	a2, -20(s0)
	lw	a1, -32(s0)
	not	a1, a1
	add	a1, a1, a2
	call	potencia
	mv	a1, a0
	lw	a0, -12(s0)
	rem	a0, a0, a1
	sw	a0, -12(s0)
	j	.LBB16_7
.LBB16_7:
	lw	a0, -32(s0)
	addi	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB16_5
.LBB16_8:
	lw	a1, -48(s0)
	lw	a0, -20(s0)
	addi	a2, a0, 1
	li	a0, 1
	call	write
	lw	a0, -24(s0)
	mv	sp, a0
	j	.LBB16_14
.LBB16_9:
	lw	a0, -20(s0)
	mv	a1, sp
	sw	a1, -36(s0)
	addi	a1, a0, 15
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -60(s0)
	mv	sp, a1
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -44(s0)
	j	.LBB16_10
.LBB16_10:
	lw	a0, -44(s0)
	lw	a1, -20(s0)
	bge	a0, a1, .LBB16_13
	j	.LBB16_11
.LBB16_11:
	lw	a0, -12(s0)
	sw	a0, -68(s0)
	lw	a1, -20(s0)
	lw	a0, -44(s0)
	not	a0, a0
	add	a1, a0, a1
	li	a0, 10
	sw	a0, -64(s0)
	call	potencia
	lw	a1, -68(s0)
	lw	a2, -60(s0)
	mv	a3, a0
	lw	a0, -64(s0)
	div	a1, a1, a3
	addi	a1, a1, 48
	lw	a3, -44(s0)
	add	a2, a2, a3
	sb	a1, 0(a2)
	lw	a2, -20(s0)
	lw	a1, -44(s0)
	not	a1, a1
	add	a1, a1, a2
	call	potencia
	mv	a1, a0
	lw	a0, -12(s0)
	rem	a0, a0, a1
	sw	a0, -12(s0)
	j	.LBB16_12
.LBB16_12:
	lw	a0, -44(s0)
	addi	a0, a0, 1
	sw	a0, -44(s0)
	j	.LBB16_10
.LBB16_13:
	lw	a1, -60(s0)
	lw	a2, -20(s0)
	li	a0, 1
	call	write
	lw	a0, -36(s0)
	mv	sp, a0
	j	.LBB16_14
.LBB16_14:
	addi	sp, s0, -80
	lw	ra, 76(sp)
	lw	s0, 72(sp)
	addi	sp, sp, 80
	ret
.Lfunc_end16:
	.size	converte_int_char, .Lfunc_end16-converte_int_char

	.globl	converte_dec_hex_en
	.p2align	2
	.type	converte_dec_hex_en,@function
converte_dec_hex_en:
	addi	sp, sp, -80
	sw	ra, 76(sp)
	sw	s0, 72(sp)
	addi	s0, sp, 80
	sw	a0, -12(s0)
	lui	a0, 419414
	addi	a0, a0, 1123
	sw	a0, -16(s0)
	lui	a0, 402964
	addi	a0, a0, -1736
	sw	a0, -20(s0)
	lui	a0, 226147
	addi	a0, a0, 1332
	sw	a0, -24(s0)
	lui	a0, 209699
	addi	a0, a0, 304
	sw	a0, -28(s0)
	lw	a0, -12(s0)
	sw	a0, -32(s0)
	li	a0, 0
	sw	a0, -36(s0)
	j	.LBB17_1
.LBB17_1:
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB17_3
	j	.LBB17_2
.LBB17_2:
	lw	a0, -32(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -32(s0)
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB17_1
.LBB17_3:
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB17_4
.LBB17_4:
	lw	a0, -48(s0)
	lw	a2, -36(s0)
	li	a1, 8
	sub	a1, a1, a2
	bge	a0, a1, .LBB17_7
	j	.LBB17_5
.LBB17_5:
	lw	a1, -48(s0)
	addi	a0, s0, -44
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB17_6
.LBB17_6:
	lw	a0, -48(s0)
	addi	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB17_4
.LBB17_7:
	li	a0, 7
	sw	a0, -52(s0)
	j	.LBB17_8
.LBB17_8:
	lw	a0, -52(s0)
	lw	a2, -36(s0)
	li	a1, 8
	sub	a1, a1, a2
	blt	a0, a1, .LBB17_17
	j	.LBB17_9
.LBB17_9:
	li	a0, 0
	sw	a0, -56(s0)
	j	.LBB17_10
.LBB17_10:
	lw	a1, -56(s0)
	li	a0, 15
	blt	a0, a1, .LBB17_15
	j	.LBB17_11
.LBB17_11:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a1, a0, a1
	andi	a1, a1, -16
	sub	a0, a0, a1
	lw	a1, -56(s0)
	bne	a0, a1, .LBB17_13
	j	.LBB17_12
.LBB17_12:
	lw	a1, -56(s0)
	addi	a0, s0, -28
	add	a0, a0, a1
	lb	a0, 0(a0)
	lw	a2, -52(s0)
	addi	a1, s0, -44
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB17_13
.LBB17_13:
	j	.LBB17_14
.LBB17_14:
	lw	a0, -56(s0)
	addi	a0, a0, 1
	sw	a0, -56(s0)
	j	.LBB17_10
.LBB17_15:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -12(s0)
	j	.LBB17_16
.LBB17_16:
	lw	a0, -52(s0)
	addi	a0, a0, -1
	sw	a0, -52(s0)
	j	.LBB17_8
.LBB17_17:
	li	a0, 0
	sw	a0, -68(s0)
	j	.LBB17_18
.LBB17_18:
	lw	a1, -68(s0)
	li	a0, 6
	blt	a0, a1, .LBB17_21
	j	.LBB17_19
.LBB17_19:
	lw	a3, -68(s0)
	addi	a0, s0, -44
	sub	a1, a0, a3
	lb	a1, 6(a1)
	addi	a2, s0, -64
	add	a3, a2, a3
	sb	a1, 0(a3)
	lw	a1, -68(s0)
	sub	a0, a0, a1
	lb	a0, 7(a0)
	add	a1, a1, a2
	sb	a0, 1(a1)
	j	.LBB17_20
.LBB17_20:
	lw	a0, -68(s0)
	addi	a0, a0, 2
	sw	a0, -68(s0)
	j	.LBB17_18
.LBB17_21:
	addi	a0, s0, -64
	li	a1, 8
	call	converter_hex_dec
	sw	a0, -72(s0)
	lw	a0, -72(s0)
	call	converte_int_char
	lw	ra, 76(sp)
	lw	s0, 72(sp)
	addi	sp, sp, 80
	ret
.Lfunc_end17:
	.size	converte_dec_hex_en, .Lfunc_end17-converte_dec_hex_en

	.globl	converter_hex_hex_en
	.p2align	2
	.type	converter_hex_hex_en,@function
converter_hex_hex_en:
	addi	sp, sp, -64
	sw	ra, 60(sp)
	sw	s0, 56(sp)
	addi	s0, sp, 64
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a1, -16(s0)
	addi	a0, a1, -2
	mv	a2, sp
	sw	a2, -20(s0)
	addi	a1, a1, 13
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -64(s0)
	mv	sp, a1
	sw	a0, -24(s0)
	li	a0, 2
	sw	a0, -28(s0)
	j	.LBB18_1
.LBB18_1:
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB18_4
	j	.LBB18_2
.LBB18_2:
	lw	a2, -64(s0)
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lb	a0, 0(a0)
	add	a1, a1, a2
	sb	a0, -2(a1)
	j	.LBB18_3
.LBB18_3:
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB18_1
.LBB18_4:
	lw	a0, -16(s0)
	addi	a0, a0, -2
	sw	a0, -16(s0)
	li	a0, 0
	sw	a0, -40(s0)
	j	.LBB18_5
.LBB18_5:
	lw	a0, -40(s0)
	lw	a2, -16(s0)
	li	a1, 8
	sub	a1, a1, a2
	bge	a0, a1, .LBB18_8
	j	.LBB18_6
.LBB18_6:
	lw	a1, -40(s0)
	addi	a0, s0, -36
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB18_7
.LBB18_7:
	lw	a0, -40(s0)
	addi	a0, a0, 1
	sw	a0, -40(s0)
	j	.LBB18_5
.LBB18_8:
	lw	a1, -16(s0)
	li	a0, 8
	sub	a0, a0, a1
	sw	a0, -44(s0)
	j	.LBB18_9
.LBB18_9:
	lw	a1, -44(s0)
	li	a0, 7
	blt	a0, a1, .LBB18_12
	j	.LBB18_10
.LBB18_10:
	lw	a1, -64(s0)
	lw	a2, -44(s0)
	lw	a0, -16(s0)
	add	a0, a2, a0
	add	a0, a0, a1
	lb	a0, -8(a0)
	addi	a1, s0, -36
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB18_11
.LBB18_11:
	lw	a0, -44(s0)
	addi	a0, a0, 1
	sw	a0, -44(s0)
	j	.LBB18_9
.LBB18_12:
	li	a0, 0
	sw	a0, -56(s0)
	j	.LBB18_13
.LBB18_13:
	lw	a1, -56(s0)
	li	a0, 6
	blt	a0, a1, .LBB18_16
	j	.LBB18_14
.LBB18_14:
	lw	a3, -56(s0)
	addi	a0, s0, -36
	sub	a1, a0, a3
	lb	a1, 6(a1)
	addi	a2, s0, -52
	add	a3, a2, a3
	sb	a1, 0(a3)
	lw	a1, -56(s0)
	sub	a0, a0, a1
	lb	a0, 7(a0)
	add	a1, a1, a2
	sb	a0, 1(a1)
	j	.LBB18_15
.LBB18_15:
	lw	a0, -56(s0)
	addi	a0, a0, 2
	sw	a0, -56(s0)
	j	.LBB18_13
.LBB18_16:
	addi	a0, s0, -52
	li	a1, 8
	call	converter_hex_dec
	sw	a0, -60(s0)
	lw	a0, -60(s0)
	call	converte_int_char
	lw	a0, -20(s0)
	mv	sp, a0
	addi	sp, s0, -64
	lw	ra, 60(sp)
	lw	s0, 56(sp)
	addi	sp, sp, 64
	ret
.Lfunc_end18:
	.size	converter_hex_hex_en, .Lfunc_end18-converter_hex_hex_en

	.globl	converter_neg_hex_en
	.p2align	2
	.type	converter_neg_hex_en,@function
converter_neg_hex_en:
	addi	sp, sp, -128
	sw	ra, 124(sp)
	sw	s0, 120(sp)
	addi	s0, sp, 128
	sw	a0, -12(s0)
	lui	a0, 419414
	addi	a0, a0, 1123
	sw	a0, -16(s0)
	lui	a0, 402964
	addi	a0, a0, -1736
	sw	a0, -20(s0)
	lui	a0, 226147
	addi	a0, a0, 1332
	sw	a0, -24(s0)
	lui	a0, 209699
	addi	a0, a0, 304
	sw	a0, -28(s0)
	lw	a0, -12(s0)
	sw	a0, -32(s0)
	li	a0, 0
	sw	a0, -36(s0)
	sw	a0, -40(s0)
	j	.LBB19_1
.LBB19_1:
	lw	a0, -32(s0)
	li	a1, 0
	beq	a0, a1, .LBB19_3
	j	.LBB19_2
.LBB19_2:
	lw	a0, -32(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -32(s0)
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB19_1
.LBB19_3:
	lw	a0, -36(s0)
	mv	a1, sp
	sw	a1, -44(s0)
	addi	a1, a0, 15
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -108(s0)
	mv	sp, a1
	sw	a0, -48(s0)
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -52(s0)
	j	.LBB19_4
.LBB19_4:
	lw	a0, -52(s0)
	li	a1, 0
	blt	a0, a1, .LBB19_13
	j	.LBB19_5
.LBB19_5:
	li	a0, 0
	sw	a0, -56(s0)
	j	.LBB19_6
.LBB19_6:
	lw	a1, -56(s0)
	li	a0, 15
	blt	a0, a1, .LBB19_11
	j	.LBB19_7
.LBB19_7:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a1, a0, a1
	andi	a1, a1, -16
	sub	a0, a0, a1
	lw	a1, -56(s0)
	bne	a0, a1, .LBB19_9
	j	.LBB19_8
.LBB19_8:
	lw	a1, -108(s0)
	lw	a2, -56(s0)
	addi	a0, s0, -28
	add	a0, a0, a2
	lb	a0, 0(a0)
	lw	a2, -52(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB19_9
.LBB19_9:
	j	.LBB19_10
.LBB19_10:
	lw	a0, -56(s0)
	addi	a0, a0, 1
	sw	a0, -56(s0)
	j	.LBB19_6
.LBB19_11:
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -12(s0)
	j	.LBB19_12
.LBB19_12:
	lw	a0, -52(s0)
	addi	a0, a0, -1
	sw	a0, -52(s0)
	j	.LBB19_4
.LBB19_13:
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -60(s0)
	li	a0, 0
	sw	a0, -64(s0)
	sw	a0, -68(s0)
	j	.LBB19_14
.LBB19_14:
	lw	a0, -40(s0)
	li	a1, 0
	bne	a0, a1, .LBB19_24
	j	.LBB19_15
.LBB19_15:
	li	a0, 0
	sw	a0, -64(s0)
	sw	a0, -68(s0)
	j	.LBB19_16
.LBB19_16:
	lw	a0, -68(s0)
	li	a1, 0
	bne	a0, a1, .LBB19_23
	j	.LBB19_17
.LBB19_17:
	lw	a0, -108(s0)
	lw	a1, -60(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB19_19
	j	.LBB19_18
.LBB19_18:
	lw	a0, -108(s0)
	lw	a1, -60(s0)
	add	a1, a0, a1
	li	a0, 102
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -68(s0)
	j	.LBB19_22
.LBB19_19:
	lw	a0, -108(s0)
	lw	a1, -60(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -64(s0)
	addi	a1, s0, -28
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bne	a0, a1, .LBB19_21
	j	.LBB19_20
.LBB19_20:
	lw	a1, -108(s0)
	lw	a0, -64(s0)
	addi	a2, s0, -28
	add	a0, a0, a2
	lb	a0, -1(a0)
	lw	a2, -60(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -68(s0)
	sw	a0, -40(s0)
	j	.LBB19_21
.LBB19_21:
	j	.LBB19_22
.LBB19_22:
	lw	a0, -64(s0)
	addi	a0, a0, 1
	sw	a0, -64(s0)
	j	.LBB19_16
.LBB19_23:
	lw	a0, -60(s0)
	addi	a0, a0, -1
	sw	a0, -60(s0)
	j	.LBB19_14
.LBB19_24:
	li	a0, 0
	sw	a0, -60(s0)
	j	.LBB19_25
.LBB19_25:
	lw	a0, -60(s0)
	lw	a1, -36(s0)
	bge	a0, a1, .LBB19_33
	j	.LBB19_26
.LBB19_26:
	li	a0, 0
	sw	a0, -64(s0)
	sw	a0, -68(s0)
	j	.LBB19_27
.LBB19_27:
	lw	a0, -68(s0)
	li	a1, 0
	bne	a0, a1, .LBB19_31
	j	.LBB19_28
.LBB19_28:
	lw	a0, -108(s0)
	lw	a1, -60(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -64(s0)
	addi	a1, s0, -28
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bne	a0, a1, .LBB19_30
	j	.LBB19_29
.LBB19_29:
	lw	a1, -108(s0)
	lw	a2, -64(s0)
	addi	a0, s0, -28
	sub	a0, a0, a2
	lb	a0, 15(a0)
	lw	a2, -60(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	li	a0, 1
	sw	a0, -68(s0)
	j	.LBB19_30
.LBB19_30:
	lw	a0, -64(s0)
	addi	a0, a0, 1
	sw	a0, -64(s0)
	j	.LBB19_27
.LBB19_31:
	j	.LBB19_32
.LBB19_32:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB19_25
.LBB19_33:
	li	a0, 0
	sw	a0, -60(s0)
	j	.LBB19_34
.LBB19_34:
	lw	a0, -60(s0)
	lw	a2, -36(s0)
	li	a1, 8
	sub	a1, a1, a2
	bge	a0, a1, .LBB19_37
	j	.LBB19_35
.LBB19_35:
	lw	a1, -60(s0)
	addi	a0, s0, -76
	add	a1, a0, a1
	li	a0, 102
	sb	a0, 0(a1)
	j	.LBB19_36
.LBB19_36:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB19_34
.LBB19_37:
	lw	a1, -36(s0)
	li	a0, 8
	sub	a0, a0, a1
	sw	a0, -60(s0)
	j	.LBB19_38
.LBB19_38:
	lw	a1, -60(s0)
	li	a0, 7
	blt	a0, a1, .LBB19_41
	j	.LBB19_39
.LBB19_39:
	lw	a1, -108(s0)
	lw	a2, -60(s0)
	lw	a0, -36(s0)
	add	a0, a2, a0
	add	a0, a0, a1
	lb	a0, -8(a0)
	addi	a1, s0, -76
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB19_40
.LBB19_40:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB19_38
.LBB19_41:
	li	a0, 0
	sw	a0, -88(s0)
	j	.LBB19_42
.LBB19_42:
	lw	a1, -88(s0)
	li	a0, 6
	blt	a0, a1, .LBB19_45
	j	.LBB19_43
.LBB19_43:
	lw	a3, -88(s0)
	addi	a0, s0, -76
	sub	a1, a0, a3
	lb	a1, 6(a1)
	addi	a2, s0, -84
	add	a3, a2, a3
	sb	a1, 0(a3)
	lw	a1, -88(s0)
	sub	a0, a0, a1
	lb	a0, 7(a0)
	add	a1, a1, a2
	sb	a0, 1(a1)
	j	.LBB19_44
.LBB19_44:
	lw	a0, -88(s0)
	addi	a0, a0, 2
	sw	a0, -88(s0)
	j	.LBB19_42
.LBB19_45:
	addi	a0, s0, -84
	sw	a0, -112(s0)
	li	a1, 8
	sw	a1, -116(s0)
	call	converter_hex_dec
	lw	a1, -116(s0)
	mv	a2, a0
	lw	a0, -112(s0)
	sw	a2, -92(s0)
	call	converter_hex_dec
	sw	a0, -96(s0)
	li	a0, 0
	sw	a0, -36(s0)
	j	.LBB19_46
.LBB19_46:
	lw	a0, -96(s0)
	li	a1, 0
	beq	a0, a1, .LBB19_48
	j	.LBB19_47
.LBB19_47:
	lw	a0, -96(s0)
	lui	a1, 838861
	addi	a1, a1, -819
	mulhu	a0, a0, a1
	srli	a0, a0, 3
	sw	a0, -96(s0)
	lw	a0, -36(s0)
	addi	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB19_46
.LBB19_48:
	lw	a0, -36(s0)
	addi	a1, a0, 15
	andi	a2, a1, -16
	mv	a1, sp
	sub	a1, a1, a2
	sw	a1, -120(s0)
	mv	sp, a1
	sw	a0, -100(s0)
	li	a0, 0
	sw	a0, -104(s0)
	j	.LBB19_49
.LBB19_49:
	lw	a0, -104(s0)
	lw	a1, -36(s0)
	bge	a0, a1, .LBB19_52
	j	.LBB19_50
.LBB19_50:
	lw	a0, -92(s0)
	sw	a0, -128(s0)
	lw	a1, -36(s0)
	lw	a0, -104(s0)
	not	a0, a0
	add	a1, a0, a1
	li	a0, 10
	sw	a0, -124(s0)
	call	potencia
	lw	a1, -128(s0)
	lw	a2, -120(s0)
	mv	a3, a0
	lw	a0, -124(s0)
	divu	a1, a1, a3
	addi	a1, a1, 48
	lw	a3, -104(s0)
	add	a2, a2, a3
	sb	a1, 0(a2)
	lw	a2, -36(s0)
	lw	a1, -104(s0)
	not	a1, a1
	add	a1, a1, a2
	call	potencia
	mv	a1, a0
	lw	a0, -92(s0)
	remu	a0, a0, a1
	sw	a0, -92(s0)
	j	.LBB19_51
.LBB19_51:
	lw	a0, -104(s0)
	addi	a0, a0, 1
	sw	a0, -104(s0)
	j	.LBB19_49
.LBB19_52:
	lw	a1, -120(s0)
	lw	a2, -36(s0)
	li	a0, 1
	call	write
	lw	a0, -44(s0)
	mv	sp, a0
	addi	sp, s0, -128
	lw	ra, 124(sp)
	lw	s0, 120(sp)
	addi	sp, sp, 128
	ret
.Lfunc_end19:
	.size	converter_neg_hex_en, .Lfunc_end19-converter_neg_hex_en

	.globl	main
	.p2align	2
	.type	main,@function
main:
	addi	sp, sp, -112
	sw	ra, 108(sp)
	sw	s0, 104(sp)
	addi	s0, sp, 112
	li	a0, 0
	sw	a0, -12(s0)
	addi	a1, s0, -44
	li	a2, 20
	call	read
	sw	a0, -48(s0)
	lbu	a0, -44(s0)
	li	a1, 48
	bne	a0, a1, .LBB20_3
	j	.LBB20_1
.LBB20_1:
	lbu	a0, -43(s0)
	li	a1, 98
	bne	a0, a1, .LBB20_3
	j	.LBB20_2
.LBB20_2:
	lw	a2, -48(s0)
	li	a0, 1
	addi	a1, s0, -44
	sw	a1, -96(s0)
	call	write
	lw	a0, -96(s0)
	lw	a1, -48(s0)
	call	converte_bin_dec2
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	call	converte_int_char
	lw	a0, -52(s0)
	call	converter_dec_hex
	lw	a0, -52(s0)
	call	converte_dec_hex_en
	j	.LBB20_15
.LBB20_3:
	lbu	a0, -44(s0)
	li	a1, 48
	bne	a0, a1, .LBB20_6
	j	.LBB20_4
.LBB20_4:
	lbu	a0, -43(s0)
	li	a1, 120
	bne	a0, a1, .LBB20_6
	j	.LBB20_5
.LBB20_5:
	lw	a1, -48(s0)
	addi	a0, s0, -44
	sw	a0, -100(s0)
	call	converter_hex_dec
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	call	converte_dec_bin
	mv	a1, a0
	lw	a0, -100(s0)
	sw	a1, -56(s0)
	lw	a1, -52(s0)
	call	converte_bin_dec
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	call	converte_int_char
	lw	a1, -100(s0)
	lw	a2, -48(s0)
	li	a0, 1
	call	write
	lw	a0, -100(s0)
	lw	a1, -48(s0)
	call	converter_hex_hex_en
	j	.LBB20_14
.LBB20_6:
	lbu	a0, -44(s0)
	li	a1, 45
	bne	a0, a1, .LBB20_12
	j	.LBB20_7
.LBB20_7:
	li	a0, 1
	sw	a0, -92(s0)
	j	.LBB20_8
.LBB20_8:
	lw	a0, -92(s0)
	lw	a1, -48(s0)
	bge	a0, a1, .LBB20_11
	j	.LBB20_9
.LBB20_9:
	lw	a1, -92(s0)
	addi	a0, s0, -44
	add	a0, a0, a1
	lb	a0, 0(a0)
	addi	a2, s0, -88
	add	a1, a1, a2
	sb	a0, -1(a1)
	j	.LBB20_10
.LBB20_10:
	lw	a0, -92(s0)
	addi	a0, a0, 1
	sw	a0, -92(s0)
	j	.LBB20_8
.LBB20_11:
	lw	a0, -48(s0)
	addi	a1, a0, -1
	addi	a0, s0, -88
	call	converte_char_int
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	call	converte_dec_bin2
	lw	a2, -48(s0)
	li	a0, 1
	addi	a1, s0, -44
	call	write
	lw	a0, -52(s0)
	call	converter_dec_hex2
	lw	a0, -52(s0)
	call	converter_neg_hex_en
	j	.LBB20_13
.LBB20_12:
	lw	a1, -48(s0)
	addi	a0, s0, -44
	sw	a0, -104(s0)
	call	converte_char_int
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	call	converte_dec_bin
	lw	a1, -104(s0)
	lw	a2, -48(s0)
	li	a0, 1
	call	write
	lw	a0, -52(s0)
	call	converter_dec_hex
	lw	a0, -52(s0)
	call	converte_dec_hex_en
	j	.LBB20_13
.LBB20_13:
	j	.LBB20_14
.LBB20_14:
	j	.LBB20_15
.LBB20_15:
	li	a0, 0
	lw	ra, 108(sp)
	lw	s0, 104(sp)
	addi	sp, sp, 112
	ret
.Lfunc_end20:
	.size	main, .Lfunc_end20-main

	.type	.L__const.converte_hex_bin.hex,@object
	.section	.rodata.cst16,"aM",@progbits,16
.L__const.converte_hex_bin.hex:
	.ascii	"0123456789abcdef"
	.size	.L__const.converte_hex_bin.hex, 16

	.type	.L__const.converter_hex_dec.hex,@object
.L__const.converter_hex_dec.hex:
	.ascii	"0123456789abcdef"
	.size	.L__const.converter_hex_dec.hex, 16

	.type	.L__const.converter_dec_hex.hex,@object
.L__const.converter_dec_hex.hex:
	.ascii	"0123456789abcdef"
	.size	.L__const.converter_dec_hex.hex, 16

	.type	.L__const.converter_dec_hex2.hex,@object
.L__const.converter_dec_hex2.hex:
	.ascii	"0123456789abcdef"
	.size	.L__const.converter_dec_hex2.hex, 16

	.type	.L__const.converte_dec_hex_en.hex,@object
.L__const.converte_dec_hex_en.hex:
	.ascii	"0123456789abcdef"
	.size	.L__const.converte_dec_hex_en.hex, 16

	.type	.L__const.converter_neg_hex_en.hex,@object
.L__const.converter_neg_hex_en.hex:
	.ascii	"0123456789abcdef"
	.size	.L__const.converter_neg_hex_en.hex, 16

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym exit
	.addrsig_sym potencia
	.addrsig_sym converte_char_int
	.addrsig_sym converte_dec_bin
	.addrsig_sym polinomio_bin
	.addrsig_sym converte_dec_bin2
	.addrsig_sym soma_um_bin
	.addrsig_sym converte_bin_dec
	.addrsig_sym converte_bin_dec2
	.addrsig_sym converter_hex_dec
	.addrsig_sym converter_dec_hex
	.addrsig_sym converter_dec_hex2
	.addrsig_sym converte_int_char
	.addrsig_sym converte_dec_hex_en
	.addrsig_sym converter_hex_hex_en
	.addrsig_sym converter_neg_hex_en
	.addrsig_sym main
