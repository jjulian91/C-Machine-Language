#
# CSc 256 Example 2.1: First MIPS program, variables in registers
# Name: William Hsu
# Date: 6/17/2010
# Description: Demonstrates simple MIPS arithmetic instructions
#
# int v=0,w=1,x=2,y=3,z=4;
# 
# int main(void)
# {
#   w = z;
#   v = w + x;
#   y = w - x;
#   z = z - 1;
#
#   cout << v << endl;
#   cout << w << endl;
#   cout << x << endl;
#   cout << y << endl;
#   cout << z << endl;
# }

# v	$s0
# w	$s1
# x	$s2
# y	$s3
# z	$s4

	.data
endl:	.asciiz	"\n"

	.text
main:	addi	$s0,$0,0	# v = 0;
	addi	$s1,$0,1	# w = 1;
	addi	$s2,$0,2	# x = 2;
	addi	$s3,$0,3	# y = 3;
	addi	$s4,$0,4	# z = 4;

	add	$s1,$s4,$0	# w = z;
	add	$s0,$s1,$s2	# v = w + x;
	sub	$s3,$s1,$s2	# y = w - x;
	addi	$s4,$s4,-1	# z = z - 1;

	add	$a0,$s0,$0	# cout << v << endl;
	addi	$v0,$0,1
	syscall

	la	$a0,endl
	addi	$v0,$0,4
	syscall

	add	$a0,$s1,$0	# cout << w << endl;
	addi	$v0,$0,1
	syscall

	la	$a0,endl
	addi	$v0,$0,4
	syscall

	add	$a0,$s2,$0	# cout << x << endl;
	addi	$v0,$0,1
	syscall

	la	$a0,endl
	addi	$v0,$0,4
	syscall

	add	$a0,$s3,$0	# cout << y << endl;
	addi	$v0,$0,1
	syscall

	la	$a0,endl
	addi	$v0,$0,4
	syscall

	add	$a0,$s4,$0	# cout << z << endl;
	addi	$v0,$0,1
	syscall

	la	$a0,endl
	addi	$v0,$0,4
	syscall

	addi	$v0,$0,10		
	syscall
