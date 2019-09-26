# Starter file for ex1.asm

.data
input: .space 22
newline: .asciiz "\n"
.text

main:

	#----------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	#
	# Please follow these guidelines:
	#
	#	Use syscall 8 to do the job of fgets()
	#	Then call h_to_i to perform conversion from string to integer
	#	Then use syscall 1 to print the integer result
	#----------------------------------------------------------------#
	addi $v0, $0, 8
	la $a0, input
	addi $a1, $0, 22
	syscall
	jal h_to_i	
	beq $v0, $0, end
	
	add $a0, $v0, $0
	addi $v0, $0, 1
	syscall
	
	la $a0, newline
	addi $v0, $0, 4
	syscall
	
	j main

end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.



h_to_i:
	#----------------------------------------------------------------#
	# $a0 has address of the string to be parsed.
	#
	# Write code here to implement the function you wrote in C.
	# Since this is a leaf procedure, you may be able to get away
	# without using the stack at all.
	#
	# $v0 should have the integer result to be returned to main.
	#----------------------------------------------------------------#

	addi $t5, $0, 10
	
	lb $t1, input ($t4)		# t1 = single char, t0 = value, t2 is boolean, t3 is 16, t4 is offset(1), t5 is 10(back space)
	addi $t4, $t4, 1
	
	slti $t2, $t1, 58		#if t1<'9' t2=1
	beq $t2, $0, isLetter
	addi $t1, $t1, -48
countinue:
	add $t0, $t1, $t0
	
	lb $t1, input($t4)
	beq $t1, $t5, done

	sll $t0, $t0, 4
	j h_to_i

done:
	add $v0, $t0, $0
	li     $t0, 0
	li     $t1, 0
	li     $t2, 0
	li     $t3, 0
	li     $t4, 0
	jr	$ra

isLetter:
	addi $t1, $t1, -87
	j countinue
	

