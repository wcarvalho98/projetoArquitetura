#################################################################################
#	Main do disparo1_1							#
#################################################################################
main_disparo1_1:
	move	$t7, $ra
	lb	$t0, destruida_1
	bnez	$t0, fim_main_disparo1_1
	jal	verifica_disparo1_1
	bnez 	$a0, main_d1_1
	jal	disparar1_1
	jal	pinta_disparo1_1
fim_main_disparo1_1:
	jr	$t7
main_d1_1:
	jal	limpa_disparo1_1
	jal	mover_disparo1_1
	jal	pinta_disparo1_1
	j	fim_main_disparo1_1
	
#################################################################################
#	Main do disparo1_2							#
#################################################################################
main_disparo1_2:
	move	$t7, $ra
	lb	$t0, destruida_1
	bnez	$t0, fim_main_disparo1_2
	jal	verifica_disparo1_2
	bnez 	$a0, main_d1_2
	jal	disparar1_2
	jal	pinta_disparo1_2
fim_main_disparo1_2:
	jr	$t7
main_d1_2:
	jal	limpa_disparo1_2
	jal	mover_disparo1_2
	jal	pinta_disparo1_2
	j	fim_main_disparo1_2
	
#################################################################################
#	Main do disparo_2							#
#################################################################################
main_disparo_2:
	move	$t7, $ra
	lb	$t0, destruida_2
	bnez	$t0, fim_main_disparo_2
	jal	verifica_disparo_2
	bnez 	$a0, main_d_2
	jal	disparar_2
	jal	pinta_disparo_2
fim_main_disparo_2:
	jr	$t7
main_d_2:
	jal	limpa_disparo_2
	jal	mover_disparo_2
	jal	pinta_disparo_2
	j	fim_main_disparo_2
		
#################################################################################
#	Main do disparo_3							#
#################################################################################
main_disparo_3:
	move	$t7, $ra
	lb	$t0, destruida_3
	bnez	$t0, fim_main_disparo_3
	jal	verifica_disparo_3
	bnez 	$a0, main_d_3
	jal	disparar_3
	jal	pinta_disparo_3
fim_main_disparo_3:
	jr	$t7
main_d_3:
	jal	limpa_disparo_3
	jal	mover_disparo_3
	jal	pinta_disparo_3
	j	fim_main_disparo_3
	
#################################################################################
#	Main do disparo_4							#
#################################################################################
main_disparo_4:
	move	$t7, $ra
	lb	$t0, destruida_4
	bnez	$t0, fim_main_disparo_4
	jal	verifica_disparo_4
	bnez 	$a0, main_d_4
	jal	disparar_4
	jal	pinta_disparo_4
fim_main_disparo_4:
	jr	$t7
main_d_4:
	jal	limpa_disparo_4
	jal	mover_disparo_4
	jal	pinta_disparo_4
	j	fim_main_disparo_4
	
#################################################################################
#	Main do disparo_5							#
#################################################################################
main_disparo_5:
	move	$t7, $ra
	lb	$t0, destruida_5
	bnez	$t0, fim_main_disparo_5
	jal	verifica_disparo_5
	bnez 	$a0, main_d_5
	jal	disparar_5
	jal	pinta_disparo_5
fim_main_disparo_5:
	jr	$t7
main_d_5:
	jal	limpa_disparo_5
	jal	mover_disparo_5
	jal	pinta_disparo_5
	j	fim_main_disparo_5
	
#################################################################################
#	Main do disparo_6							#
#################################################################################
main_disparo_6:
	move	$t7, $ra
	lb	$t0, destruida_6
	bnez	$t0, fim_main_disparo_6
	jal	verifica_disparo_6
	bnez 	$a0, main_d_6
	jal	disparar_6
	jal	pinta_disparo_6
fim_main_disparo_6:
	jr	$t7
main_d_6:
	jal	limpa_disparo_6
	jal	mover_disparo_6
	jal	pinta_disparo_6
	j	fim_main_disparo_6
	
#################################################################################
#	Main do disparo_7							#
#################################################################################
main_disparo_7:
	move	$t7, $ra
	lb	$t0, destruida_7
	bnez	$t0, fim_main_disparo_7
	jal	verifica_disparo_7
	bnez 	$a0, main_d_7
	jal	disparar_7
	jal	pinta_disparo_7
