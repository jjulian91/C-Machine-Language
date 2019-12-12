#
# CSc 256 Example 2.4: For loop
# Name: William Hsu
# Date: 6/18/2010
# Description: 	User enters limit. Program computes sum of
#		integers from 1 to limit, and prints the sum.
#
# #include <iostream.h>
# int main(void)
# {
#   int sum=0,i,limit;
#   
#   cin >> limit;
#   for (i=1; i<=limit; i++)
#     sum = sum + i;
#   
#   cout << sum << endl;
#   
# }

# sum	$s0
# i	$s1
# limit	$s2

	.data
endl:	.asciiz	"\n"

	.text
main:	li	$v0,5		#   cin >> limit;
	syscall
	move	$s2,$v0

	li	$s0,0
	li	$s1,1		#   for (i=1; i<=limit; i++)
	bgt	$s1,$s2,cont
loop:	add	$s0,$s0,$s1	#     sum = sum + i;
	add	$s1,$s1,1
	ble	$s1,$s2,loop

cont:	move	$a0,$s0		#   cout << sum << endl;
	li	$v0,1
	syscall

	la	$a0,endl
	li	$v0,4
	syscall

	li	$v0,10		
	syscall
