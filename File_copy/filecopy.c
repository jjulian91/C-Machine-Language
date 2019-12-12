#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
//You may also add more include directives as well.

// THIS VALUE CANNOT BE CHANGED.
// You should use this value when creating your buffer.
// And also to limit the amount of bytes each read CAN do.
#define BUFF_MAX 21
#define NAME "Jonathan Julian"
// ABOVE VALUE CANNOT BE CHANGED //



int
main(int argc, char const *argv[])
{
 char fileName[20], buf[BUFF_MAX], newFileName[20];
    
    int fileOpen, fileWrite;
    ssize_t nbytes, nullByte;
    long finalBytes;
    nbytes = sizeof(buf);
    
    printf("Welcome to the File Copy Program by %s !\n", NAME);
    printf("Enter the name of the file to copy from:\n");
    scanf("%s", fileName);
    fileOpen = open(fileName, O_RDONLY);
    if(fileOpen == -1){ //error our if file does not open
        perror("Failed to open file specified");
        return -1;
    }
    printf("Enter the name of the file to copy to:\n");
    scanf("%s", newFileName);
    fileWrite = open(newFileName, O_WRONLY | O_CREAT);
    
    if(fileWrite == -1){
        perror("failed to find or create file");
        return -2;
    }
    

    else{ //begins to read file
        while((nullByte = read(fileOpen, buf, nbytes))>0){ //reads file into buffer or end of file
            finalBytes = finalBytes + nullByte;  //keep track of total bytes written          
            write(fileWrite, buf, nullByte);   //write bytes         
        } //end while    
    } //end else

    close(fileOpen);
    close(fileWrite);
    if(finalBytes > 0){
        printf("Copy Successful, %ld bytes copied\n", finalBytes);
    }
    else{
        printf("Failed to copy file\n");
        printf("%ld\n", finalBytes);    
    }
    

    return 0;
}
