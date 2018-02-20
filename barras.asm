#BarraNivel1
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
	