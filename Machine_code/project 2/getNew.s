#beginning of int getNew(int arg0, int arg1)
#INPUT: *botCoordinate, User Coordinate 
#RETURNS: new bot coordinate 
#Takes corresponding userCoordinate and checks it to robotsCoordinate
#moves robot closer to user based on distance away

.text

#arg0 = *botCoordinate

#arg1 = userCoordinate

#temp = $t0

#result = $v0

.globl getNew


						#{
getNew:		sub	$t0, $a0, $a1		#int temp, result;
		blt	$t0, 11, test2		#temp = arg0 - arg1;
		addi	$v0, $a0, -10		#if (temp >= 10)		
		jr	$ra			#result = arg0 - 10;
		
test2:		ble	$t0, 0, test3		#else if (temp > 0)
		addi 	$v0, $a0, -1		#result = arg0 - 1;
		jr	$ra
		
test3:		bne	$t0, 0, test4		#else if (temp == 0)
		move	$v0, $a0		#result = arg0;
		jr	$ra
		
test4:		ble	$t0, -10, test5		#else if (temp > -10)
		addi	$v0, $a0, 1		#result = arg0 + 1;
		jr	$ra
		
test5:		addi $v0, $a0, 10		#else if (temp <= -10)
		jr	$ra				#result = arg0 + 10;		
						#return result;  
