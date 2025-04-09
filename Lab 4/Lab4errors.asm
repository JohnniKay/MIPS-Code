#########################################################################################
#The .data section is memory that is allocated in the data segment of memory 		#
#Include the following in this section.  						#
#Use the .space directive to allocate several things:					#
#	space for user input								#
#Use .asciiz directive to create several things (not limited to):			#
#	a user prompt									#
#	a user notification of the legnth of their entry				#
#########################################################################################
	.data	
prompt:		.asciiz "Enter a string: "
buffer:		.space 15
userInfo:	.asciiz "Your string was this many characters:"

#########################################################################################
#The .text section is executed at runtime.						#
#Include the following in this section.  						#	
#Ask user for a string input.								#
#Call the stringLen by using the jal instruction and the appropriate label.		#
#	use caller/callee convention							#
#	pass any argument(s) by placing them in the $a0-$a3 registers			#
#	#read any return values by looking in $v0-$v1 after calling the function	#
#Print out the length of the user input.						#					
#Exit syscall										#
#########################################################################################
		.text
		li 	$v0, 4
		la 	$a0, prompt 		#prints prompt
		syscall
		
		li 	$v0, 8 	
		la 	$a0, buffer		#read string syscall
		la	$a1, 16			#maximum number of characters that can be read being set
		syscall
		
		jal StringLen			#jumps to stringlength function
		
		#print out the results of stringlenth
		
		li 	$v0, 4
		la 	$a0, userInfo		#prints prompt
		syscall
		
		move 	$a0, $v1 		#getting the result of the StringLen function from $v1 to $a0		
		li	$v0, 1			#printing out the counter for the lenght of the input
		syscall
		
		li 	$v0, 10 		#exit the program
		syscall
		
		#function to figure out string length
StringLen: 	move 	$t0, $a0 		#moves address (from $a0 to $t0) that was passed in from the main part of the program
		li 	$t1, 0 			#counter for number of characters. Set to 0
		
		la	$t0, buffer		#loads address of first element in bufferArray
loop:		lb 	$t2, 0($t0) 		#loads the first byte of the word into $t2
		beq 	$t2, 0, done 		#if the current byte is a null space, go to exit
		addiu 	$t1, $t1, 1 		#adds 1 to the counter
		addiu	$t0, $t0, 1		#increments address by 1
		j loop 
		
done:		move 	$v1, $t1 		#moves the result of counter to $v1 so the main part of the program can "see" it
		jr	$ra			#jumps back to where you left off after jal
		
		
