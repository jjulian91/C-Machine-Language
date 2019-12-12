#
# CSc 256 Example 3.2 Char array access with pointers
# Name: William Hsu
# Date: 6/18/2010
# Description:  Initializes character array

# $s0	i
# $s1	ptr

	.data
str:	.byte	0:6

	.text
main:	la	$s1, str	#  ptr = str;
	li	$s0, 0		#  for (int i=0; i<6; i++)
	li	$t0, 0xa
	li	$t1, 6

loop:	sb	$t0, ($s1)	#    str[i] = 0xa;
	addi	$s0, $s0, 1
	addi	$s1, $s1, 1	#    ptr++;
	blt	$s0, $t1, loop

end:	li	$v0, 10
	syscall
