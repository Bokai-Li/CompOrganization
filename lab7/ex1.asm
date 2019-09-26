# Starter file for ex1.asm

.data 0x0
magic: .space 5 		# more than enough space to read in "P3\n" plus null
P2: .asciiz "P2"
newline: .asciiz "\n"
        
.text 0x3000

main:
	la $t1, magic
	addi $v0, $0, 8
	syscall
	la $a0, P2
	addi $v0, $0, 4
	syscall
	la $a0, newline
  	addi $v0, $0, 4
  	syscall
	addi $v0, $0, 5
	syscall
	add $t1, $v0, $0 #col
	addi $v0, $0, 5
	syscall
	add $t2, $v0, $0 #row
	addi $v0, $0, 1
	add $a0, $0, $t1
	syscall
	la $a0, newline
	addi $v0, $0, 4
	syscall
	addi $v0, $0, 1
	add $a0, $0, $t2
	syscall
	la $a0, newline
	addi $v0, $0, 4
	syscall
	addi $v0, $0, 5
	syscall
	add $a3, $0, $v0 #ppm_max
	addi $a0, $0, 255
	addi $v0, $0, 1
	syscall
	la $a0, newline
	addi $v0, $0, 4
	syscall

	
	
	
	#------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	# That is, read and write the magic numbers,
	# read and write the number of cols and rows,
	# and read and write the ppm_max values.  The output's
	# magic number will be "P2".  And, regardless of the input's
	# ppm_max, the output will always have 255 as its ppm_max.
	#------------------------------------------------------------#

forrow:
	beq $t2, $0, end
	addi $t2,$t2, -1
	add $t7, $0, $t1
	jal forcol
forcol:
	addi $v0, $0, 5
	syscall
	add $a0, $0, $v0
	addi $v0, $0, 5
	syscall
	add $a1 $0, $v0
	addi $v0, $0, 5
	syscall
	add $a2, $0, $v0
	
	#------------------------------------------------------------#
	# Write code here to implement the double-for loop of the C
	# program, to iterate through all the pixels in the image.
	#
	# The actual conversion from RGB to gray value of a single
	# pixel must be done by a separate procedure called rgb_to_gray
	#------------------------------------------------------------#
	
	jal	rgb_to_gray
	addi $v0, $0, 1
	add $a0, $0, $t6
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

	addi $t7, $t7, -1
	bne $t7, $0, forcol
	beq $t7, $0, forrow
end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # exit



rgb_to_gray:
	#------------------------------------------------------------#
	# $a0 has r
	# $a1 has g
	# $a2 has b
	# $a3 has ppm_max
	#

	addi $t4, $0, 30
	mult $t4,$a0
	mflo $a0
	addi $t4, $0, 59
	mult $t4,$a1
	mflo $a1
	addi $t4, $0, 11
	mult $t4,$a2
	mflo $a2
	add $t4, $a0, $a1
	add $t4, $t4, $a2
	addi $t5, $0, 255
	mult $t4,$t5
	mflo $t4
	addi $t5, $0, 100
	mult $t5,$a3
	mflo $t5
	div $t4,$t5
	mflo $t6
	
	jr	$ra
