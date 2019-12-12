#
# CSc 256 Example 3.1 Char array indexing
# Name: William Hsu
# Date: 6/18/2010
# Description:  Initializes character array

# $s0	i
# $s1	base address of str

	.data
str:	.byte	0:6

	.text
main:	li	$s0, 0		#  for (int i=0; i<6; i++)
	la	$s1, str
	li	$t0, 0xa
	li	$t1, 6

loop:	add	$t1, $s1, $s0	#    $t1 = &str[i]
	sb	$t0, ($t1)	#    str[i] = 0xa;
	addi	$s0, $s0, 1
	blt	$s0, $t1, loop

end:	li	$v0, 10
	syscall
