#
# CSc 256 Example 2.2: If statement, variables in registers
# Name: William Hsu
# Date: 6/17/2010
# Description: Demonstrates if statement translation
# 
#
# #include <iostream.h>
# int x=4,y=-1,sum=0;
#
# int main()
# {
#   if (x != y)
#     sum = sum + x;
#
#   cout << sum << endl;
# }

# x	$s0
# y	$s1
# sum	$s2

	.data
endl:	.asciiz	"\n"

	.text
main:	addi	$s0,$0,4
	addi	$s1,$0,-1
	addi	$s2,$0,0

	beq	$s0,$s1,skip	# if (x != y)
	add	$s2,$s2,$s0	#   sum = sum + x;

skip:	add	$a0,$s2,$0	# cout << sum << endl;
	addi	$v0,$0,1
	syscall

	la	$a0,endl
	addi	$v0,$0,4
	syscall

	addi	$v0,$0,10
	syscall
