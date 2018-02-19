.kdata

cor:		.word 0x000000FF
bitmap_address:	.word 0x10010000
bitmap_size:	.word 2048		# (512 x 256)/8 pixels
jogador_cor:	.word 0x00000000
jogador_pos:	.word 0x10011A7C
jogador_size:	.word 1			# 8 x 8 pixels

.text
.globl main
main:
	jal 	background
	jal	player
	j 	exit
	
background:
	lw	$t0, bitmap_address
	lw	$t1, cor
	lw	$t2, bitmap_size
	move	$t3, $zero
backgroud_loop:
	sll	$t4, $t3, 2
	add	$t4, $t4, $t0
	sw	$t1, 0($t4)
	addi	$t3, $t3, 1
	blt	$t3, $t2, backgroud_loop
	jr	$ra
	
player:
	lw	$t0, jogador_pos
	lw	$t1, jogador_cor
	lw	$t2, jogador_size
	move	$t3, $zero
player_loop:
	sll	$t4, $t3, 2
	add	$t4, $t4, $t0
	sw	$t1, 0($t4)
	addi	$t3, $t3, 1
	blt	$t3, $t2, player_loop
	jr	$ra
	
exit: