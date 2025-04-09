		.data
		
prompt:		.asciiz "Would you like to see a magic trick. Pick a valid number from 0 to 65,535 and I will read your mind: "
newline:	.asciiz "\n"
congratsPrompt:	.asciiz "Is this your number: "
magic:		.asciiz "~Magic~"
buffer:		.space 10

		.text
		
		la	$t1, buffer 		#$t1 has the address of the first element in the array
				
retry:		li 	$v0, 4
		la 	$a0, prompt 		#prints number prompt
		syscall
		
		li 	$v0, 8 	
		la 	$a0, buffer		#read string syscall
		la	$a1, buffer		#maximum number of characters that can be read being set
		syscall

validLoop:    	lbu     $t2, ($t1)		#loads first location of address of buffer array
       		beqz    $t2, startMathLoop	#goes to mathLoop when array is empty
        	sltiu   $t5, $t2, 10		#checks to see if ascii 10 was entered
        	bnez    $t5, retry		#loops to retry if outside of range
        	sltiu   $t5, $t2, 58		#checks to see if anyhing is above ascii 58
        	beqz    $t5, retry		#loops to retry if outside of range
        	addiu   $t1, $t1, 1		#adds one to the address
        	j    validLoop			#restarting the loop

startMathLoop:	li 	$t0, 0 			#initialized to 0
		li	$t3, 10			#Setting up equation
		la	$t1, buffer		#loading address of user input		
mathLoop:	lbu	$t2, ($t1)		#loading the first byte	
		beqz	$t2, subtractEnter	#initiating loop/Moving to print if constraints are met
		multu  	$t0, $t3		#multiplying
		mflo	$t0			#moving the result from low register to $t0
		addu 	$t0, $t0, $t2		#adding
		subiu	$t0, $t0, 48		#subtracting
		sb	$t0, ($t1)		#storing the new number into register
		addiu	$t1, $t1, 1		#incrementing address
		j	mathLoop		#restarting the loop
				
subtractEnter:	add	$t0, $t0, 48		#adds 48 to $t0
		sub	$t0, $t0, $t2		#subtracts $t2 from $t0
		div	$t0, $t3		#divides %t0 and $t3
		mflo	$t0			#moving the result from low register to $t0
		sub	$t0, $t0, 1		#subtracts 1 from $t0 since number si always over by one

sizeCheck:	
		bgtu	$t0, 65535, retry		
		
print:		
		li	$v0, 4
		la	$a0, newline     	#adding new line to make it easier to check numbers
		syscall
		 
		li	$v0, 4
		la	$a0, newline     	#adding new line to make it easier to check numbers
		syscall
		 
		li 	$v0, 4
		la 	$a0, congratsPrompt	#prints prompt
		syscall

		li 	$v0, 1
		move	$a0, $t0		#prints prompt
		syscall
		
		li	$v0, 4
		la	$a0, newline     	#adding new line to make it easier to check numbers
		syscall
		
		li	$v0, 4
		la	$a0, newline     	#adding new line to make it easier to check numbers
		syscall
		
		li 	$v0, 4
		la 	$a0, magic		#prints prompt
		syscall
		
		li	$v0, 4
		la	$a0, newline     	#adding new line to make it easier to check numbers
		syscall
		
exit:		li	$v0, 10			#exit
		syscall
		
