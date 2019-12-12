
# CSc 256 Example 8.2: unaligned load
# File: 8.2
# Name: William Hsu
# Date: 7/2/2010
# Description:  Demonstrates trap handler with unaligned load

	.data
x:	.word	4
str:	.asciiz	"...Now we're past exception...\n"

	.text
main:
	la	$s0,x
	lw	$s1,1($s0)
	li	$v0,4
	la	$a0,str
	syscall
	li	$v0,10
	syscall
	