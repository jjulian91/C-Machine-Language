
# CSc 256 Example 4.3: String length using function
# File: 4.3
# Name: William Hsu
# Date: 6/23/2010
# Description:  Computes length of string using str_len function

	.data
str:	.asciiz	"abcde"
endl:	.asciiz	"\n"

	.text
main:	la	$a0, str
	jal	str_len		#  length = str_len(str);

	move	$a0, $v0	#  cout << length << endl;
	li	$v0, 1
	syscall

	la	$a0, endl
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall


# int str_len(char *arg)
#
# ptr	$t0
# count $t1

str_len:li	$t1, 0		#  int count = 0;

	move	$t0, $a0	#  ptr = arg;
	lbu	$t2, ($t0)	#  while (*ptr != 0) {
	ble	$t2, $0, end
loop:	addi	$t1, $t1, 1	#    count++;
	addi	$t0, $t0, 1	#    ptr++;
	lbu	$t2, ($t0)	#  }
	bne	$t2, $0, loop

end:	move	$v0, $t1	#  return count;
	jr	$ra

