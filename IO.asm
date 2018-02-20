#################################################################################
# Como iniciar: 0- Open MARS							#
#		1- Tools -> Bitmap Display					#
#		2- unit width in pixel: 8 / unit height in pixel: 8		#
#		3- Display Width in Pixels: 512 / Display Height in Pixels: 256	#
#		4- Tools -> Keyboard and Display				#
#		5- Connect to MIPS						#
#		6- Assemble and RUN						#
#################################################################################

.kdata
cor:		.word 0x0000CCFF
bitmap_address:	.word 0x10010000
bitmap_size:	.word 2048		# (512 x 256)/8 pixels
jogador_cor:	.word 0x00FF0000
jogador:	.space 16		# 4x4 blocos
corVerde: 	.word 0x0000FF00
disparo:	.word 0x00000000
nave_1:		.space 104
nave_2:		.space 32
nave_3:		.space 32
nave_4:		.space 32
nave_5:		.space 32
nave_6:		.space 32
nave_7:		.space 32

#################################################################################
#	MAIN	--	Space Invaders						#
#################################################################################

.text
.globl main
main:
	jal 	background
	jal	player
	jal	nave_nivel_3
	jal	pinta_nave_1
	jal	pinta_naves
	
main_loop:
	jal	sleep
	li	$v0, 0x00000000
	jal	obter_tecla
	jal	verifica_disparo
	bne	$a0, 1, main_direita
	jal	limpa_disparo
	jal	mover_disparo
	jal	pinta_disparo
	
main_direita:
	bne	$v0, 0x01000000, main_esquerda
	jal	mover_direita
	j	main_loop
	
main_esquerda:
	bne	$v0, 0x02000000, main_disparo
	jal	mover_esquerda
	j	main_loop
	
main_disparo:
	bne	$v0, 0x03000000, main_loop
	jal	verifica_disparo
	beq 	$a0, 1, main_loop
	jal	disparar
	j	main_loop
	
#################################################################################
#	Pintando o background							#
#################################################################################
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
	
#################################################################################
#	Pintando o player e povoando o vetor jogador com o seu lugar na memoria #
#################################################################################
player:
	li	$t2, 0x10011B7C
	sw	$t2, jogador
	li	$t2, 0x10011C78
	sw	$t2, jogador + 4 
	li	$t2, 0x10011C7C
	sw	$t2, jogador + 8
	li	$t2, 0x10011C80
	sw	$t2, jogador + 12
pinta_player:
	lw	$t1, jogador_cor
	move	$t2, $zero
