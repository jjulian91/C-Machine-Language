#
# CSc 256 Example 2.3: If-else statement, variables in registers
# Name: William Hsu
# Date: 6/17/2010
# Description: Demonstrates nested if-else statement
#
# 
# int main(void)
# {
#   int num, max = 100, flag;
#   
#   cin >> num;
#   
#   if (num == max)
#     flag = 1;
#   else if (num != 0)
#     flag = -1;
#   else flag = 0;
#   
#   cout << flag << endl;
# }

# num	$s0
# flag	$s1
# max   $s2

	.data
endl:	.asciiz	"\n"

	.text
main:	addi	$s2, $0, 100	#   max = 100;
	addi	$v0,$0,5	#   cin >> num;
	syscall
	add	$s0,$v0,$0

	bne	$s0,$s2,next1	#   if (num == max)
	addi	$s1,$0,1	#     flag = 1;
	j	cont
next1:	beq	$s0,$0,next2	#   else if (num != 0)
	addi	$s1,$0,-1	#     flag = -1;
	j	cont
next2:	addi	$s1,$0,0	#   else flag = 0;

cont:	add	$a0,$s1,$0	#   cout << flag << endl;
	addi	$v0,$0,1
	syscall

	la	$a0,endl
	addi	$v0,$0,4
	syscall

	addi	$v0,$0,10		
	syscall
