# CSC 415 - Project 2 - File copy

## Student Name : Jonathan Julian

## Student ID   : 918164239

## Build Instructions  make fc
 
## Run Instructions ./fc

## strace/dtruss output

csc415@csc415:~/csc415-p2-jjulian91$ strace -c ./fc
Welcome to the File Copy Program by Jonathan Julian !
Enter the name of the file to copy from:
415_HW2.pdf
Enter the name of the file to copy to:
PDF2
Copy Successful, 131391 bytes copied
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 61.37    0.024862           4      6261           write
 38.61    0.015642           2      6261           read
  0.02    0.000008           2         4           close
  0.00    0.000002           2         1         1 _llseek
  0.00    0.000000           0         1           execve
  0.00    0.000000           0         3         3 access
  0.00    0.000000           0         4           brk
  0.00    0.000000           0         1           munmap
  0.00    0.000000           0         4           mprotect
  0.00    0.000000           0         5           mmap2
  0.00    0.000000           0         4           fstat64
  0.00    0.000000           0         1           set_thread_area
  0.00    0.000000           0         4           openat
------ ----------- ----------- --------- --------- ----------------
100.00    0.040514                 12554         4 total


