#problem 1
		.data
hello: 		.asciiz "Hello World!"		#All of your data will go at the top here under the .data section.
newline:	.asciiz "\n"




		.text
		li	$v0, 4     		#This is how to create a string and print it out to the system
		la	$a0, hello
		syscall
		
		li	$v0, 4
		la	$a0, newline     	#This is to add a space after hello world and the end sys call
		syscall
		
#problem 2
		
		li	$t0, 2
		li 	$t1, 4			#Practice problem
		li	$t2, 9				#loading numbers into registers
		add	$t0, $t0, $t1
		add	$t0, $t0, $t2
		
		li	$v0, 1
		move	$a0, $t0		#returning the sum to the console
		syscall
		
		li	$v0, 4
		la	$a0, newline     	#newLine
		syscall
		
		li	$t3, 2
		li	$t4, 5				#loading the numbers into the registers
		li	$t5, 10
		li	$t0, 0
		
		mult	$t3, $t5
		mflo	$t0
		add	$t0, $t4, $t0			#solving the problem
		sub	$t0, $t0, $t3
		
		li	$v0, 1				#returning the sum to the console
		move	$a0, $t0
		syscall
		
#problem 3
		move	$t0, $zero
		move	$t1, $zero
		move	$t2, $zero			#clearing all the registers
		move	$t3, $zero
		move	$t4, $zero
		move	$t5, $zero
		
		
		
exit1:		li	$v0, 10  		 #this is to exit (stop the code). It goes at the very end of all of your stuff
		syscall

