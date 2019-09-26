.data 
array: .space 200
size: .space 4
newline:      .asciiz "\n"
.globl main
.text 
main:
	li $v0, 5       #read num of items
	syscall
	sw $v0, size
	move $a0, $v0
	mul $t2, $a0, 4 # t2=num item*4
	li $t0, 0   		#index
readloop:
	li $v0, 5       	#read int
	syscall 
	sw $v0, array($t0)
	addi  $t0, $t0, 4
	bne $t0, $t2, readloop
	addi $a1, $a0, -1	#high
	move $a2, $0		#low
	move $s0, $a1	#high is save in s0
	move $s2, $a2
	jal quickSort
	j print
quickSort:#a2 = low a1 = high
	
	addi $sp, $sp, -16
	sw $ra, 0($sp)	# save return address	
	sw $s0, 4($sp)  #high
	sw $s1, 8($sp)  #pivotIndex
	sw $s2, 12($sp)	#low
	
	move $s0, $a1	#high is save in s0
	move $s2, $a2
	
	slt $t0, $a2, $a1 #if (low < high)
	beq $t0, $0, quickSortEnd
Partition: #a1 = high a2 = low
	mul $t4, $a1, 4
	lw $t0, array($t4) # t0 = pivot pivot = arr[high];
	addi $t1, $a2, -1 # t1=i i = (low - 1);

	add $t2, $a2, $0 # t2 = j=low for (int j = low; j <= high -1 ; j++)
	add $t7, $a1, -1
	addi $t2, $t2, -1
forLoop:
	addi $t2, $t2, 1
	sle $t3, $t2, $t7
	beq $t3, $0, forLoopEnd
	mul $t5, $t2, 4
	lw $t8, array($t5)
	sle $t3, $t8, $t0	
	beq $t3, $0, forLoop
	addi $t1, $t1, 1
	mul $t5, $t1, 4
	mul $t6, $t2, 4
	lw $t3, array($t5)
	lw $t4, array($t6)
	sw $t3, array($t6)
	sw $t4, array($t5)
	j forLoop
forLoopEnd:
	addi $t1, $t1, 1
	mul $t5, $t1, 4
	mul $t6, $a1, 4
	lw $t8, array($t5)
	lw $t9, array($t6)
	sw $t8, array($t6)
	sw $t9, array($t5)
	move $s1, $t1
	sw $s1, 8($sp)  #pivotIndex
Countinue:	
	move $a2, $s2
	addi $a1, $s1, -1 #quickSort(arr, low, pvindex - 1);
	jal quickSort
	
	addi $a2, $s1, 1
	move $a1, $s0
	jal quickSort #quickSort(arr, pvindex + 1, high);

quickSortEnd:
	lw $ra, 0($sp)        # read registers from stack
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16       # bring back stack pointer
	jr $ra

print:
	lw $t2, size
	mul $t2, $t2, 4
	li $t1, 0	#index
printloop:
	lw $a0, array($t1)
	li $v0, 1
	syscall
	li $v0,4
	la $a0,newline
	syscall
	addi $t1, $t1, 4
	bne $t1, $t2, printloop
end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.
