.text
.globl do_task
do_task:			# void do_task(int a, int b) {

  addi	$sp, $sp, -16        	# Set up stack
  sw	$ra, 0($sp)
  sw   $s0, 4($sp)	#a
  sw   $s1, 8($sp)	#b
  sw   $s2, 12($sp)
  #a0=a, a1=b

  
  # Your code here	
  # int n, k, result;
  # n = a+b; a0
  # k = a; a1
  add $s0, $a0, $0
  add $s1, $a1, $0
  
  add $a0, $s0, $s1
  add $a1, $s0, $0
  jal NchooseK
  add $a0, $v0, $0
  jal print_it
  
  add $a0, $s1, $0
  jal fib
  add $a0, $v0, $0
  jal print_it
  # result = NchooseK(n, k);
  # print_it(result);

  # result = Fibonacci(b);
  # print_it(result);
	
  
exit_from_do_task: 			# }
  lw	$ra, 0($sp)
  lw   $s0, 4($sp)
  lw   $s1, 8($sp) 
  lw   $s2, 12($sp)  
  addi $sp, $sp, 16
  jr	$ra             	# return from procedure
end_of_do_task:
