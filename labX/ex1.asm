.data 
array: .space 200
array2: .space 200
newline:      .asciiz "\n"
.globl main
.text 
main:
	li $v0, 5       #read num of items
	syscall
	move $a0, $v0
	addi $t0, $0, 4
	mult $a0, $t0 # t2=num item*4
	mflo $t2
	li $t0, 0   		#index
readloop:
	li $v0, 5       	#read int
	syscall 
	sw $v0, array($t0)
	addi  $t0, $t0, 4
	bne $t0, $t2, readloop
	la $a1, array
	addi $a2, $a0, -1
	move $a3, $0
	jal mergeSort
print:
	li $t1, 0   		#index
printloop:
	lw $a0, array2($t1)
	li $v0, 1
	syscall
	li $v0,4
	la $a0,newline
	syscall
	addi $t1, $t1, 4
	bne $t1, $t2, printloop
mergeSort:
	addi $sp, $sp, -20
	sw $ra, 16($sp)
	sw $s1, 12($sp)
	sw $s2, 8($sp) #high
	sw $s3, 4($sp) #low
	sw $s4, 0($sp) #mid
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	slt $t0, $s3, $s2
	beq $t0, $0, finishSort
	add $s4, $s2, $s3
	addi $t1, $0, 2
	div $s4, $t1
	mflo $s4
	move $a2, $s4
	move $a3, $s3
	jal mergeSort
	addi $t0, $t0, 1
	move $a3, $t0
	move $a2, $s2
	jal mergeSort
	move $a1, $s1
	move $a2, $s2
	move $a3, $s3
	move $a0, $s4
	jal merge
finishSort:
	lw $ra, 16($sp)
	lw $s1, 12($sp)
	lw $s2, 8($sp) #high
	lw $s3, 4($sp) #low
	lw $s4, 0($sp) #mid
	addi $sp, $sp, 20
	jr $ra
merge:
	addi $sp, $sp, -20
	sw $ra, 16($sp)
	sw $s1, 12($sp)
	sw $s2, 8($sp) #high
	sw $s3, 4($sp) #low
	sw $s4, 0($sp) #mid
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	move $s4, $a0
	move $t1, $s3
	move $t2, $s4
	addi $t2, $t2, 1
	move $t3, $a3
WHILE: 
	slt $t4, $s4, $t1
	bne $t4, $zero,while2
	slt $t5, $s2, $t2 
	bne $t5, $zero,while2
	sll $t6, $t1, 2 
	add $t6, $s1, $t6 
	lw $s5, 0($t6) 
	sll $t7, $t2, 2 
	add $t7, $s1, $t7 
	lw $s6, 0($t7) 
	slt $t4, $s5, $s6
	beq $t4, $zero,ELSE
	sll $t8, $t3, 2
	la $a0, array2
	add $t8, $a0, $t8
	sw $s5, 0($t8)
	addi $t3, $t3, 1
	addi $t1, $t1, 1
	j WHILE 
ELSE: 
	sll $t8, $t3, 2
	la $a0, array2
	add $t8, $a0, $t8 
	sw $s6, 0($t8)
	addi $t3, $t3, 1
	addi $t2, $t2, 1
	j WHILE
while2:
	slt $t4, $s4, $t1
	bne $t4, $zero,while3 
	sll $t6, $t1, 2 
	add $t6, $s1, $t6
	lw $s5, 0($t6)
	sll $t8, $t3, 2
	la $a0, array2
	add $t8, $a0, $t8
	sw $s5, 0($t8)
	addi $t3, $t3, 1
	addi $t1, $t1, 1
	j while2 
while3: 
	slt $t5, $s2, $t2
	bne $t5, $zero,start
	sll $t7, $t2, 2
	add $t7, $s1, $t7
	lw $s6, 0($t7)
	sll $t8, $t3, 2
	la $a0, array2
	add $t8, $a0, $t8
	sw $s6, 0($t8)
	addi $t3, $t3, 1
	addi $t2, $t2, 1
	j while3 
start: 
	or $t1, $zero,$s3
forloop: 
	slt $t5, $t1, $t3
	beq $t5, $zero,finishSort
	sll $t6, $t1, 2
	add $t6, $s1, $t6
	sll $t8, $t1, 2
	la $a0, array2
	add $t8, $a0, $t8
	lw $s7, 0($t8)
	sw $s7, 0($t6)
	addi $t1, $t1, 1 
	j forloop

end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.
