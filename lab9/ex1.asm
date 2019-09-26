.data
newline:.asciiz"\n"
.text 

main:
li $v0,5
syscall
move $s0,$v0
li $t0, 15
li $t1, -1
loop:
srlv $a0, $s0, $t0
andi $a0, $a0, 1
addi $t0,$t0,-1
li $v0,1
syscall
beq $t0,$t1,printnl
j loop

printnl:
li $v0,4
la $a0,newline
syscall
beq $s0, $0, end

j main

end: 
ori   $v0, $0, 10     # system call 10 for exit
syscall               # we are out of here.
