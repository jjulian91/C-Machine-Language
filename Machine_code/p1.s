#beginning of moveRobots()
#arg0 = $a0; arg1 = $a1; arg2 = $a2; arg3 = $a3
#i = $s0; ptrX = $s1; ptrY = $s2; $v0 = alive = 1; $s3 = *ptrX; $s4 = *ptrY;


moveRobots:	addi 	$sp, $sp, -32		#int moveRobots(int *arg0, int *arg1, int arg2, int arg3)

		sw	$ra, ($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw	$s2, 12($sp)
		sw	$s3, 16($sp)
		sw	$s4, 20($sp)
		sw	$s5, 24($sp)
		sw	$s6, 28($sp)
		sw	$s7, 32($sp)#{
 

		#int i, *ptrX, *ptrY, alive = 1;  /*unused ptrX = arg0; ptrY = arg1;*/
 
		li	$v0, 1
		li	$t0, 0
		move	$s1,$a0
						#update arg0 to *ptrX for getNew()
		move	$22, $a1
						#for (i=0;i<4;i++) {

for1:		lw	$a1, ($s2)		
		lw	$a0, ($s1)
		jal	getNew			#*ptrX = getNew(*ptrX,arg2);  
		sw	$v0, ($s1)
		move	$s3, $v0		#// update x-coordinate of robot i
 
		jal	getNew			#*ptrY = getNew(*ptrY,arg3);  
		sw	$v0, ($s2)		#// update y-coordinate of robot i
		move	$s4, $v0	
		bne	$s3, $a2 ptrInc		#// check if robot caught user
    
		bne	$s4, $a3 ptrInc		#if ((*ptrX == arg2) && (*ptrY == arg3)) {
  
		li	$v0, 0			#alive = 0
		j	endmoveRobots		#break
						#}

ptrInc:		addi	$s1, $s1, 4		#ptrX++;

		addi	$s2, $s2, 4		#ptrY++;
  		addi	$s0, $s0, 1
		blt	$s0, 4, for1					    								    
								
  
							#}
  
endmoveRobots:						#return alive;

						#}
		lw	$s7, 32($sp)
		lw	$s6, 28($sp)
		lw	$s5, 24($sp)
		lw	$s4, 20($sp)
		lw	$s3, 16($sp)
		lw	$s2, 12($sp)
		lw	$s1, 8($sp)
		lw	$s0, 4($sp)
		lw	$ra, ($sp)
		addi 	$sp, $sp, 36
		jr	$ra
