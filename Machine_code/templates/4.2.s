#
# CSc 256 Example 4.2: Poly function
# Name: William Hsu
# Date: 6/22/2010
# Description:  Computes x^4 + x^3 + 1, x from 2 to 4

	.data
endl:	.asciiz	"\n"

# i	  $s0
# 4	  $s1

	.text
main:	li	$s1, 4
	li	$s0, 2		#  for (i=2; i<=4; i++) {
m_for:	move	$a0, $s0	#    result = poly(i);
	jal	poly

	move	$a0, $v0	#    cout << result << endl;
	li	$v0, 1
	syscall

	la	$a0, endl
	li	$v0, 4
	syscall

	addi	$s0, $s0, 1	#  }
	ble	$s0, $s1, m_for

	li	$v0, 10		#}
	syscall

# int poly(int arg) 
# arg	$a0
# return result in $v0

# computes arg^4 + arg^3 + 1
# copy of arg	$s0
# temp1		$s1

poly:	addi	$sp, $sp, -12
	sw	$s1, ($sp)
	sw	$s0, 4($sp)
	sw	$ra, 8($sp)

	move	$s0, $a0
	li	$a1, 4		#  temp1 = pow(arg, 4);
	jal	pow
	move	$s1, $v0

	move	$a0, $s0	#  result = pow(arg, 3);
	li	$a1, 3
	jal	pow

	add	$v0, $v0, $s1	#  result = temp1 + result + 1;
	addi	$v0, $v0, 1

	lw	$ra, 8($sp)
	lw	$s0, 4($sp)
	lw	$s1, ($sp)
	addi	$sp, $sp, 12	#  return result;
	jr	$ra		#}

# int pow(int arg0, int arg1)
# arg0          $a0
# arg1          $a1
# return result in $v0

# Computes arg0 to the arg1-th power
# i             $t0
# product       $t1

pow:    li      $t1, 1          #  int product = 1;
        li      $t0, 0          #  for (int i=0; i<arg1; i++) {
        bge     $t0, $a1, endpow
for:    mul     $t1, $t1, $a0   #    product *= arg0;
        addi    $t0, $t0, 1     #  }
        blt     $t0, $a1, for

endpow: move    $v0, $t1        #  return product;
        jr      $ra             #}

