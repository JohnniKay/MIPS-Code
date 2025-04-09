#Problem 5	

	.text
	
	li	$t0, 0	#accumulator
	li	$t1, 0  #i loop
	li 	$t2, 0  #j loop
	
loop1:	beq	$t2, 5, print		#loop j
	add	$t2, $t2, 1		#adding 1 to loop j
	add	$t0, $t0, 1		#adding 1 to accumulator
	move	$t1, $zero		#clearing the register of i
	
loop2:	beq	$t1, 3, loop1		#loop i
	add	$t1, $t1, 1 		#adding 1 to loop i
	add	$t0, $t0, 2		#adding 2 to accumulator
	j	loop2		
	
print:	li	$v0, 1
	move	$a0, $t0		#printing accumulator to console
	syscall



exit:	li	$v0, 10			#exiting the program
	syscall