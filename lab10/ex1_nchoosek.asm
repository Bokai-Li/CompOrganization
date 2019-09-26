.text
.globl NchooseK
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

    add $s0, $a0, $0	#n
    add $s1, $a1, $0	#k

    beq  $s0, $s1, return1	# if(n==k) return 1;
    beq  $s1, $0, return1	# if(k==0) return 1;

    addi $a0, $s0, -1	#n-1
    add $a1, $s1, $0	#k

    jal NchooseK

    add $s2, $zero, $v0         # $s2 = NK(n-1,k)

    addi $a0, $s0, -1	#n-1
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