fim_main_disparo_7:
	jr	$t7
main_d_7:
	jal	limpa_disparo_7
	jal	mover_disparo_7
	jal	pinta_disparo_7
	j	fim_main_disparo_7
	
#################################################################################
#	Verifica acerto inimigo na barra nivel 1				#
#################################################################################
verifica_barra_inimigo_1:
	move	$t7, $ra
	jal	verifica_acerto_inimigo_barra_1
	move	$t0, $s4
	beq	$t0, 0, fim_verifica_barra_inimigo_1
	beq	$t0, 1, a1_1
	beq	$t0, 2, a1_2
	beq	$t0, 3, a_2
	beq	$t0, 4, a_3
	bgt	$t0, 4, fim_verifica_barra_inimigo_1
a1_1:
	jal	limpa_disparo1_1
	sw	$zero, disparo1_1
	j	fim_verifica_barra_inimigo_1
a1_2:
	jal	limpa_disparo1_2
	sw	$zero, disparo1_2
	j	fim_verifica_barra_inimigo_1
a_2:
	jal	limpa_disparo_2
	sw	$zero, disparo_2
	j	fim_verifica_barra_inimigo_1
a_3:
	jal	limpa_disparo_3
	sw	$zero, disparo_3
fim_verifica_barra_inimigo_1:
	jr	$t7
	
#################################################################################
#	Verifica acerto inimigo na barra 1 nivel 2				#
#################################################################################
verifica_barra_inimigo_2_1:
	move	$t7, $ra
	jal	verifica_acerto_inimigo_barra_2_1
	move	$t0, $s4
	beq	$t0, 0, fim_verifica_barra_inimigo_2_1
	beq	$t0, 1, b1_1
	beq	$t0, 2, b1_2
	beq	$t0, 3, b_2
	beq	$t0, 4, b_3
	beq	$t0, 5, b_4
	beq	$t0, 6, b_5
b1_1:
	jal	limpa_disparo1_1
	sw	$zero, disparo1_1
	j	fim_verifica_barra_inimigo_2_1
b1_2:
	jal	limpa_disparo1_2
	sw	$zero, disparo1_2
	j	fim_verifica_barra_inimigo_2_1
b_2:
	jal	limpa_disparo_2
	sw	$zero, disparo_2
	j	fim_verifica_barra_inimigo_2_1
b_3:
	jal	limpa_disparo_3
	sw	$zero, disparo_3
	j	fim_verifica_barra_inimigo_2_1
b_4:
	jal	limpa_disparo_4
	sw	$zero, disparo_4
	j	fim_verifica_barra_inimigo_2_1
b_5:
	jal	limpa_disparo_5
	sw	$zero, disparo_5
fim_verifica_barra_inimigo_2_1:
	jr	$t7

#################################################################################
#	Verifica acerto inimigo na barra 2 nivel 2				#
#################################################################################
verifica_barra_inimigo_2_2:
	move	$t7, $ra
	jal	verifica_acerto_inimigo_barra_2_2
	move	$t0, $s4
	beq	$t0, 0, fim_verifica_barra_inimigo_2_2
	beq	$t0, 1, c1_1
	beq	$t0, 2, c1_2
	beq	$t0, 3, c_2
	beq	$t0, 4, c_3
	beq	$t0, 5, c_4
	beq	$t0, 6, c_5
c1_1:
	jal	limpa_disparo1_1
	sw	$zero, disparo1_1
	j	fim_verifica_barra_inimigo_2_2
c1_2:
	jal	limpa_disparo1_2
	sw	$zero, disparo1_2
	j	fim_verifica_barra_inimigo_2_2
c_2:
	jal	limpa_disparo_2
	sw	$zero, disparo_2
	j	fim_verifica_barra_inimigo_2_2
c_3:
	jal	limpa_disparo_3
	sw	$zero, disparo_3
	j	fim_verifica_barra_inimigo_2_2
c_4:
	jal	limpa_disparo_4
	sw	$zero, disparo_4
	j	fim_verifica_barra_inimigo_2_2
c_5:
	jal	limpa_disparo_5
	sw	$zero, disparo_5
fim_verifica_barra_inimigo_2_2:
	jr	$t7