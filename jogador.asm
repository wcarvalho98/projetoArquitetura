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
