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
tam: 		.word 4440
tam_fim: 	.word 4520

#################################################################################
#	MAIN	--	Space Invaders						#
#################################################################################

.text
.globl main
main:
	jal 	background
	jal	player
	jal	nave
	
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
#	P�nta o disparo na tela							#
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
#	Retorna: $a0 = 1 se ainda est� disparando				#
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

nave: #nivel 1
	lw	$t0, bitmap_address
	lw	$t1, corVerde

	#nave 3
	sw $t1, 3664 ($t0)
	sw $t1, 3156 ($t0)
	sw $t1, 3412 ($t0)
	sw $t1, 2904 ($t0)
	sw $t1, 3160 ($t0)
	sw $t1, 3164 ($t0)
	sw $t1, 3420 ($t0)
	sw $t1, 3680 ($t0)
	
	#nave 4 (nave m�e)
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
	
	#barra
	lw	$t5, 4440 ($t0)
	move	$t3, $zero
	move 	$t4, $zero
barra:
	
	beq	$t3, $t2, barra_exit
	sll	$t4, $t3, 2
	add	$t4, $t4, $t5
	sw	$t1, 0($t4)
	addi	$t3, $t3, 1
	j	barra

	
barra_exit:
	jr $ra
sleep:
	li $v0 32 		# Syscall 32. Usa el Sleep de Java
	li $a0 60
	syscall
	jr	$ra
