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
jogador_pos:	.word 0x10011B7C

.text
.globl main
main:
	jal 	background
	jal	player
	jal 	nave
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
	lw	$t2, jogador_pos
	sw	$t1, ($t2)
	sw	$t1, 7288($t0)
	sw	$t1, 7292($t0)
	sw	$t1, 7296($t0)
	sw	$t1, 7540($t0)
	sw	$t1, 7544($t0)
	sw	$t1, 7548($t0)
	sw	$t1, 7552($t0)
	sw	$t1, 7556($t0)
	jr	$ra
	
exit:

nave:
	
