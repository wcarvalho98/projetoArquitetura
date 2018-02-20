 	# Nave 1 (nave mae)
	li	$t2, 0x1001017C
	sw	$t2, nave_1
	li	$t2, 0x10010180
	sw	$t2, nave_1 + 4
	li	$t2, 0x10010278
	sw	$t2, nave_1 + 8
	li	$t2, 0x1001027C
	sw	$t2, nave_1 + 12
	li	$t2, 0x10010280
	sw	$t2, nave_1 + 16
	li	$t2, 0x10010284
	sw	$t2, nave_1 + 20
	li	$t2, 0x10010378
	sw	$t2, nave_1 + 24
	li	$t2, 0x1001037C
	sw	$t2, nave_1 + 28
	li	$t2, 0x10010380
	sw	$t2, nave_1 + 32
	li	$t2, 0x10010384
	sw	$t2, nave_1 + 36
	li	$t2, 0x10010478
	sw	$t2, nave_1 + 40
	li	$t2, 0x1001047C
	sw	$t2, nave_1 + 44
	li	$t2, 0x10010480
	sw	$t2, nave_1 + 48
	li	$t2, 0x10010484
	sw	$t2, nave_1 + 52
	li	$t2, 0x10010578
	sw	$t2, nave_1 + 56
	li	$t2, 0x1001057C
	sw	$t2, nave_1 + 60
	li	$t2, 0x10010580
	sw	$t2, nave_1 + 64
	li	$t2, 0x10010584
	sw	$t2, nave_1 + 68
	li	$t2, 0x10010674
	sw	$t2, nave_1 + 72
	li	$t2, 0x10010688
	sw	$t2, nave_1 + 76
	li	$t2, 0x10010774
	sw	$t2, nave_1 + 80
	li	$t2, 0x10010788
	sw	$t2, nave_1 + 84
	li	$t2, 0x10010870
	sw	$t2, nave_1 + 88
	li	$t2, 0x1001088C
	sw	$t2, nave_1 + 92
	li	$t2, 0x10010970
	sw	$t2, nave_1 + 96
	li	$t2, 0x1001098C
	sw	$t2, nave_1 + 100
	
	# Nave 2
	li	$t2, 0x10010F18
	sw	$t2, nave_2
	li	$t2, 0x10011014
	sw	$t2, nave_2 + 4
	li	$t2, 0x10011018
	sw	$t2, nave_2 + 8
	li	$t2, 0x1001101C
	sw	$t2, nave_2 + 12
	li	$t2, 0x10011114
	sw	$t2, nave_2 + 16
	li	$t2, 0x1001111C
	sw	$t2, nave_2 + 20
	li	$t2, 0x10011210
	sw	$t2, nave_2 + 24
	li	$t2, 0x10011220
	sw	$t2, nave_2 + 28
	
	# Nave 5
	li	$t2, 0x100104A4
	sw	$t2, nave_5
	li	$t2, 0x100105A0
	sw	$t2, nave_5 + 4
	li	$t2, 0x100105A4
	sw	$t2, nave_5 + 8
	li	$t2, 0x100105A8
	sw	$t2, nave_5 + 12
	li	$t2, 0x100106A0
	sw	$t2, nave_5 + 16
	li	$t2, 0x100106A8
	sw	$t2, nave_5 + 20
	li	$t2, 0x1001079C
	sw	$t2, nave_5 + 24
	li	$t2, 0x100107AC
	sw	$t2, nave_5 + 28
	
printarNavesNivel2:
	pinta_nave_1:
		lw	$t1, corVerde
		move	$t2, $zero
	nave_1_loop:
		lw	$t3, nave_1($t2)
		sw	$t1, ($t3)
		addi	$t2, $t2, 4
		blt	$t2, 104, nave_1_loop
		move $t2, $0
	nave_2_loop:
		lw	$t3, nave_2($t2)
		sw	$t1, ($t3)
		addi	$t2, $t2, 4
		blt	$t2, 32, nave_2_loop
		move $t2, $0
	nave_5_loop:
		lw	$t3, nave_5($t2)
		sw	$t1, ($t3)
		addi	$t2, $t2, 4
		blt	$t2, 32, nave_5_loop
		