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
#	Pintando barras do nivel 1						#
#################################################################################
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
	
#################################################################################
#	Pintando barras do nivel 2						#
#################################################################################
barras_2:
	# Primeira barra
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
	
	# Segunda barra
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
	
#################################################################################
#	Pintando a área reservada a indicação de nível				#
#################################################################################
espaco_reservado:
	lw	$t0, bitmap_address
	addi	$t1, $zero, 0x00000000
	sw	$t1, 252($t0)
	sw	$t1, 508($t0)
	sw	$t1, 764($t0)
	sw	$t1, 1020($t0)
	sw	$t1, 1276($t0)
	sw	$t1, 1532($t0)
	sw	$t1, 1788($t0)
	jr	$ra
	
#################################################################################
#	Pintando o nivel 1							#
#################################################################################
pinta_nivel_1:
	lw	$t0, bitmap_address
	addi	$t1, $zero, 0x00F0E68C
	sw	$t1, 508($t0)
	jr	$ra

#################################################################################
#	Pintando o nivel 2							#
#################################################################################
pinta_nivel_2:
	lw	$t0, bitmap_address
	addi	$t1, $zero, 0x00FFFF00
	sw	$t1, 1020($t0)
	jr	$ra

#################################################################################
#	Pintando o nivel 3							#
#################################################################################
pinta_nivel_3:
	lw	$t0, bitmap_address
	addi	$t1, $zero, 0x00FFD700
	sw	$t1, 1532($t0)
	jr	$ra
	
#################################################################################
#	Pintando o background de preto						#
#################################################################################
preto:
	lw	$t0, bitmap_address
	move	$t1, $zero
	lw	$t2, bitmap_size
	move	$t3, $zero
preto_loop:
	sll	$t4, $t3, 2
	add	$t4, $t4, $t0
	sw	$t1, 0($t4)
	addi	$t3, $t3, 1
	blt	$t3, $t2, preto_loop
	jr	$ra
	
