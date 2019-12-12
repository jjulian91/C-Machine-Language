#
# CSc 256 Example 2.5: While loop
# Name: William Hsu
# Date: 6/18/2010
# Description: 	User enters x. Program subtracts 5 from x repeatedly,
#		until x <= 0, and prints x.
#
# #include <iostream.h>
# int main(void)
# {
#   int x;
#   
#   cin >> x;
#   while (x > 0)
#     x = x - 5;
#   
#   cout << x << endl;
#   
# }

# x	$s0

	.data
endl:	.asciiz	"\n"

	.globl	while
	.text
main:	li	$v0,5		#   cin >> x;
	syscall
	move	$s0,$v0

	ble	$s0, $0, cont	#   while (x > 0)
while:	add	$s0, $s0, -5	#     x = x - 5;
	bgt	$s0, $0, while


cont:	move	$a0,$s0		#   cout << x << endl;
	li	$v0,1
	syscall

	la	$a0,endl
	li	$v0,4
	syscall

	li	$v0,10		
	syscall
