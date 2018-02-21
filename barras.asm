#BarraNivel1
barras_1:
	li	$t2, 0x10011158
	sw	$t2, barra_nivel_1
	li	$t2, 0x1001115C
	sw	$t2, barra_nivel_1 + 4
	li	$t2, 0x10011160
	sw	$t2, barra_nivel_1 + 8
	li	$t2, 0x10011164
	sw	$t2, barra_nivel_1 + 12
	li	$t2, 0x10011168
	sw	$t2, barra_nivel_1 + 16
	li	$t2, 0x1001116C
	sw	$t2, barra_nivel_1 + 20
	li	$t2, 0x10011170
	sw	$t2, barra_nivel_1 + 24
	li	$t2, 0x10011174
	sw	$t2, barra_nivel_1 + 28
	li	$t2, 0x10011178
	sw	$t2, barra_nivel_1 + 32
	li	$t2, 0x1001117C
	sw	$t2, barra_nivel_1 + 36
	li	$t2, 0x10011180
	sw	$t2, barra_nivel_1 + 40
	li	$t2, 0x10011184
	sw	$t2, barra_nivel_1 + 44
	li	$t2, 0x10011188
	sw	$t2, barra_nivel_1 + 48
	li	$t2, 0x1001118C
	sw	$t2, barra_nivel_1 + 52
	li	$t2, 0x10011190
	sw	$t2, barra_nivel_1 + 56
	li	$t2, 0x10011194
	sw	$t2, barra_nivel_1 + 60
	li	$t2, 0x10011198
	sw	$t2, barra_nivel_1 + 64
	li	$t2, 0x1001119C
	sw	$t2, barra_nivel_1 + 68
	li	$t2, 0x100111A0
	sw	$t2, barra_nivel_1 + 72
	li	$t2, 0x100111A4
	sw	$t2, barra_nivel_1 + 76
pinta_barra:
	lw	$t1, corVerde
	move	$t2, $zero
barra_loop:
	lw	$t3, barra_nivel_1($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 80, barra_loop
	jr	$ra
	
#BarraNivel2(1)
barras_2:
	li	$t2, 0x10011340
	sw	$t2, barra_nivel2_1
	li	$t2, 0x10011344
	sw	$t2, barra_nivel2_1 + 4
	li	$t2, 0x10011348
	sw	$t2, barra_nivel2_1 + 8
	li	$t2, 0x1001134C
	sw	$t2, barra_nivel2_1 + 12
	li	$t2, 0x10011350
	sw	$t2, barra_nivel2_1 + 16
	li	$t2, 0x10011354
	sw	$t2, barra_nivel2_1 + 20
	li	$t2, 0x10011358
	sw	$t2, barra_nivel2_1 + 24
	li	$t2, 0x1001135C
	sw	$t2, barra_nivel2_1 + 28
	li	$t2, 0x10011360
	sw	$t2, barra_nivel2_1 + 32
	li	$t2, 0x10011364
	sw	$t2, barra_nivel2_1 + 36
	li	$t2, 0x10011368
	sw	$t2, barra_nivel2_1 + 40
	li	$t2, 0x1001136C
	sw	$t2, barra_nivel2_1 + 44
	li	$t2, 0x10011370
	sw	$t2, barra_nivel2_1 + 48
	li	$t2, 0x10011374
	sw	$t2, barra_nivel2_1 + 52
	li	$t2, 0x10011378
	sw	$t2, barra_nivel2_1 + 56
	li	$t2, 0x1001137C
	
	#BarraNivel2(2)
	li	$t2, 0x10011388
	sw	$t2, barra_nivel2_2
	li	$t2, 0x1001138C
	sw	$t2, barra_nivel2_2 + 4
	li	$t2, 0x10011390
	sw	$t2, barra_nivel2_2 + 8
	li	$t2, 0x10011394
	sw	$t2, barra_nivel2_2 + 12
	li	$t2, 0x10011398
	sw	$t2, barra_nivel2_2 + 16
	li	$t2, 0x1001139C
	sw	$t2, barra_nivel2_2 + 20
	li	$t2, 0x100113A0
	sw	$t2, barra_nivel2_2 + 24
	li	$t2, 0x100113A4
	sw	$t2, barra_nivel2_2 + 28
	li	$t2, 0x100113A8
	sw	$t2, barra_nivel2_2 + 32
	li	$t2, 0x100113AC
	sw	$t2, barra_nivel2_2 + 36
	li	$t2, 0x100113B0
	sw	$t2, barra_nivel2_2 + 40
	li	$t2, 0x100113B4
	sw	$t2, barra_nivel2_2 + 44
	li	$t2, 0x100113B8
	sw	$t2, barra_nivel2_2 + 48
	li	$t2, 0x100113BC
	sw	$t2, barra_nivel2_2 + 52
	li	$t2, 0x100113C0
	sw	$t2, barra_nivel2_2 + 56
	li	$t2, 0x100113C4
	
pinta_barraNivel2:
	lw	$t1, corVerde
	move	$t2, $zero
barra_loopNivel2:
	lw	$t3, barra_nivel2_1($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 120, barra_loopNivel2
	jr	$ra
	
