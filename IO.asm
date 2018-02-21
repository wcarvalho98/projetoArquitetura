#################################################################################
# Como iniciar: 0- Open MARS							#
#		1- Tools -> Bitmap Display					#
#		2- unit width in pixel: 8 / unit height in pixel: 8		#
#		3- Display Width in Pixels: 512 / Display Height in Pixels: 256	#
#		4- Tools -> Keyboard and Display				#
#		5- Connect to MIPS						#
#		6- Assemble and RUN						#
#################################################################################
.include	"barras.asm"
.include	"naves.asm"
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
barra_nivel_1: 	.space 80
barra_nivel2_1: .space 60
barra_nivel2_2: .space 60
destruida_1:	.byte  0
destruida_2:	.byte  0
destruida_3:	.byte  0
destruida_4:	.byte  0
destruida_5:	.byte  0
destruida_6:	.byte  0
destruida_7:	.byte  0
.align 1

#################################################################################
#	MAIN	--	Space Invaders						#
#################################################################################

.text
.globl main
main:
	jal 	background
	jal	player
	jal	naves
	jal	pinta_naves_1
	jal	barras_1
	
main_loop:
	jal	sleep
	li	$v0, 0x00000000
	jal	obter_tecla
	jal	verifica_disparo
	bne	$a0, 1, main_direita
	jal	limpa_disparo
	jal	mover_disparo
	jal	pinta_disparo
	jal	verifica_acerto_nave_1
	jal	verifica_acerto_nave_2
	jal	verifica_acerto_nave_3
	jal	verifica_acerto_nave_4
	jal	verifica_acerto_nave_5
	jal	verifica_acerto_nave_6
	jal	verifica_acerto_nave_7
	beqz	$a3, main_direita
	jal	limpa_invasor
	move	$a3, $zero
	
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
#	Verifica se o disparo acertou a nave 1					#
#	Retorna: $a1 = 1 se acertou, referente ao numero da nave		#
#		 $a3 = 1 se acertou						#
#################################################################################
verifica_acerto_nave_1:
	lb	$t4, destruida_1
	beq	$t4, 1, fim_1
	lw	$t0, disparo
	move	$t1, $zero
	move 	$a1, $zero
	move	$a2, $zero
	move	$t2, $zero
acerto_1_loop:
	lw	$t3, nave_1($t2)
	seq	$t1, $t0, $t3
	beq	$t1, 1, fim_1
	addi	$t2, $t2, 4
	blt	$t2, 104, acerto_1_loop
fim_1:
	beq	$t1, 1, acerto_1
	jr	$ra
acerto_1:
	li	$a3, 1
	sb	$t1, destruida_1
	li	$t1, 0
	li	$a1, 1
	j	fim_1
	
#################################################################################
#	Verifica se o disparo acertou a nave 2					#
#	Retorna: $a1 = 2 se acertou, referente ao numero da nave		#
#		 $a3 = 1 se acertou						#
#################################################################################
verifica_acerto_nave_2:
	lb	$t4, destruida_2
	beq	$t4, 1, fim_2
	beq	$a3, 1, fim_2
	lw	$t0, disparo
	move	$t1, $zero
	move 	$a1, $zero
	move	$t2, $zero
acerto_2_loop:
	lw	$t3, nave_2($t2)
	seq	$t1, $t0, $t3
	beq	$t1, 1, fim_2
	addi	$t2, $t2, 4
	blt	$t2, 32, acerto_2_loop
fim_2:
	beq	$t1, 1, acerto_2
	jr	$ra
acerto_2:
	li	$a3, 1
	sb	$t1, destruida_2
	li	$t1, 0
	li	$a1, 2
	j	fim_2
	
#################################################################################
#	Verifica se o disparo acertou a nave 3					#
#	Retorna: $a1 = 3 se acertou, referente ao numero da nave		#
#		 $a3 = 1 se acertou						#
#################################################################################
verifica_acerto_nave_3:
	lb	$t4, destruida_3
	beq	$t4, 1, fim_3
	beq	$a3, 1, fim_3
	lw	$t0, disparo
	move	$t1, $zero
	move 	$a1, $zero
	move	$t2, $zero
acerto_3_loop:
	lw	$t3, nave_2($t2)
	seq	$t1, $t0, $t3
	beq	$t1, 1, fim_3
	addi	$t2, $t2, 4
	blt	$t2, 32, acerto_3_loop
fim_3:
	beq	$t1, 1, acerto_3
	jr	$ra
acerto_3:
	li	$a3, 1
	sb	$t1, destruida_3
	li	$t1, 0
	li	$a1, 3
	j	fim_3

#################################################################################
#	Verifica se o disparo acertou a nave 4					#
#	Retorna: $a1 = 4 se acertou, referente ao numero da nave		#
#		 $a3 = 1 se acertou						#
#################################################################################
verifica_acerto_nave_4:
	lb	$t4, destruida_4
	beq	$t4, 1, fim_4
	beq	$a3, 1, fim_4
	lw	$t0, disparo
	move	$t1, $zero
	move 	$a1, $zero
	move	$t2, $zero