player_loop:
	lw	$t3, jogador($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 16, player_loop
	jr	$ra
	
#################################################################################
#	Limpa o jogador antes de pintar						#
#################################################################################
limpa_jogador:
	move 	$t2, $zero
	lw	$t1, cor
limpa_loop:
	lw	$t3, jogador($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 16, limpa_loop
	jr	$ra
		
#################################################################################
#	Disparar								#
#################################################################################
disparar:
	lw	$t0, jogador
	sw	$t0, disparo
mover_disparo:
	lw	$t0, disparo
	addi	$t0, $t0, -256
	sw	$t0, disparo
	jr	$ra
	
#################################################################################
#	Pìnta o disparo na tela							#
#################################################################################
pinta_disparo:
	lw	$t1, jogador_cor
	lw	$t2, disparo
	sw	$t1, ($t2)
	jr	$ra

#################################################################################
#	Limpa o disparo do jogador						#
#################################################################################
limpa_disparo:
	lw	$t1, cor
	lw	$t2, disparo
	sw	$t1, ($t2)
	jr	$ra
	
#################################################################################
#	Verifica se o disparo acabou						#
#	Retorna: $a0 = 1 se ainda está disparando				#
#		 $a0 = 0 caso o disparo tenha terminado				#
#################################################################################
verifica_disparo:
	lw	$t0, disparo
	sge	$a0, $t0, 0x10010000
	jr	$ra
	
#################################################################################
#	Movendo o jogador para a direita					#
#################################################################################
mover_direita:
	move	$t7, $ra
	lw	$t4, jogador + 12
	beq	$t4, 0x10011CFC, direita_fim
	jal 	limpa_jogador
	move	$t2, $zero
direita_loop:
	lw	$t3, jogador($t2)
	addi	$t3, $t3, 4
	sw	$t3, jogador($t2)
	addi	$t2, $t2, 4
	blt	$t2, 16, direita_loop
	jal	pinta_player
direita_fim:
	jr	$t7
	
#################################################################################
#	Movendo o jogador para a esquerda					#
#################################################################################
mover_esquerda:
	move	$t7, $ra
	lw	$t4, jogador + 4
	beq	$t4, 0x10011C00, esquerda_fim
	jal 	limpa_jogador
	move	$t2, $zero
esquerda_loop:
	lw	$t3, jogador($t2)
	addi	$t3, $t3, -4
	sw	$t3, jogador($t2)
	addi	$t2, $t2, 4
	blt	$t2, 16, esquerda_loop
	jal	pinta_player
esquerda_fim:
	jr	$t7

#################################################################################
#	Retorna $v0 com o valor 0x01, 0x02 ou 0x03, indicando			#
#	direita, esquerda e disparo respectivamente.				#
#################################################################################
obter_tecla:
	lw $t0 0xFFFF0004		
obter_tecla_direita:
	bne $t0 100 obter_tecla_esquerda
	li $v0 0x01000000
	j obter_tecla_voltar
obter_tecla_esquerda:
	bne $t0 97 obter_tecla_disparo
	li $v0 0x02000000
	j obter_tecla_voltar
obter_tecla_disparo:
	bne $t0 32 obter_tecla_voltar
	li $v0 0x03000000		
obter_tecla_voltar:
	li $t0, 0xFFFF0004
	sw $zero, ($t0)
	jr $ra
	
#################################################################################
#	Saindo do jogo :c							#
#################################################################################
exit:

#################################################################################
#	Naves do estágio 3							#
#################################################################################
nave_nivel_3:	
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
	
	# Nave 3
	li	$t2, 0x10010638
	sw	$t2, nave_3
	li	$t2, 0x10010734
	sw	$t2, nave_3 + 4
	li	$t2, 0x10010738
	sw	$t2, nave_3 + 8
	li	$t2, 0x1001073C
	sw	$t2, nave_3 + 12
	li	$t2, 0x10010834
	sw	$t2, nave_3 + 16
	li	$t2, 0x1001083C
	sw	$t2, nave_3 + 20
	li	$t2, 0x10010930
	sw	$t2, nave_3 + 24
	li	$t2, 0x10010940
	sw	$t2, nave_3 + 28
	
	# Nave 4
	li	$t2, 0x10010B58
	sw	$t2, nave_4
	li	$t2, 0x10010C54
	sw	$t2, nave_4 + 4
	li	$t2, 0x10010C58
	sw	$t2, nave_4 + 8
	li	$t2, 0x10010C5C
	sw	$t2, nave_4 + 12
	li	$t2, 0x10010D54
	sw	$t2, nave_4 + 16
	li	$t2, 0x10010D5C
	sw	$t2, nave_4 + 20
	li	$t2, 0x10010E50
	sw	$t2, nave_4 + 24
	li	$t2, 0x10010E60
	sw	$t2, nave_4 + 28
	
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
	
	# Nave 6
	li	$t2, 0x10010AC4
	sw	$t2, nave_6
	li	$t2, 0x10010BC0
	sw	$t2, nave_6 + 4
	li	$t2, 0x10010BC4
	sw	$t2, nave_6 + 8
	li	$t2, 0x10010BC8
	sw	$t2, nave_6 + 12
	li	$t2, 0x10010CC0
	sw	$t2, nave_6 + 16
	li	$t2, 0x10010CC8
	sw	$t2, nave_6 + 20
	li	$t2, 0x10010DBC
	sw	$t2, nave_6 + 24
	li	$t2, 0x10010DCC
	sw	$t2, nave_6 + 28
	
	# Nave 7
	li	$t2, 0x100102E4
	sw	$t2, nave_7
	li	$t2, 0x100103E0
	sw	$t2, nave_7 + 4
	li	$t2, 0x100103E4
	sw	$t2, nave_7 + 8
	li	$t2, 0x100103E8
	sw	$t2, nave_7 + 12
	li	$t2, 0x100104E0
	sw	$t2, nave_7 + 16
	li	$t2, 0x100104E8
	sw	$t2, nave_7 + 20
	li	$t2, 0x100105DC
	sw	$t2, nave_7 + 24
	li	$t2, 0x100105EC
	sw	$t2, nave_7 + 28
	
	jr	$ra

#################################################################################
#	Pinta nave 1								#
#################################################################################
pinta_nave_1:
	lw	$t1, corVerde
	move	$t2, $zero
nave_1_loop:
	lw	$t3, nave_1($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 104, nave_1_loop
	jr	$ra
	
#################################################################################
#	Pinta naves 2-7								#
#################################################################################
pinta_naves:
	lw	$t1, corVerde
	move	$t2, $zero
naves_loop:
	lw	$t3, nave_2($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 192, naves_loop
	jr	$ra
	
#################################################################################
#	Função para dormir por 60ms						#
#################################################################################
sleep:
	li $v0 32 		# Syscall 32. Usa el Sleep de Java
	li $a0 60
	syscall
	jr	$ra
