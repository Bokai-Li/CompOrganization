.data
newline:.asciiz"\n"
.text 

main:
li $v0,5
syscall
move $s0,$v0 #start
add $s1,$s0,$0 #R

doWhile:

add $a0, $s1, $0 #printf("%d\n", R);
li $v0,1
syscall

li $v0,4
la $a0,newline
syscall

srl $t0, $s1, 4 #(R >> 4)
andi $t1, $t0, 0x01 #t1 = (R >> 4) & 0x01
srl $t2, $s1, 2 #(R >> 2)
andi $t3, $t2, 0x01 #t3 (R >> 2) & 0x01
xor $s2, $t1, $t3 # B = ((R >> 4) & 0x01) ^ ((R >> 2) & 0x01);

andi $t4, $s1, 0x0F #(R & 0x0F)
sll $t5, $t4, 1
or $s1, $t5, $s2 # R = ((R & 0x0F) << 1) | B;
bne $s1, $s0, doWhile #while(R != start)

end: 
ori   $v0, $0, 10     # system call 10 for exit
syscall               # we are out of here.