acerto_4_loop:
	lw	$t3, nave_4($t2)
	seq	$t1, $t0, $t3
	beq	$t1, 1, fim_4
	addi	$t2, $t2, 4
	blt	$t2, 32, acerto_4_loop
fim_4:
	beq	$t1, 1, acerto_4
	jr	$ra
acerto_4:
	li	$a3, 1
	sb	$t1, destruida_4
	li	$t1, 0
	li	$a1, 4
	j	fim_4

#################################################################################
#	Verifica se o disparo acertou a nave 5					#
#	Retorna: $a1 =  5 se acertou, referente ao numero da nave		#
#		 $a3 = 1 se acertou						#
#################################################################################
verifica_acerto_nave_5:
	lb	$t4, destruida_5
	beq	$t4, 1, fim_5
	beq	$a3, 1, fim_5
	lw	$t0, disparo
	move	$t1, $zero
	move 	$a1, $zero
	move	$t2, $zero
acerto_5_loop:
	lw	$t3, nave_5($t2)
	seq	$t1, $t0, $t3
	beq	$t1, 1, fim_5
	addi	$t2, $t2, 4
	blt	$t2, 32, acerto_5_loop
fim_5:
	beq	$t1, 1, acerto_5
	jr	$ra
acerto_5:
	li	$a3, 1
	sb	$t1, destruida_5
	li	$t1, 0
	li	$a1, 5
	j	fim_5

#################################################################################
#	Verifica se o disparo acertou a nave 6					#
#	Retorna: $a1 = 6 se acertou, referente ao numero da nave		#
#		 $a3 = 1 se acertou						#
#################################################################################
verifica_acerto_nave_6:
	lb	$t4, destruida_6
	beq	$t4, 1, fim_6
	beq	$a3, 1, fim_6
	lw	$t0, disparo
	move	$t1, $zero
	move 	$a1, $zero
	move	$t2, $zero
acerto_6_loop:
	lw	$t3, nave_6($t2)
	seq	$t1, $t0, $t3
	beq	$t1, 1, fim_6
	addi	$t2, $t2, 4
	blt	$t2, 32, acerto_6_loop
fim_6:
	beq	$t1, 1, acerto_6
	jr	$ra
acerto_6:
	li	$a3, 1
	sb	$t1, destruida_6
	li	$t1, 0
	li	$a1, 6
	j	fim_6
	
#################################################################################
#	Verifica se o disparo acertou a nave 7					#
#	Retorna: $a1 = 7 se acertou, referente ao numero da nave		#
#		 $a3 = 1 se acertou						#
#################################################################################
verifica_acerto_nave_7:
	lb	$t4, destruida_7
	beq	$t4, 1, fim_7
	beq	$a3, 1, fim_7
	lw	$t0, disparo
	move	$t1, $zero
	move 	$a1, $zero
	move	$t2, $zero
acerto_7_loop:
	lw	$t3, nave_7($t2)
	seq	$t1, $t0, $t3
	beq	$t1, 1, fim_7
	addi	$t2, $t2, 4
	blt	$t2, 32, acerto_7_loop
fim_7:
	beq	$t1, 1, acerto_7
	jr	$ra
acerto_7:
	li	$a3, 1
	sb	$t1, destruida_7
	li	$t1, 0
	li	$a1, 7
	j	fim_7
	
#################################################################################
#	Limpa invasor dados pelos registradores $a1 e $a2			#
#################################################################################
limpa_invasor:
	move	$t2, $zero
	move	$t3, $zero
	lw	$t1, cor
	beq	$a1, 1, limpa_invasor_1_loop
	beq	$a1, 2, limpa_invasor_2_loop
	beq	$a1, 3, limpa_invasor_3_loop
	beq	$a1, 4, limpa_invasor_4_loop
	beq	$a1, 5, limpa_invasor_5_loop
	beq	$a1, 6, limpa_invasor_6_loop
	beq	$a1, 7, limpa_invasor_7_loop
limpa_invasor_1_loop:
	lw	$t3, nave_1($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 104, limpa_invasor_1_loop
	j	fim_limpa_invasor
limpa_invasor_2_loop:
	lw	$t3, nave_2($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 32, limpa_invasor_2_loop
	j	fim_limpa_invasor
limpa_invasor_3_loop:
	lw	$t3, nave_3($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 32, limpa_invasor_3_loop
	j	fim_limpa_invasor
limpa_invasor_4_loop:
	lw	$t3, nave_4($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 32, limpa_invasor_4_loop
	j	fim_limpa_invasor
limpa_invasor_5_loop:
	lw	$t3, nave_5($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 32, limpa_invasor_5_loop
	j	fim_limpa_invasor
limpa_invasor_6_loop:
	lw	$t3, nave_6($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 32, limpa_invasor_6_loop
	j	fim_limpa_invasor
limpa_invasor_7_loop:
	lw	$t3, nave_7($t2)
	sw	$t1, ($t3)
	addi	$t2, $t2, 4
	blt	$t2, 32, limpa_invasor_7_loop
fim_limpa_invasor:
	move	$a1, $zero
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
#	Funcao para dormir por 60ms						#
#################################################################################
sleep:
	li $v0 32 		# Syscall 32. Usa el Sleep de Java
	li $a0 60
	syscall
	jr	$ra
