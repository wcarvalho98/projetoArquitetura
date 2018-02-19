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
#Pedro
corVerde: 	.word 0x0000FF00

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
	#naves referentes ao último nível
	lw	$t0, bitmap_address
	lw	$t1, corVerde
	#Nave 1
	sw $t1, 4624 ($t0)
	sw $t1, 4116 ($t0)
	sw $t1, 4372 ($t0)
	sw $t1, 3864 ($t0)
	sw $t1, 4120 ($t0)
	sw $t1, 4124 ($t0)
	sw $t1, 4380 ($t0)
	sw $t1, 4640 ($t0)
	
	#Nave 2
	sw $t1, 2352 ($t0)
	sw $t1, 2100 ($t0)
	sw $t1, 1844 ($t0)
	sw $t1, 1592 ($t0)
	sw $t1, 1848 ($t0)
	sw $t1, 1852 ($t0)
	sw $t1, 2108 ($t0)
	sw $t1, 2368 ($t0)
	
	#nave 3
	sw $t1, 3664 ($t0)
	sw $t1, 3156 ($t0)
	sw $t1, 3412 ($t0)
	sw $t1, 2904 ($t0)
	sw $t1, 3160 ($t0)
	sw $t1, 3164 ($t0)
	sw $t1, 3420 ($t0)
	sw $t1, 3680 ($t0)
	
	#nave 4 (nave mãe)
	sw $t1, 2160 ($t0)
	sw $t1, 2416 ($t0)
	sw $t1, 1908 ($t0)
	sw $t1, 1652 ($t0)
	sw $t1, 1400 ($t0)
	sw $t1, 1144 ($t0)
	sw $t1,  888 ($t0)
	sw $t1,  632 ($t0)
	sw $t1,  380 ($t0)
	sw $t1,  636 ($t0)
	sw $t1,  892 ($t0)
	sw $t1, 1148 ($t0)
	sw $t1, 1404 ($t0)
	sw $t1,  384 ($t0)
	sw $t1,  640 ($t0)
	sw $t1,  896 ($t0)
	sw $t1, 1152 ($t0)
	sw $t1, 1408 ($t0)
	sw $t1,  644 ($t0)
	sw $t1,  900 ($t0)
	sw $t1, 1156 ($t0)
	sw $t1, 1412 ($t0)
	sw $t1, 1672 ($t0)
	sw $t1, 1928 ($t0)
	sw $t1, 2188 ($t0)
	sw $t1, 2444 ($t0)
	
	#nave 5
	sw $t1, 1948 ($t0)
	sw $t1, 1696 ($t0)
	sw $t1, 1440 ($t0)
	sw $t1, 1444 ($t0)
	sw $t1, 1188 ($t0)
	sw $t1, 1448 ($t0)
	sw $t1, 1704 ($t0)
	sw $t1, 1964 ($t0)
	
	#nave 6
	sw $t1, 3516 ($t0)
	sw $t1, 3264 ($t0)
	sw $t1, 3008 ($t0)
	sw $t1, 3012 ($t0)
	sw $t1, 2756 ($t0)
	sw $t1, 3016 ($t0)
	sw $t1, 3272 ($t0)
	sw $t1, 3532 ($t0)
	
	#nave 7
	sw $t1, 1500 ($t0)
	sw $t1,  992 ($t0)
	sw $t1, 1248 ($t0)
	sw $t1,  740 ($t0)
	sw $t1,  996 ($t0)
	sw $t1, 1000 ($t0)
	sw $t1, 1256 ($t0)
	sw $t1, 1516 ($t0)
	