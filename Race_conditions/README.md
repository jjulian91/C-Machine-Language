# CSC 415 - Project 4 - Thread Racing

## Student Name: Jonathan Julian

## Student ID :  918164239

## Build Instructions:  make threadracer

## Run Instructions:  ./threadracer

## Explain why your program produces the wrong output :    The program produces the wrong output (ie not 0) because the loop does not wait for a thread to finish before spawning another. This allows for 2 threads to simultaneously be running without ensuring the global variable they are working with is correctly defined. when i = 0 in the loop the global var = 0, each iteration of the loop for adder is updating the global variable. this is simultaneously running and allows the main loop to increment i.  At this point thread 1 could have updated the global variable anywhere from 0 to max_iteration times.  This means when thread 2 (i = 1) references the global variable the variable can be set to any number up to 10*(max_iteration).  This is random as the processes will finish based on the kernels assignment of priority in the processor. This process occurs until the program is finished with all threads. 
