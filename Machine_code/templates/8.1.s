
# CSc 256 Example 8.1: arithmetic overflow
# File: 8.1
# Name: William Hsu
# Date: 7/2/2010
# Description:  Demonstrates trap handler with arithmetic overflow

	.data
str:	.asciiz	"...Now we're past exception...\n"

	.text
main:
	li	$s0,0x7fffffff
	add	$s1,$s0,1	
	li	$v0,4
	la	$a0,str
	syscall
	li	$v0,10
	syscall
