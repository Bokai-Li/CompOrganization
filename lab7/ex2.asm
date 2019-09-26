.data 0x0
magic: .space 5 		# more than enough space to read in "P3\n" plus null
P3: .asciiz "P3"
newline: .asciiz "\n"
.text 0x3000

main:
	addi $v0, $0, 5
	syscall
	add $t0,$0, $v0	#t0=x1
	#addi $t0, $t0, 1

	addi $v0, $0, 5
	syscall
	add $t1,$0, $v0	#t1=x2
	#addi $t1, $t1, 1
	
	addi $v0, $0, 5
	syscall
	add $t2,$0, $v0	#t2=y1
	#addi $t2, $t2, 1

	addi $v0, $0, 5
	syscall
	add $t3,$0, $v0	#t3=y2
	#addi $t3, $t3, 1

	la $a0, P3
	addi $v0, $0, 4
	syscall		#print P3

	la $a0, newline
	addi $v0, $0, 4
	syscall

	addi $v0, $0, 5
	syscall
	add $t4, $0, $v0	#t4=col

	addi $v0, $0, 5
	syscall
	add $t5, $0, $v0	#t5=row
	#addi $t5, $t5, 1

	add $a0, $0, $t4
	addi $v0,$0, 1
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

	add $a0, $0, $t5
	addi $v0,$0, 1
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

	addi $v0, $0, 5
	syscall
	add $t7, $0, $v0	#read ppm max

	addi $a0, $0, 255
	addi $v0,$0, 1
	syscall		#print 255

	la $a0, newline
	addi $v0, $0, 4
	syscall

	add $t8, $0, $0	#t8=i
	add $t9, $0, $0	#t9=j

forrow:
	beq $t8, $t5, exit
	add $t9, $0, $0	#reset j
	
forcol:
	addi $v0, $0, 5
	syscall
	add $a3, $0, $v0	#a3=red

	addi $v0, $0, 5
	syscall
	add $a1, $0, $v0	#a1=green

	addi $v0, $0, 5
	syscall
	add $a2, $0, $v0	#a2=blue
  
	add $s0, $0, $0	
	slt $s0, $t9, $t0		#if i<x1 s0=1
	bne $s0, $0, rgb_to_gray	
	slt $s0, $t1, $t9		#if i>x2 s0=1
	bne $s0, $0, rgb_to_gray	
	slt $s0, $t8, $t2		#if j<y1 s0=1
	bne $s0, $0, rgb_to_gray
	slt $s0, $t3, $t8		#if j>y2 s0=1
	bne $s0, $0, rgb_to_gray

printRGB:
	add $a0, $0, $a3
	addi $v0,$0, 1
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

	add $a0, $0, $a1
	addi $v0,$0, 1
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

	add $a0, $0, $a2
	addi $v0,$0, 1
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

Loopback:
	addi $t9, $t9, 1
	bne $t9, $t4, forcol
	addi $t8, $t8, 1
	beq $t9, $t4, forrow

exit:
ori $v0, $0, 10       		# system call code 10 for exit
syscall               		# exit the program

rgb_to_gray:
	addi $s1, $0, 30
	mult $s1,$a3
	mflo $a3
	addi $s1, $0, 59
	mult $s1,$a1
	mflo $a1
	addi $s1, $0, 11
	mult $s1,$a2
	mflo $a2
	add $s1, $a3, $a1
	add $s1, $s1, $a2
	addi $s2, $0, 255
	mult $s1,$s2
	mflo $s1
	addi $s2, $0, 100
	mult $s2,$t7
	mflo $s2
	div $s1,$s2
	mflo $s3
	
printgray:

	addi $v0, $0, 1
	add $a0, $0, $s3
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall
	
	addi $v0, $0, 1
	add $a0, $0, $s3
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

	addi $v0, $0, 1
	add $a0, $0, $s3
	syscall

	la $a0, newline
	addi $v0, $0, 4
	syscall

	j Loopback
