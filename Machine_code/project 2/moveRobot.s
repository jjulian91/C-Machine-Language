#moveRobots(arg0, arg1, arg2, arg3);

#INPUT: robotX[i], robotY[i], userX, userY

#RETURNS: ($v0) status of user 1 (alive) or 0 (dead)

#Takes memory location of 2 arrays botX[], botY[] and loops 4 iterations to update coordinates of robots.

#calls getNew for each coordinate for each robot.
#(&botX)= $a0; 


#(&botY)= $a1; 


#(userX)= $a2; 


#(userY) = $a3


#i = $s0; 


#$s1 = *ptrX; 


#$s2 = *ptrY; 


#$s3 = &ptrX; 


#$s4 = &ptrY;


#$s5 = user



.text



.globl moveRobots

		


moveRobots:	addi 	$sp, $sp, -24		#/* begin preserving S0-S7		
		
		sw	$ra, ($sp)

		sw	$s0, 4($sp)

		sw	$s1, 8($sp)

		sw	$s2, 12($sp)

		sw	$s3, 16($sp)

		sw	$s4, 20($sp)		#end preserving s0-s7*/	


						#{

		li	$s0, 0								#initialize i=0
		
		move	$s3, $a0							#moving &ptrX to local s register

		move	$s4, $a1							#moving &ptrY to local s register

		
for1:						#for (i=0;i<4;i++) {
		
		lw	$s1,($s3)							#loading *ptrX

		lw	$s2,($s4)							#loading *ptrY

		move	$a0, $s1							#moving *ptrX to Arg0

		move	$a1, $a2							#moving userX to Arg1
	

		jal	getNew			#*ptrX = getNew(*ptrX,arg2);
  
		move	$s1, $v0		#// update x-coordinate of robot i

 		sw	$s1, ($s3)

 		move	$a0, $s2							#move *ptrY to $Arg0

 		move	$a1, $a3							#move userY to $Arg1

 	
	jal	getNew			#*ptrY = getNew(*ptrY,arg3);
  
		move	$s2, $v0		#// update y-coordinate of robot i

		sw	$s2, ($s4)

		bne	$s1, $a2, ptrInc	#// check if robot caught user

		bne	$s2, $a3, ptrInc	#if ((*ptrX == arg2) && (*ptrY == arg3)) {

		li	$v0, 0			#alive = 0
		
		j	endmoveRobots		#break
						
						#}

ptrInc:		addi	$s3, $s3, 4		#ptrX++;

		addi	$s4, $s4, 4		#ptrY++;

  		addi	$s0, $s0, 1

  		li	$v0, 1

		blt	$s0, 4, for1		#}

endmoveRobots:					#return alive;


						#}


		lw	$s4, 20($sp)		#/*begin restoring S registers


		lw	$s3, 16($sp)

		lw	$s2, 12($sp)

		lw	$s1, 8($sp)

		lw	$s0, 4($sp)

		lw	$ra, ($sp)

		addi 	$sp, $sp, 24		#end restoring s reigsers*/

		jr	$ra
