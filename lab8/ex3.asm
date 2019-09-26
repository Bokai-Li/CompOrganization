.data
input: .space 22
newline: .asciiz"\n"
.text 
.globl main

main:

	addi $v0, $0, 8
	la $a0, input
	addi $a1, $0, 22
	syscall
	jal h_to_i	
	
	add $a2, $0, $v0	#n
	beq $a2, $0, end
	
	addi $v0, $0, 8
	la $a0, input
	addi $a1, $0, 22
	syscall
	jal h_to_i
	
	add $a1, $0, $v0	#k

	jal NchooseK
	
	add $a0, $0, $v0
	
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



h_to_i:
	addi $t5, $0, 10
	
	lb $t1, input		
	slti $t2, $t1, 58		#if t1<'9' t2=1
	beq $t2, $0, isLetter
	addi $t1, $t1, -48
countinue:
	
	add $v0, $t1, $0
	li     $t0, 0
	li     $t1, 0
	li     $t2, 0
	li     $t3, 0
	li     $t4, 0
	jr	$ra

isLetter:
	addi $t1, $t1, -87
	j countinue

NchooseK:
    # $a0 = n $a1 = k
    # if(k==0) return 1;
    # if(n==k) return 1;
    # return NchooseK(n-1,k-1) + NchooseK(n-1,k);

    #save in stack
    addi $sp, $sp, -16 
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)	#n
    sw   $s1, 8($sp)	#k
    sw   $s2, 12($sp)	#result

    add $s0, $a2, $0	#n
    add $s1, $a1, $0	#k

    beq  $s0, $s1, return1	# if(n==k) return 1;
    beq  $s1, $0, return1	# if(k==0) return 1;

    addi $a2, $s0, -1	#n-1
    add $a1, $s1, $0	#k

    jal NchooseK

    add $s2, $zero, $v0         # $s2 = NK(n-1,k)

    addi $a2, $s0, -1	#n-1
    addi $a1, $s1, -1	#k-1

    jal NchooseK                # $v0 = NK(n-1,k-1)

    add $v0, $v0, $s2           # $v0 = NK(n-1,k-1) + $s1

exit:

        lw   $ra, 0($sp)        # read registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        lw   $s2, 12($sp)
        addi $sp, $sp, 16       # bring back stack pointer
        jr $ra

return1:
	li $v0,1
	j exit