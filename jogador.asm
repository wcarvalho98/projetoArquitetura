#################################################################################
#	Jogador e suas funcoes				    		 	#
#################################################################################

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
#	Pinta o disparo na tela							#
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
#	Retorna: $a0 = 1 se ainda estïver disparando				#
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
#	Verifica se um disparo acertou o player					#
#	Retorna: $s7 = 1 se acertou o player					#
#################################################################################
verifica_morte:
	move	$s7, $zero
	move	$t2, $zero
	lw	$t3, jogador
	lw	$t4, jogador + 4
	lw	$t5, jogador + 12
loop_morte:
	lw	$t1, disparo1_1($t2)
	beq	$t1, $t3, morte
	beq	$t1, $t4, morte
	beq	$t1, $t5, morte
	addi	$t2, $t2, 4
	blt	$t2, 32, loop_morte
fim_morte:
	jr	$ra
morte:
	addi	$s7, $zero, 1
	j	fim_morte
	
#################################################################################
#	Salva dentro de jogador_temp a posicao atual do player			#
#################################################################################
salva_jogador:
	move	$t2, $zero
salva_loop:
	lw	$t3, jogador($t2)
	sw	$t3, jogador_temp($t2)
	addi	$t2, $t2, 4
	blt	$t2, 16, salva_loop
	jr	$ra

#################################################################################
#	Movendo o jogador para cima						#
#################################################################################
mover_acima:
	move	$t7, $ra
acima_loop_ext:
	move	$t5, $zero
	jal	limpa_jogador
acima_loop:
	lw	$t4, jogador($t5)
	addi	$t4, $t4, -256
	sw	$t4, jogador($t5)
	addi	$t5, $t5, 4
	blt	$t5, 16, acima_loop
	jal	pinta_player
	sleep(50)
	bgt	$t4, 0x10010000, acima_loop_ext
	jr	$t7
	
#################################################################################
#	Carregando os dados do jogador para voltar a posicao original		#
#################################################################################
carregar_acima:
	move	$t2, $zero
carregar_acima_loop:
	lw	$t3, jogador_temp($t2)
	addi	$t3, $t3, 1280
	sw	$t3, jogador($t2)
	addi	$t2, $t2, 4
	blt	$t2, 16, carregar_acima_loop
	jr	$ra

#################################################################################
#	Voltando para a posicao original					#
#################################################################################
voltar_acima:
	move	$t7, $ra
	lw	$t4, jogador_temp + 12
voltar_acima_loop_ext:
	move	$t6, $zero
	jal	limpa_jogador
voltar_acima_loop:
	lw	$t5, jogador($t6)
	addi	$t5, $t5, -256
	sw	$t5, jogador($t6)
	addi	$t6, $t6, 4
	blt	$t6, 16, voltar_acima_loop
	jal	pinta_player
	sleep(50)
	bgt	$t5, $t4, voltar_acima_loop_ext
	jr	$t7