#################################################################################
#	Pintando o game over							#
#################################################################################
game_over:
	lw	$t0, bitmap_address
	addi	$t1, $zero, 0x00FF0000
	#Pintando o G
	sw	$t1, 1036($t0)
	sw	$t1, 1040($t0)
	sw	$t1, 1044($t0)
	sw	$t1, 1048($t0)
	sw	$t1, 1292($t0)
	sw	$t1, 1296($t0)
	sw	$t1, 1300($t0)
	sw	$t1, 1304($t0)
	sw	$t1, 1544($t0)
	sw	$t1, 1800($t0)
	sw	$t1, 2056($t0)
	sw	$t1, 2312($t0)
	sw	$t1, 2568($t0)
	sw	$t1, 2824($t0)
	sw	$t1, 3080($t0)
	sw	$t1, 3336($t0)
	sw	$t1, 3592($t0)
	sw	$t1, 3848($t0)
	sw	$t1, 4104($t0)
	sw	$t1, 4360($t0)
	sw	$t1, 4616($t0)
	sw	$t1, 4872($t0)
	sw	$t1, 5128($t0)
	sw	$t1, 5388($t0)
	sw	$t1, 5392($t0)
	sw	$t1, 5396($t0)
	sw	$t1, 5400($t0)
	sw	$t1, 5644($t0)
	sw	$t1, 5648($t0)
	sw	$t1, 5652($t0)
	sw	$t1, 5656($t0)
	sw	$t1, 3856($t0)	
	sw	$t1, 3860($t0) 
	sw	$t1, 3864($t0)
	sw	$t1, 4112($t0)
	sw	$t1, 4116($t0)
	sw	$t1, 4120($t0)
	sw	$t1, 4376($t0) 
	sw	$t1, 4632($t0)
	sw	$t1, 4888($t0)
	sw	$t1, 5144($t0)
	# Pintando o A
	sw	$t1, 1056($t0)
	sw	$t1, 1060($t0)
	sw	$t1, 1064($t0)
	sw	$t1, 1068($t0)
	sw	$t1, 1072($t0)
	sw	$t1, 1312($t0)
	sw	$t1, 1316($t0)
	sw	$t1, 1320($t0)
	sw	$t1, 1324($t0)
	sw	$t1, 1328($t0)
	sw	$t1, 1568($t0)
	sw	$t1, 1824($t0)
	sw	$t1, 2080($t0)
	sw	$t1, 2336($t0)
	sw	$t1, 2592($t0)
	sw	$t1, 2848($t0)
	sw	$t1, 3104($t0)
	sw	$t1, 3360($t0)
	sw	$t1, 3616($t0)
	sw	$t1, 3872($t0)
	sw	$t1, 4128($t0)
	sw	$t1, 4384($t0)
	sw	$t1, 4640($t0)
	sw	$t1, 4896($t0)
	sw	$t1, 5152($t0)
	sw	$t1, 5408($t0)
	sw	$t1, 5664($t0)
	sw	$t1, 1584($t0)
	sw	$t1, 1840($t0)
	sw	$t1, 2096($t0)
	sw	$t1, 2352($t0)
	sw	$t1, 2608($t0)	
	sw	$t1, 2864($t0) 
	sw	$t1, 3120($t0)
	sw	$t1, 3376($t0)
	sw	$t1, 3632($t0)
	sw	$t1, 3888($t0)
	sw	$t1, 4144($t0) 
	sw	$t1, 4400($t0)
	sw	$t1, 4656($t0)
	sw	$t1, 4912($t0)	
	sw	$t1, 5168($t0) 
	sw	$t1, 5424($t0)
	sw	$t1, 5680($t0)
	sw	$t1, 3108($t0)
	sw	$t1, 3112($t0)
	sw	$t1, 3116($t0) 
	sw	$t1, 3364($t0)
	sw	$t1, 3368($t0)
	sw	$t1, 3372($t0)
	# Pintando o M
	sw	$t1, 1080($t0)
	sw	$t1, 1336($t0)
	sw	$t1, 1592($t0)
	sw	$t1, 1848($t0)
	sw	$t1, 2104($t0)
	sw	$t1, 2360($t0)
	sw	$t1, 2616($t0)
	sw	$t1, 2872($t0)
	sw	$t1, 3128($t0)
	sw	$t1, 3384($t0)
	sw	$t1, 3640($t0)
	sw	$t1, 3896($t0)
	sw	$t1, 4152($t0)
	sw	$t1, 4408($t0)
	sw	$t1, 4664($t0)
	sw	$t1, 4920($t0)
	sw	$t1, 5176($t0)
	sw	$t1, 5432($t0)
	sw	$t1, 5688($t0)
	sw	$t1, 1084($t0)
	sw	$t1, 1340($t0)
	sw	$t1, 1596($t0)
	sw	$t1, 1852($t0)
	sw	$t1, 2108($t0)
	sw	$t1, 2364($t0)
	sw	$t1, 2620($t0)
	sw	$t1, 2876($t0)
	sw	$t1, 3132($t0)
	sw	$t1, 3388($t0)
	sw	$t1, 3644($t0)
	sw	$t1, 3900($t0)
	sw	$t1, 4156($t0)	
	sw	$t1, 4412($t0) 
	sw	$t1, 4668($t0)
	sw	$t1, 4924($t0)
	sw	$t1, 5180($t0)
	sw	$t1, 5436($t0)
	sw	$t1, 5692($t0) 
	sw	$t1, 1112($t0)
	sw	$t1, 1368($t0)
	sw	$t1, 1624($t0)	
	sw	$t1, 1880($t0) 
	sw	$t1, 2136($t0)
	sw	$t1, 2392($t0)
	sw	$t1, 2648($t0)
	sw	$t1, 2904($t0)
	sw	$t1, 3160($t0) 
	sw	$t1, 3416($t0)
	sw	$t1, 3672($t0)
	sw	$t1, 3928($t0)
	sw	$t1, 4184($t0)
	sw	$t1, 4440($t0)
	sw	$t1, 4696($t0)
	sw	$t1, 4952($t0)
	sw	$t1, 5208($t0)
	sw	$t1, 5464($t0)
	sw	$t1, 5720($t0)
	sw	$t1, 1116($t0)
	sw	$t1, 1372($t0)
	sw	$t1, 1628($t0)
	sw	$t1, 1884($t0)
	sw	$t1, 2140($t0)
	sw	$t1, 2396($t0)
	sw	$t1, 2652($t0)
	sw	$t1, 2908($t0)
	sw	$t1, 3164($t0)
	sw	$t1, 3420($t0)
	sw	$t1, 3676($t0)
	sw	$t1, 3932($t0)
	sw	$t1, 4188($t0)
	sw	$t1, 4444($t0)
	sw	$t1, 4700($t0)
	sw	$t1, 4956($t0)
	sw	$t1, 5212($t0)
	sw	$t1, 5468($t0)
	sw	$t1, 5724($t0)
	sw	$t1, 1088($t0)
	sw	$t1, 1344($t0)
	sw	$t1, 1348($t0)
	sw	$t1, 1604($t0)
	sw	$t1, 1608($t0)
	sw	$t1, 1864($t0)	
	sw	$t1, 2120($t0) 
	sw	$t1, 2376($t0)
	sw	$t1, 1612($t0)
	sw	$t1, 1868($t0)
	sw	$t1, 2124($t0)
	sw	$t1, 2380($t0) 
	sw	$t1, 1616($t0)
	sw	$t1, 1360($t0)
	sw	$t1, 1364($t0)	
	sw	$t1, 1108($t0)
	# Pintando o E
	sw	$t1, 1124($t0)
	sw	$t1, 1380($t0)
	sw	$t1, 1636($t0)
	sw	$t1, 1892($t0)
	sw	$t1, 2148($t0)
	sw	$t1, 2404($t0)
	sw	$t1, 2660($t0)
	sw	$t1, 2916($t0)
	sw	$t1, 3172($t0)
	sw	$t1, 3428($t0)
	sw	$t1, 3684($t0)
	sw	$t1, 3940($t0)
	sw	$t1, 4196($t0)
	sw	$t1, 4452($t0)
	sw	$t1, 4708($t0)
	sw	$t1, 4964($t0)
	sw	$t1, 5220($t0)
	sw	$t1, 5476($t0)
	sw	$t1, 5732($t0)
	sw	$t1, 1128($t0)
	sw	$t1, 1132($t0)
	sw	$t1, 1136($t0)
	sw	$t1, 1140($t0)
	sw	$t1, 3432($t0)
	sw	$t1, 3436($t0)
	sw	$t1, 3440($t0)
	sw	$t1, 3444($t0)
	sw	$t1, 5736($t0)
	sw	$t1, 5740($t0)
	sw	$t1, 5744($t0)
	sw	$t1, 5748($t0)
	# Pintando o O
	sw	$t1, 1408($t0)
	sw	$t1, 1664($t0)
	sw	$t1, 1920($t0)
	sw	$t1, 2176($t0)
	sw	$t1, 2432($t0)
	sw	$t1, 2688($t0)
	sw	$t1, 2944($t0)
	sw	$t1, 3200($t0)
	sw	$t1, 3456($t0)
	sw	$t1, 3712($t0)
	sw	$t1, 3968($t0)
	sw	$t1, 4224($t0)
	sw	$t1, 4480($t0)
	sw	$t1, 4736($t0)
	sw	$t1, 4992($t0)
	sw	$t1, 5248($t0)
	sw	$t1, 5504($t0)
	sw	$t1, 1424($t0)
	sw	$t1, 1680($t0)
	sw	$t1, 1936($t0)
	sw	$t1, 2192($t0)
	sw	$t1, 2448($t0)
	sw	$t1, 2704($t0)
	sw	$t1, 2960($t0)
	sw	$t1, 3216($t0)
	sw	$t1, 3472($t0)
	sw	$t1, 3728($t0)
	sw	$t1, 3984($t0)
	sw	$t1, 4240($t0)
	sw	$t1, 4496($t0)
	sw	$t1, 4752($t0)
	sw	$t1, 5008($t0)
	sw	$t1, 5264($t0)
	sw	$t1, 5520($t0)
	sw	$t1, 1156($t0)
	sw	$t1, 1160($t0)
	sw	$t1, 1164($t0)
	sw	$t1, 5764($t0)
	sw	$t1, 5768($t0)
	sw	$t1, 5772($t0)
	# Pintando o V
	sw	$t1, 1176($t0)
	sw	$t1, 1432($t0)
	sw	$t1, 1688($t0)
	sw	$t1, 1944($t0)
	sw	$t1, 2200($t0)
	sw	$t1, 2456($t0)
	sw	$t1, 2712($t0)
	sw	$t1, 2716($t0)
	sw	$t1, 2972($t0)
	sw	$t1, 3228($t0)
	sw	$t1, 3484($t0)
	sw	$t1, 3740($t0)
	sw	$t1, 3996($t0)
	sw	$t1, 4252($t0)
	sw	$t1, 4256($t0)
	sw	$t1, 4512($t0)
	sw	$t1, 4768($t0)
	sw	$t1, 5024($t0)
	sw	$t1, 5280($t0)
	sw	$t1, 5536($t0)
	sw	$t1, 5792($t0)
	sw	$t1, 1192($t0)
	sw	$t1, 1448($t0)
	sw	$t1, 1704($t0)
	sw	$t1, 1960($t0)
	sw	$t1, 2216($t0)
	sw	$t1, 2472($t0)
	sw	$t1, 2728($t0)
	sw	$t1, 2724($t0)
	sw	$t1, 2980($t0)
	sw	$t1, 3236($t0)
	sw	$t1, 3492($t0)
	sw	$t1, 3748($t0)
	sw	$t1, 4004($t0)
	sw	$t1, 4260($t0)
	# Pintando o E
	sw	$t1, 1200($t0)
	sw	$t1, 1456($t0)
	sw	$t1, 1712($t0)
	sw	$t1, 1968($t0)
	sw	$t1, 2224($t0)
	sw	$t1, 2480($t0)
	sw	$t1, 2736($t0)
	sw	$t1, 2992($t0)
	sw	$t1, 3248($t0)
	sw	$t1, 3504($t0)
	sw	$t1, 3760($t0)
	sw	$t1, 4016($t0)
	sw	$t1, 4272($t0)
	sw	$t1, 4528($t0)
	sw	$t1, 4784($t0)
	sw	$t1, 5040($t0)
	sw	$t1, 5296($t0)
	sw	$t1, 5552($t0)
	sw	$t1, 5808($t0)
	sw	$t1, 1204($t0)
	sw	$t1, 1208($t0)
	sw	$t1, 1212($t0)
	sw	$t1, 1216($t0)
	sw	$t1, 3508($t0)
	sw	$t1, 3512($t0)
	sw	$t1, 3516($t0)
	sw	$t1, 3520($t0)
	sw	$t1, 5812($t0)
	sw	$t1, 5816($t0)
	sw	$t1, 5820($t0)
	sw	$t1, 5824($t0)
	# Pintando o R
	sw	$t1, 1224($t0)
	sw	$t1, 1480($t0)
	sw	$t1, 1736($t0)
	sw	$t1, 1992($t0)
	sw	$t1, 2248($t0)
	sw	$t1, 2504($t0)
	sw	$t1, 2760($t0)
	sw	$t1, 3016($t0)
	sw	$t1, 3272($t0)
	sw	$t1, 3528($t0)
	sw	$t1, 3784($t0)
	sw	$t1, 4040($t0)
	sw	$t1, 4296($t0)
	sw	$t1, 4552($t0)
	sw	$t1, 4808($t0)
	sw	$t1, 5064($t0)
	sw	$t1, 5320($t0)
	sw	$t1, 5576($t0)
	sw	$t1, 5832($t0)
	sw	$t1, 1228($t0)
	sw	$t1, 1232($t0)
	sw	$t1, 1236($t0)
	sw	$t1, 1240($t0)
	sw	$t1, 1496($t0)
	sw	$t1, 1752($t0)
	sw	$t1, 2008($t0)
	sw	$t1, 2264($t0)
	sw	$t1, 2520($t0)
	sw	$t1, 2776($t0)
	sw	$t1, 3032($t0)
	sw	$t1, 3288($t0)
	sw	$t1, 3544($t0)
	sw	$t1, 3532($t0)
	sw	$t1, 3536($t0)
	sw	$t1, 3540($t0)
	sw	$t1, 3788($t0)
	sw	$t1, 4044($t0)
	sw	$t1, 4300($t0)
	sw	$t1, 4304($t0)
	sw	$t1, 4560($t0)
	sw	$t1, 4816($t0)
	sw	$t1, 4820($t0)
	sw	$t1, 5076($t0)
	sw	$t1, 5332($t0)
	sw	$t1, 5336($t0)
	sw	$t1, 5592($t0)
	sw	$t1, 5848($t0)
	# Pintando a caveira UHAUHUAHUAH
	sw	$t1, 1252($t0)
	sw	$t1, 1256($t0)
	sw	$t1, 1260($t0)
	sw	$t1, 1264($t0)
	sw	$t1, 1504($t0)
	sw	$t1, 1508($t0)
	sw	$t1, 1512($t0)
	sw	$t1, 1516($t0)
	sw	$t1, 1520($t0)
	sw	$t1, 1524($t0)
	sw	$t1, 1760($t0)
	sw	$t1, 1768($t0)
	sw	$t1, 1772($t0)
	sw	$t1, 1780($t0)
	sw	$t1, 2016($t0)
	sw	$t1, 2024($t0)
	sw	$t1, 2028($t0)
	sw	$t1, 2036($t0)
	sw	$t1, 2272($t0)
	sw	$t1, 2276($t0)
	sw	$t1, 2280($t0)
	sw	$t1, 2284($t0)
	sw	$t1, 2288($t0)
	sw	$t1, 2292($t0)
	sw	$t1, 2528($t0)
	sw	$t1, 2532($t0)
	sw	$t1, 2536($t0)
	sw	$t1, 2540($t0)
	sw	$t1, 2544($t0)
	sw	$t1, 2548($t0)
	sw	$t1, 2788($t0)
	sw	$t1, 2792($t0)
	sw	$t1, 2796($t0)
	sw	$t1, 2800($t0)
	sw	$t1, 3044($t0)
	sw	$t1, 3048($t0)
	sw	$t1, 3052($t0)
	sw	$t1, 3056($t0)
	sw	$t1, 3300($t0)
	sw	$t1, 3304($t0)
	sw	$t1, 3308($t0)
	sw	$t1, 3312($t0)
	sw	$t1, 3556($t0)
	sw	$t1, 3568($t0)
	sw	$t1, 4064($t0)
	sw	$t1, 4084($t0)
	sw	$t1, 4320($t0)
	sw	$t1, 4340($t0)
	sw	$t1, 4576($t0)
	sw	$t1, 4580($t0)
	sw	$t1, 4592($t0)
	sw	$t1, 4596($t0)
	sw	$t1, 4840($t0)
	sw	$t1, 4844($t0)
	sw	$t1, 5096($t0)
	sw	$t1, 5100($t0)
	sw	$t1, 5344($t0)
	sw	$t1, 5348($t0)
	sw	$t1, 5360($t0)
	sw	$t1, 5364($t0)
	sw	$t1, 5600($t0)
	sw	$t1, 5620($t0)
	sw	$t1, 5856($t0)
	sw	$t1, 5876($t0)
	jr	$ra