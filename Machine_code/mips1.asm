.data
arr: 	.word 12
	.word -1
	.word 8
	.word 0
	.word 6
	.word 85
	.word -74
	.word 23
	.word 99
	.word -30


.text

main: 	
	li $s1, 0  #i = 0
	li $s2, 0  #sum = 0
	li $s3, 0  #pos = 0
	li $s4, 0  # neg = 0
	la $s5, arr #*arrayPtr = &arr[0];
	
for:	lw  $t0, ($s5)
	add $s2,$s2, $t0
	blt $t0, 0, if2  #if (*(arrayPtr+i) > 0)
	add $s3, $s3, $t0 #pos += *(arrayPtr + i);
if2:	bge $t0, 0, inc   #	if (arr[i] < 0)
	add $s4, $s4, $t0 #neg += *(arrayPtr + i);
inc:	addi $s1, $s1, 1
	addi $s5, $s5, 4
	ble $s1, 10, for

	
	
	move $a0,$s2
	li $v0, 1
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	move $a0, $s4
	li $v0, 1
	syscall 
	li $v0, 10
	syscall	