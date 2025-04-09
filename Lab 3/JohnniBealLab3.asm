		.data
		
promptSize:	.asciiz "Please enter the number of coordinates: \n"
prompt:		.asciiz "Please enter a coordinate: \n"
promptKey:	.asciiz "Please enter a number between 1 and 9 for your key: \n"
plainText:	.space 10
newline:	.asciiz "\n"

		.text
		
		la	$t1, plainText 		#$t1 has the address of the first element inthe array of cooridinates
		
		li	$v0, 4
		la	$a0, promptSize		#promt for how many coordinates are chosen
		syscall
		
		li	$v0,	5		#syscall for reading user inpout for number of coordinates
		syscall
		
		move	$t0, $v0		#moving the user input to $t0
		
		
userKey:	li	$v0, 4
		la	$a0, promptKey		#syscall for printing the prompt asking for key
		syscall
		
		li	$v0,	5		#syscall for reading user input
		syscall		

		sb	$v0, ($t1)		#saving key
		move	$t2, $v0
		
userInput:	li	$v0, 4
		la	$a0, prompt		#syscall for printing the prompt of coords
		syscall
		
		li	$v0,	5		#syscall for reading user input
		syscall			
						
		sb	$v0, 0($t1)		#storing user input
		addi	$t1, $t1, 1		#incrementing address so next iteration of loop will store at the next address
		sub	$t0, $t0, 1		#counter for the loop (in this case, ut us the number of coordinates)
		bgt	$t0, 0, userInput
		
		

		
		la	$t1, plainText
loop:		lb	$t4, 0($t1)
		beq	$t4, 0, print		#looping through all coordinates
		add	$t4, $t4, $t2		#adding the key to each coordinate
		sb	$t4, ($t1)		#storing the new number into register
		addi	$t1, $t1, 1		#incrementing address
		j	loop
						

print:		 la    	$t1, plainText
loop2:       	 lb    	$t4, 0($t1)
		 beq	$t4, 0, exit
       		 li   	$v0, 1
       		 move   $a0, $t4        	#printint out each new coordinate
        	 syscall
        	 
        	 addi	$t1, $t1, 1		#incrementing address
        	 		
        	 li	$v0, 4
		 la	$a0, newline     	#adding new line to make it easier to check numbers
		 syscall
		 		
		 j	loop2

		
exit:		li	$v0, 10			#exit
		syscall
