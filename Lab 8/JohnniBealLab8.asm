		.data
file:		.asciiz "pillars.bmp"
file2:		.asciiz "pillarscipher.bmp"
buffer:		.space 54
space:		.asciiz "\n"

		.text

		li   	$v0, 13       	
		la   	$a0, file     	
		li   	$a1, 0        	#opening the file
		li   	$a2, 0        	
		syscall            	
		move 	$s0, $v0      			

		li   	$v0, 14       	
		move 	$a0, $s0      	 
		la   	$a1, buffer   	#reading header file
		li   	$a2,  54  	
		syscall			            		
		
		
        	li    $v0, 9        #allocating memory to the heap
        	li    $a0, 216
        	syscall
        	move    $t1, $v0 
        	la	$t0, buffer
loop:		lb	$t2, ($t0)
		beq	$t2, 42, load
		add	$t0, $t0, 1
		li     	$v0, 1
        	move   	$a0, $t2        	#display the extracted bit
        	syscall
        	li    	$v0, 4
        	la    	$a0, space        	#adding new line to make it easier to check numbers
        	syscall
		j	loop  	    	

load:		

		li   	$v0, 16       	
		move 	$a0, $s0      	#closing the file
		syscall    
				
exit:		li	$v0, 10		#exiting the program
		syscall
