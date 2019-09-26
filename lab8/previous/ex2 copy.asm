# Starter file for ex2.asm

.data 
input1: .space 22
input2: .space 22
newline: .asciiz "\n"  
.text 

main:
	
	#----------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	#
	# Please follow these guidelines:
	#
	#	Use syscall 8 to do the job of fgets()
	#	Then call h_to_i to perform conversion from hex string to integer
	#	Then call NchooseK to compute its factorial
	#	Then use syscall 1 to print the factorial result
	#----------------------------------------------------------------#
	addi $v0, $0, 8
	la $a0, input1
	addi $a1, $0, 22
	syscall
	jal h_to_i1	
	beq $a0, $0, end
	add $s1, $0, $a0	#n
	
	addi $v0, $0, 8
	la $a0, input2
	addi $a1, $0, 22
	syscall
	jal h_to_i2
	
	add $s2, $0, $a0	#k
	add $s5, $s1, $0	#copy of n

	addi $s3, $0, 1		#numerator
	addi $s4, $0, 1		#denominator
	addi $s6, $s2, -1	#k-1
	sub $s5, $s5, $s6	# nIni-(k-1)
	
	jal NchooseK
	
	div $s3, $s4
	mflo $a0
	
	addi $v0, $0, 1
	syscall
	
	la $a0, newline
	addi $v0, $0, 4
	syscall
	
	li     $t0, 0
	li     $t1, 0
	li     $s0, 0
	li     $s1, 0
	li     $s2, 0
	li     $s3, 0
	li     $s4, 0
	li     $s5, 0
	li     $s6, 0
	
	j main


end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.



h_to_i1:

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
	
	lb $t1, input1($t4)		# t1 = single char, t0 = value, t2 is boolean, t3 is 16, t4 is offset(1), t5 is 10(back space)
	addi $t4, $t4, 1
	
	slti $t2, $t1, 58		#if t1<'9' t2=1
	beq $t2, $0, isLetter
	addi $t1, $t1, -48
countinue:
	add $t0, $t1, $t0
	
	lb $t1, input1($t4)
	beq $t1, $t5, done

	sll $t0, $t0, 4
	j h_to_i1

h_to_i2:
	addi $t5, $0, 10
	
	lb $t1, input2($t4)		# t1 = single char, t0 = value, t2 is boolean, t3 is 16, t4 is offset(1), t5 is 10(back space)
	addi $t4, $t4, 1
	
	slti $t2, $t1, 58		#if t1<'9' t2=1
	beq $t2, $0, isLetter2
	addi $t1, $t1, -48
countinue2:
	add $t0, $t1, $t0
	
	lb $t1, input2($t4)
	beq $t1, $t5, done

	sll $t0, $t0, 4
	j h_to_i2

done:
	add $a0, $t0, $0
	li     $t0, 0
	li     $t1, 0
	li     $t2, 0
	li     $t3, 0
	li     $t4, 0
	jr	$ra

isLetter:
	addi $t1, $t1, -87
	j countinue
isLetter2:
	addi $t1, $t1, -87
	j countinue2




NchooseK:
	#----------------------------------------------------------------#
	# $a0 has the number n, $a1 has k, from which to compute n choose k
	#
	# Write code here to implement the function you wrote in C.
	# Your implementation need NOT be recursive; a simple iterative
	# implementation is sufficient.  Hence, this may be a leaf
	# procedure, and you may be able to get away without using the
	# stack at all.
	#
	# $v0 should have the NchooseK result to be returned to main.
	#----------------------------------------------------------------#

forNumerator:
	mult $s3, $s1
	mflo $s3
	
	addi $s1, $s1, -1	#n--

	slt $t0, $s1, $s5
	beq $t0, $0, forNumerator

forDenominator:
	
	mult  $s4,$s2
	mflo $s4
	
	addi $s2, $s2, -1
	
	slti $t1, $s2, 1
	beq $t1, $0, forDenominator
	
	jr	$ra
