# Begins Robot Game
# input: usermove		
# output: coordinates of robots, user, status of game.

	.data		

x:	.word	0:4	# x-coordinates of 4 robots

y:	.word	0:4	# y-coordinates of 4 robots

str1:	.asciiz	"Your coordinates: 25 25\n"

str2:	.asciiz	"Enter move (1 for +x, -1 for -x, 2 for + y, -2 for -y):"

str3:	.asciiz	"Your coordinates: " 

sp:	.asciiz	" "

endl:	.asciiz	"\n"

str4:	.asciiz	"Robot at "

str5:	.asciiz	"AAAARRRRGHHHHH... Game over\n"
	
#i	$s0  
	
#myX	$s1

#myY	$s2

#move	$s3

#status	$s4

#temp,pointers	$s5,$s6
	
.text
	
.globl	main

main:		li	$s1,25		#  myX = 25
		li	$s2,25		#  myY = 25
		li	$s4,1		#  status = 1
		la	$s5,x
		la	$s6,y
		sw	$0,($s5)	#  x[0] = 0; y[0] = 0;
		sw	$0,($s6)
		sw	$0,4($s5)	#  x[1] = 0; y[1] = 50;
		li	$s7,50
		sw	$s7,4($s6)
		sw	$s7,8($s5)	#  x[2] = 50; y[2] = 0;
		sw	$0,8($s6)
		sw	$s7,12($s5)	#  x[3] = 50; y[3] = 50;
		sw	$s7,12($s6)
		la	$a0,str1	#  cout << "Your coordinates: 25 25\n";
		li	$v0,4
		syscall
		bne	$s4,1,exitw	#  while (status == 1) {
while:  	la	$a0,str2	#    cout << "Enter move (1 for +x, 
		li	$v0,4		#	-1 for -x, 2 for + y, -2 for -y):";
		syscall
		li	$v0,5		#    cin >> move;
		syscall
		move	$s3,$v0
		bne	$s3,1,else1	#    if (move == 1)
		add	$s1,$s1,1	#      myX++;
		b	exitif
else1:		bne	$s3,-1,else2	#    else if (move == -1)
		add	$s1,$s1,-1	#      myX--;
		b	exitif
else2:		bne	$s3,2,else3	#    else if (move == 2)
		add	$s2,$s2,1	#      myY++;
		b	exitif
else3:		bne	$s3,-2,exitif	#    else if (move == -2)
		add	$s2,$s2,-1	#      myY--;
exitif:		la	$a0,x		#    status = moveRobots(&x[0],&y[0],myX,myY);
		la	$a1,y
		move	$a2,$s1
		move	$a3,$s2
		jal	moveRobots
		move	$s4,$v0	
		la	$a0,str3	#    cout << "Your coordinates: " << myX 
		li	$v0,4		#      << " " << myY << endl;
		syscall
		move	$a0,$s1
		li	$v0,1
		syscall
		la	$a0,sp
		li	$v0,4
		syscall
		move	$a0,$s2
		li	$v0,1
		syscall
		la	$a0,endl
		li	$v0,4
		syscall
		la	$s5,x
		la	$s6,y
		li	$s0,0		#    for (i=0;i<4;i++)
for:		la	$a0,str4	#      cout << "Robot at " << x[i] << " " 
		li	$v0,4		#           << y[i] << endl;
		syscall
		lw	$a0,($s5)
		li	$v0,1
		syscall
		la	$a0,sp
		li	$v0,4
		syscall
		lw	$a0,($s6)
		li	$v0,1
		syscall
		la	$a0,endl
		li	$v0,4
		syscall
		add	$s5,$s5,4
		add	$s6,$s6,4
		add	$s0,$s0,1
		blt	$s0,4,for
		beq	$s4,1,while				#  }			
exitw:		la	$a0,str5	#  cout << "AAAARRRRGHHHHH... Game over\n";
		li	$v0,4
		syscall
		li	$v0,10		#}
		syscall