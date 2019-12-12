	.data
x:	.word	0:6
endl:	.asciiz	"\n"

# ptr	$s0
# i	$s1

	.text
main:	la	$s0, x		#  ptr = x;
	li	$t0, 6

	li	$s1, 0		#  for (i=0; i<6; i++) {
loop:	sw	$s1, ($s0)	#    *ptr = i;
	addi	$s0, $s0, 4	#    ptr++;
	addi	$s1, $s1, 1
	blt	$s1, $t0, loop	#  }

	la	$s0, x		#  ptr = x;
	li	$s1, 0		#  for (i=0; i<6; i++) {

loop1:	lw	$a0, ($s0)	#    cout << *ptr << endl;
	li	$v0, 1
	syscall
	la	$a0, endl
	li	$v0, 4
	syscall

	addi	$s0, $s0, 4	#    ptr++;
	add	$s1, $s1, 1
	blt	$s1, $t0, loop1	#  }

	li	$v0, 10
	syscall
