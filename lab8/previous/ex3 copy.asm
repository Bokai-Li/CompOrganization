# =============================================================
# main PROCEDURE TEMPLATE # 4b
#
# Use with "proc_template4b.asm" as the template for other procedures
#
# Based on Slide 37 of Lecture 9 (Procedures and Stacks)
#   (main is simpler than other procedures because it does not have to
#     clean up anything before exiting)
#
# Assumptions:
#
#   - main calls other procedures with no more than 4 arguments ($a0-$a3)
#   - any local variables needed are put into registers (not memory)
#   - no values are put in temporaries that must be preserved across a call from main
#       to another procedure
#
# =============================================================

.data #0x0
input: .space 22

# declare global variables here

newline: .asciiz"\n"
.text #0x3000
.globl main

main:

    ori     $sp, $0, 0x3000     # Initialize stack pointer to the top word below .text
                                # The first value on stack will actually go at 0x2ffc
                                #   because $sp is decremented first.
    addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame


   	addi $v0, $0, 8
	la $a0, input
	addi $a1, $0, 22
	syscall
	jal h_to_i	
	beq $v0, $0, end
	add $s1, $0, $v0	#n
	
	addi $v0, $0, 8
	la $a0, input
	addi $a1, $0, 22
	syscall
	jal h_to_i
	
	add $s2, $0, $v0	#k
	
	add $a0, $0, $s1	#n
	add $a1, $0, $s2	#k

	jal NchooseK
	
	add $a0, $0, $v0
	
	addi $v0, $0, 1
	syscall
	
end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.



h_to_i:
	addi $t5, $0, 10
	
	lb $t1, input		# t1 = single char, t0 = value, t2 is boolean, t3 is 16, t4 is offset(1), t5 is 10(back space)
	
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
    addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp
    sw      $ra, 4($sp)         # Save $ra
    sw      $fp, 0($sp)         # Save $fp

    addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -4        # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 0($sp)         # Save $s0
    sw	$s1, 4($sp)
    sw $s2, 8($sp) 	# Save $s2

    sw $s3, 12($sp) 	# Save $s3

    li  $v0, 1
    beq $a1, $0, return_from_proc1
    beq $a0, $a1, return_from_proc1
    add $s0, $0, $a0        # We need to save the argument $a0.
    add $s1, $0, $a1
            
            addi $a0, $a0, -1
            addi $a1, $a1, -1

            jal NchooseK               # call proc2
                                       
            add $s2, $v0, $0	#v0 has NK(n-1,k-1)
            
            addi $a0, $s0, -1
            addi $a1, $s1, -1
            jal NchooseK	
            # =====================================================

    add $v0, $v0, $s2           # $v0 has NK(n-1,k)
    
    # Restore $sx registers
    lw  $s0,  -8($fp)           # Restore $s0
    lw $s1, -12($fp) 
    lw $s2, -16($fp) 
    lw $s3, -20($fp) 

return_from_proc1:
    addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($fp)     # Restore $ra
    lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure

end_of_proc1:

