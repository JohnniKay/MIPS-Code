		.data
coordInput:	.asciiz "Enter coordinates of a line with two endpoints! Exact example: x,y;x,y : "
transInput:	.asciiz "Enter translation number Exact example: x,y : "
mess1:		.asciiz "x coords: "
mess2:		.asciiz "y coords: "
mess3:		.asciiz "x translation number: "
mess4:		.asciiz "y translation number: "
mess5:		.asciiz "New x coords: "
mess6:		.asciiz "New y coords: "
commaMess:	.asciiz ","
newline:		"\n"
buffer1:	.space 64
buffer2:	.space 64

		.text
		
		la	$t1, buffer1
		
		la $a0, coordInput		#prompt for user input
		li $v0, 4
		syscall
		
		li 	$v0, 8 	
		la 	$a0, buffer1		#read string syscall
		la	$a1, buffer1		#maximum number of characters that can be read being set
		syscall
		
mathLoop:	lbu	$t2, ($t1)		#loading the first byte	
		beq	$t2, 44, comma		#initiating loop/Moving to print if constraints are met
		beq	$t2, 59, comma	
		beq	$t2, 10, pack		#initiating loop/Moving to print if constraints are met
		multu  	$t0, $t3		#multiplying
		mflo	$t0			#moving the result from low register to $t0
		addu 	$t0, $t0, $t2		#adding
		subiu	$t0, $t0, 48		#subtracting
		sb	$t0, ($t1)
		addiu	$t1, $t1, 1		#incrementing address
		j	mathLoop		#restarting the loop
		
comma:		li	$t0, 0			#Sets $t0 back to 0
		addiu	$t1, $t1, 1		#incrementing address
		jal	mathLoop
		
pack:		add	$t4, $t4, 1
		beq	$t4, 2, pack2
		la	$t1, buffer1
		lb	$t2, ($t1)
		move	$s0, $t2		#x1
		add	$t1, $t1, 2		
		lb	$t2, ($t1)		
		move	$s1, $t2		#y1
		add	$t1, $t1, 2
		lb	$t2, ($t1)
		move	$s2, $t2		#x2
		add	$t1, $t1, 2
		lb	$t2, ($t1)
		move	$s3, $t2		#y2
		
		sll	$s0, $s0, 16		#shifting whole number by 16 bits
		sll	$s1, $s1, 16		#shifting decimal by 16 bits
		sll	$s2, $s2, 16		#shifting whole number by 16 bits
		sll	$s3, $s3, 16		#shifting decimal by 16 bits
		
		li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	li     	$v0, 35
        	move   	$a0, $s0        	#display the extracted bit
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	li     	$v0, 35
        	move   	$a0, $s1        	#display the extracted bit
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	li     	$v0, 35
        	move   	$a0, $s2        	#display the extracted bit
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	li     	$v0, 35
        	move   	$a0, $s3        	#display the extracted bit
        	syscall
		
		srl	$s2, $s2, 16
		or	$s0, $s0, $s2		#combining x1 and x2 
		srl	$s3, $s3, 16
		or	$s1, $s1, $s3		#combining y1 and y2 
			
						
		li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, mess1         	#xcoords prompt
        	syscall
        	
        	li     	$v0, 35
        	move   	$a0, $s0        	#print combined x
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, mess2         	#ycoords prompt
        	syscall
        	
        	li     	$v0, 35
        	move   	$a0, $s1        	#print combined y
        	syscall
        	
        	li    	$v0, 4
        	la    	$a0, newline         	#adding new line to make it easier to check numbers
        	syscall
transPart:
        	la    	$t1, buffer2

        	la 	$a0, transInput        #prompt for user input
        	li 	$v0, 4
        	syscall

        	li     	$v0, 8
        	la     	$a0, buffer2        	#read string syscall
        	la    	$a1, buffer2        	#maximum number of characters that can be read being set
        	syscall
        	jal    	mathLoop

pack2:        	la    	$t1, buffer2
        	lb    	$t2, ($t1)
        	move    $s4, $t2        	#x1
        	move	$s6, $t2
        	add    	$t1, $t1, 2
        	lb    	$t2, ($t1)
        	move    $s5, $t2        	#y1
        	move	$s7, $t2
        	sll    	$s4, $s4, 16        	#shifting x translation
        	or	$s4, $s4, $s6      	
        	
        	sll    	$s5, $s5, 16       	#shifting y translation
		or	$s5, $s5, $s7
		
        	li      $v0, 4
            	la      $a0, newline            #adding new line to make it easier to check numbers
            	syscall

            	li      $v0, 4
            	la      $a0, mess3             	#adding new line to make it easier to check numbers
            	syscall

            	li      $v0, 35
            	move    $a0, $s4            	#display the extracted bit
            	syscall

                li      $v0, 4
            	la      $a0, newline            #adding new line to make it easier to check numbers
            	syscall

            	li      $v0, 4
            	la      $a0, mess4             	#adding new line to make it easier to check numbers
            	syscall

           	li      $v0, 35
            	move    $a0, $s5            	#display the extracted bit
            	syscall        	

translation:	add	$s0, $s0, $s4		#adding x and x translation
		add	$s1, $s1, $s5		#adding y and y translation
		
		li      $v0, 4
            	la      $a0, newline            #adding new line to make it easier to check numbers
            	syscall
		
		li      $v0, 4
            	la      $a0, mess5             	#adding new line to make it easier to check numbers
            	syscall

            	li      $v0, 35
            	move    $a0, $s0            	#display the extracted bit
            	syscall
            	
            	li      $v0, 4
            	la      $a0, newline            #adding new line to make it easier to check numbers
            	syscall
            	
            	li      $v0, 4
            	la      $a0, mess6             	#adding new line to make it easier to check numbers
            	syscall

            	li      $v0, 35
            	move    $a0, $s1            	#display the extracted bit
            	syscall
            	
            	li      $v0, 4
            	la      $a0, newline            #adding new line to make it easier to check numbers
            	syscall
PrintFinal:           	
            	li      $v0, 4
            	la      $a0, mess5             	#adding new line to make it easier to check numbers
            	syscall
            	
            		
            	srl	$s0, $s0, 16
            	
            	
            	li      $v0, 1
            	move    $a0, $s0            	#display the extracted bit
            	syscall
            	
            	li      $v0, 4
            	la      $a0, commaMess           #adding new line to make it easier to check numbers
            	syscall
            	
            	
            	sll	$s0, $s0, 16
		sll	$s6, $s6, 8
            	
            	li      $v0, 1
            	move    $a0, $s6            	#display the extracted bit
            	syscall
            	
            	li      $v0, 4
            	la      $a0, newline            #adding new line to make it easier to check numbers
            	syscall
            	
            	li      $v0, 4
            	la      $a0, mess6             	#adding new line to make it easier to check numbers
            	syscall
            	
            	srl	$s1, $s1, 16
            	
            	li      $v0, 1
            	move    $a0, $s1            	#display the extracted bit
            	syscall
            	
            	li      $v0, 4
            	la      $a0, commaMess           #adding new line to make it easier to check numbers
            	syscall
            	
            	#sll	$s1, $s1, 16
            	#sll	$s1, $s1, 16
            	
            	li      $v0, 1
            	move    $a0, $s1            	#display the extracted bit
            	syscall
				
exit:		li	$v0, 10			#exit
		syscall
