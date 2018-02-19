# Como iniciar: 0- Open MARS
#		1- Tools -> Bitmap Display
#		2- unit width in pixel: 8 / unit height in pixel: 8
#		3- Display Width in Pixels: 512 / Display Height in Pixels: 256
#		4- Tools -> Keyboard and Display
#		5- Connect to MIPS
#		6- Assemble and RUN

.kdata

cor:		.word 0x0000CCFF
bitmap_address:	.word 0x10010000
bitmap_size:	.word 2048		# (512 x 256)/8 pixels
jogador_cor:	.word 0x00FF0000
jogador:	.space 16		# 4x4 blocos

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
	lw	$t0, bitmap_address
	lw	$t1, jogador_cor
	li	$t2, 0x10011B7C
	sw	$t2, jogador
	li	$t2, 0x10011C78
	sw	$t2, jogador + 4 
	li	$t2, 0x10011C7C
	sw	$t2, jogador + 8
	li	$t2, 0x10011C80
	sw	$t2, jogador + 12
	move	$t2, $zero
player_p:
	lw	$t3, jogador($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 16, player_p
	jr	$ra
	
exit:
