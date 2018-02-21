#################################################################################
# Como iniciar: 0- Open MARS							#
#		1- Tools -> Bitmap Display					#
#		2- unit width in pixel: 8 / unit height in pixel: 8		#
#		3- Display Width in Pixels: 512 / Display Height in Pixels: 256	#
#		4- Tools -> Keyboard and Display				#
#		5- Connect to MIPS						#
#		6- Assemble and RUN						#
#################################################################################

#################################################################################
#	Includes								#
#################################################################################
.include	"barras.asm"
.include	"naves.asm"
.include	"macros.asm"
.include	"jogador.asm"

#################################################################################
#	Dados									#
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
nivel:		.byte  0

#################################################################################
#	MAIN	--	Space Invaders						#
#################################################################################
.text
.globl main
main:
	lb	$s0, nivel
	beq	$s0, 0, main_1
	beq	$s0, 1, main_loop_1
	beq	$s0, 2, main_loop_2
	beq	$s0, 3, main_loop_3

main_1:
	jal 	background
	jal	player
	jal	naves
	jal	pinta_naves_1
	jal	barras_1
	addi	$t0, $zero, 1
	sb	$t0, nivel
	
main_loop_1:
	sleep(60)
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
	jal	verifica_1
	lb	$s0, nivel
	beq	$s0, 2, main_2
	j	main_acerto

main_2:
	jal	naves
	jal	background
	jal	pinta_player
	jal	barras_2
	jal	pinta_naves_2
	sw	$zero, disparo
	move	$a1, $zero
	move	$a3, $zero

main_loop_2:
	sleep(45)
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
	jal	verifica_2
	lb	$s0, nivel
	beq	$s0, 3, main_3
	j	main_acerto
	
main_3:
	jal	naves
	jal	background
	jal	pinta_player
	jal	pinta_naves_3
	sw	$zero, disparo
	move	$a1, $zero
	move	$a3, $zero
	
main_loop_3:
	sleep(30)
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
	jal	verifica_3
	lb	$s0, nivel
	beq	$s0, 4, exit
	
main_acerto:
	beqz	$a3, main_direita
	jal	limpa_invasor
	move	$a1, $zero
	move	$a3, $zero
	
main_direita:
	bne	$v0, 0x01000000, main_esquerda
	jal	mover_direita
	j	main
	
main_esquerda:
	bne	$v0, 0x02000000, main_disparo
	jal	mover_esquerda
	j	main
	
main_disparo:
	bne	$v0, 0x03000000, main
	jal	verifica_disparo
	beq 	$a0, 1, main
	jal	disparar
	j	main

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
	exit()
