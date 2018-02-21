#################################################################################
#	Macros do jogo Space Invaders						#
#################################################################################
.macro sleep(%time)
	li 	$v0 32 		
	li 	$a0 %time
	syscall
.end_macro

.macro exit()
	li 	$v0 10
	syscall
.end_macro