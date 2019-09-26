.data
movedisk: .asciiz "Move disk "
frompeg: .asciiz " from Peg "
topeg: .asciiz " to Peg "
newline:	.asciiz "\n"
.text
.globl main

main:
li	$v0, 5
syscall
move	$a0, $v0 # n
li $a1, 1
li $a2, 2
li $a3, 3

moveMethod:
    addi $sp, $sp, -20
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw $s2,12($sp)
    sw $s3, 16($sp)

move $s0, $a0 #n
move $s1, $a1 #source
move $s2, $a2 #target
move $s3, $a3 #aux

    sge $t0, $s0, $0
    beq  $t0, 1, exit

addi $a0, $s0, -1
move $a2, $s3
move $a3, $s2

    jal moveMethod # move(n - 1, source, auxiliary, target)
	
li	$v0, 4
la	$a0, movedisk
syscall

li	$v0, 1
move	$a0, $s0
syscall

li	$v0, 4
la	$a0, frompeg
syscall

li	$v0, 1
move	$a0, $s1
syscall

li	$v0, 4
la	$a0, topeg
syscall

li	$v0, 1
move	$a0, $s2
syscall

syscall
li	$v0, 4
la	$a0, newline
syscall



addi $a0, $s0, -1
move $a1, $s3
move $a3, $s1

    jal moveMethod # move(n - 1, auxiliary, target, source)   
    
exit:
    lw   $ra, 0($sp)        # read registers from stack
    lw   $s0, 4($sp)
    lw   $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20       # bring back stack pointer
    jr $ra
    
end:
    ori     $v0, $0, 10     	# System call code 10 for exit
    syscall 
