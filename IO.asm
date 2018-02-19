# Como iniciar: 	0- Open MARS
#			1- Tools -> Bitmap Display
#			2- unit width in pixel: 8 / unit height in pixel: 8
#			3- Display Width in Pixels: 512 / Display Height in Pixels: 256
#			4- Tools -> Keyboard and Display
#			5- Connect to MIPS
#			6- Assemble and RUN
#testeCommit
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
exit:

nave:
	
