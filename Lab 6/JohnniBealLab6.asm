		.data
userInput:	.asciiz "Enter a real number: "
wholeNumber:	.asciiz "Whole Number: "
decimalNumber:	.asciiz "Decimal Number: "
sum:		.asciiz "The sum of the two numbers is: "
buffer:		.space 10
newline:	.asciiz "\n"

		.text
		
begin:		la	$t1, buffer 		#$t0 has the address of the first element in the array		
		
		li 	$v0, 4
		la 	$a0, userInput 		#prints number prompt
		syscall
		
		li 	$v0, 8 	
		la 	$a0, buffer		#read string syscall
		la	$a1, buffer		#maximum number of characters that can be read being set
		syscall
		
		li	$t7, 0			#Counter for decimal place
		li	$t6, 15
		li 	$t0, 0 			#initialized to 0
		li	$t3, 10			#Setting up equation
		la	$t1, buffer		#loading address of user input	
		
mathLoop:	lbu	$t2, ($t1)		#loading the first byte	
		beq	$t2, 46, decimal	#initiating loop/Moving to print if constraints are met
		beqz	$t2, subtractEnter	#initiating loop/Moving to print if constraints are met
		multu  	$t0, $t3		#multiplying
		mflo	$t0			#moving the result from low register to $t0
		addu 	$t0, $t0, $t2		#adding
		subiu	$t0, $t0, 48		#subtracting
		addiu	$t1, $t1, 1		#incrementing address
		addi	$t7, $t7, 1		#incrementing decimal counter
		j	mathLoop		#restarting the loop

decimal:	move	$t4, $t0		#storing whole number into $t4
		li	$t0, 0			#Sets $t0 back to 0
		li	$t7, 0			#Setting decimal counter back to 0
		addiu	$t1, $t1, 1		#incrementing address
		jal	mathLoop				
												
subtractEnter:	add	$t0, $t0, 48		#adds 48 to $t0
		sub	$t0, $t0, $t2		#subtracts $t2 from $t0
		div	$t0, $t3		#divides %t0 and $t3
		mflo	$t0			#moving the result from low register to $t0
		sub	$t0, $t0, 1
		
		add	$s5, $s5, 1		#adding one to the prompt counter
		beq	$s5, 2, addFunc
		move	$s1, $t0		#moving $t0 to $s1
		move	$s2, $t4		#moving $t4 to $s2
wholeConvert:	
		blt 	$t6, 0, binaryConvert
		srlv 	$t2, $t4, $t6 		#shift the bit to right most position
		and 	$t2, 1 			#extract the bit by ANDING 1 with it
						
		
		li 	$v0, 1
		move 	$a0, $t2		#display the extracted bit
		syscall
		sub	$t6, $t6, 1		#decrement the bit no.
		b wholeConvert	
		
binaryConvert:	li	$t6, 15

		li	$v0, 4
		la	$a0, newline     	#adding new line to make it easier to check numbers
		syscall
		 
		li	$v0, 4
		la	$a0, newline     	#adding new line to make it easier to check numbers
		syscall
loop:
		blt 	$t6, 0, convert
		add	$t7, $t7, 1		#adds one to the decimal counter
		srlv 	$t5, $t0, $t6 		#shift the bit to right most position
		and 	$t5, 1 			#extract the bit by ANDING 1 with it
		
		
		li 	$v0, 1
		move 	$a0, $t5		#display the extracted bit
		syscall
		
		sub	$t6, $t6, 1		#decrement the bit no.
		b loop	

convert:	sll	$t4, $t4, 8		#shifting whole number by 16 bits		
		sll	$t4, $t4, 8		#shifting decimal by 16 bits
		add	$s6, $s6, 1		#adds 1 to print counter
		
divloop:	
		blt	$t7, 0, print		#loop to coutn down decimal place
		divu	$t0, $t3		#dividing shifted decimal by 10
		sub	$t7, $t7, 1		#subtracting one from the decimal counter		
		j	divloop			#loop
						
		
print:		add	$t4, $t4, $t0
		sll	$t4, $t4, 8
		beq	$s6, 2, print2
		li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall

        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
		
		
		
        	li     	$v0, 35
        	move   	$a0, $t4        	#display the extracted bit
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	jal	begin

addFunc:	add	$t0, $s1, $t0
		add	$t4, $s2, $t4		#adding both whole numbers together
		
		
					
print2:		li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
		
		li     	$v0, 35
        	move   	$a0, $t4        	#display the extracted bit
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
		
		li     	$v0, 35
        	move   	$a0, $t0        	#display the extracted bit
        	syscall
		
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
		
		sll	$t4, $t4, 8		#shifting whole number by 16 bits
		add	$t4, $t4, $t0
		sll	$t4, $t4, 8
		
		li 	$v0, 4
		la 	$a0, sum 		#prints number prompt
		syscall
		
        	li     	$v0, 35
        	move   	$a0, $t4        	#display the extracted bit
        	syscall
        	

		li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall

				
exit:		li	$v0, 10			#exit
		syscall
