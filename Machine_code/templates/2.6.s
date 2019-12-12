#
# CSc 256 Example 2.6: Logical operations
# Name: William Hsu
# Date: 6/18/2010
# Description:  User enters count. Program performs xor and shift right
#               operations, for count iterations. 
#               Note: spim doesn't support printing integers in hex
#               (though we can write a utility function!) Look at
#               $s1 in spim to trace the operations.

# count	$s0
# x	$s1
# i	$s2

	.data

	.text
main:	li	$s1, 0x89abcdef	#  int x = 0x89abcdef;

	li	$v0, 5		#  cin >> count;
	syscall
	move	$s0, $v0

	li	$s2, 0
	bge	$s2, $s0 end
for:				#  for (int i=0; i<count; i++) {
	xor	$s1, $s1, 0x00010002
				#    x = x ^ 0x00010002;
				#    cout << hex << x << endl;
	sra	$s1, $s1, 1	#    x = x >> 1;
	addi	$s2, $s2, 1	#  }
	blt	$s2, $s0, for	#}

end:	li	$v0, 10
	syscall

