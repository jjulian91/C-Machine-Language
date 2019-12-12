/****************************************************************
 * Name        :  Jonathan Julian                               *
 * Class       :  CSC 415                                       *
 * Date        :  3/14/19 PI DAY!                               *
 * Description :  Writting a simple bash shell program          *
 *                that will execute simple commands. The main   *
 *                goal of the assignment is working with        *
 *                fork, pipes and exec system calls.            *
 ****************************************************************/

#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>

/* CANNOT BE CHANGED */
#define BUFFERSIZE 256
/* --------------------*/
#define PROMPT "myShell >> "
#define PROMPTSIZE sizeof(PROMPT)



int 
main(int* argc, char** argv)
{   
    char *myargv[10];
    char *strToken, *callHelp, *pwd, *buff;
    char bufferReader[BUFFERSIZE];
    bool running = true, waitBool = false, cdBool = false;
    bool inputBool = false, outBool = false;
    bool append = false, pwdBool = false;
    bool piping = false, prev = false;
    int myargc, status = 0, pipeLoc = 0, args2;
    long size;
    char *myargv2[5];
    char *NEWPROMPT;

    while(running){

        pid_t pid; // create child process
        if(!cdBool && !pwdBool)
            pid = fork();
        
        if(pid < 0){//check status of child process
            perror("Failed to fork child: \n");
            return -1;        
        }
        else if(pid == 0 && !cdBool && !pwdBool){//execute child command if prev was not CD.
            //checking for input redirection.
            if(inputBool){ 
                int fd;
                char *fileName = myargv[myargc - 1];
                myargv[myargc - 1] = NULL;
                myargc--;
                if ((fd = open(fileName, O_RDONLY)) < 0) {
                    perror("unable to open file\n");
                    exit(0);
                }
                dup2(fd, 0);
                close(fd);
            }
            //checks for a redirection of output type
            if(outBool){
                int fd;
                char *fileName = myargv[myargc - 1];
                myargv[myargc - 1] = NULL;
                myargc--;
                //checks if needed to be appended
                if(append){
                    if((fd = open(fileName, O_RDWR | O_CREAT | O_APPEND, 0644)) < 0){
                        perror("Unable to open file append\n");
                        exit(0);
                    }
                }
                //overriding output
                else{
                    if((fd = open(fileName, O_RDWR | O_CREAT | O_TRUNC, 0644)) < 0){
                        perror("Unable to open file Tunk\n");
                        exit(0);
                    }
                }
                int fd_out = dup2(fd, 1);
                close(fd);
                if(fd_out != 1){
                    perror("failed to redirect\n");
                }
            }
            //checks for piping
            if(piping){
                int pipe_fd[2];
                pipe(pipe_fd);         
                if(fork()){
                    dup2(pipe_fd[0], 0);
                    close(pipe_fd[0]);
                    close(pipe_fd[1]);
                    if(execvp(myargv2[0],myargv2)<0){
                        fprintf(stderr, "Check args for LHS pipe: \n");
                    exit(1);                        
                    }  
                }
                dup2(pipe_fd[1], 1);
                close(pipe_fd[0]);
                close(pipe_fd[1]);
                
                if(execvp(myargv[0],myargv)<0){
                    fprintf(stderr, "Check Args for RHS pipe: ");
                    exit(1);
                }    
            }
            //runs exec command
            else {
                if(execvp(myargv[0],myargv)<0){
                    fprintf(stderr, "Check Args for single command: \n");
                    return -2;
                }    
            }
        }
        else {
            //checks for CD bool right away to see if needing to cd. 
            if (cdBool){    
                if (chdir(myargv[myargc - 1]) < 0)
                    printf("Error Changing Directories current dir %s\n", myargv[myargc - 1]);
            }
              size = pathconf(".", _PC_PATH_MAX);
             //get size of chars in path
            if ((buff = (char *) malloc((size_t) size)) != NULL){ //allocate memory for path name
                pwd = getcwd(buff, (size_t) size); //get cwd
            } 
            //prints the PWD
            else if (pwdBool) {
                printf("%s\n", pwd);
            }
            //clears the buffer.
            for (int i = 0; i <= sizeof(myargv); i++) {
                myargv[i] = NULL;
            }
            for (int i = 0; i <= sizeof(myargv2); i++) {
                myargv2[i] = NULL;
            }
            //checks to wait for child or not.
            if (waitBool) {
                waitpid(pid, &status, 0);
            }
            if((NEWPROMPT = malloc(strlen(PROMPT)+strlen(pwd)+2)) != NULL){
                    NEWPROMPT[0] = '\0';   // ensures the memory is an empty string
                    strcat(NEWPROMPT,"myshell ");
                    strcat(NEWPROMPT,pwd);
                    strcat(NEWPROMPT, ">>");
            } 
            else {
                perror("malloc failed!\n");
    
            }
            //reset flags
            inputBool = false;
            outBool = false;
            append = false;
            pwdBool = false;
            cdBool = false;
            piping = false;
            //
            
            // print prompt
            printf("%s ", NEWPROMPT);

            //gets user input
            fgets(bufferReader, BUFFERSIZE, stdin);

            //sets first command.
            myargc = 0;
            args2 = 0;

            strToken = strtok_r(bufferReader, " \n", &callHelp); //get first token

            while (strToken != NULL) { //subsequent tokens
                waitBool = true;
                // checking for & command to run in background;
                if (strstr(strToken, "&") != NULL) {
                    waitBool = false;
                }
                //checking for quit/Exit Commands not Case sensitive
                if (strcasecmp(strToken, "quit") == 0 || strcasecmp(strToken, "exit") == 0) {
                    running = false;
                }
                    //check for input redirect
                else if (strstr(strToken, "<") != NULL) {
                    inputBool = true;
                }
                    // check for append first.
                else if (strstr(strToken, ">>") != NULL) {
                    append = true;
                    outBool = true;
                }
                    // check for overwrite redirect
                else if (strstr(strToken, ">") != NULL) {
                    outBool = true;
                    append = false;
                }
                    //check for cd command
                else if (strcasecmp(strToken, "cd") == 0) {
                    cdBool = true;
                }
                                    //check for pwd bool
                else if (strcasecmp(strToken, "pwd") == 0) {
                    pwdBool = true;
                } 
                else if (strstr(strToken, "|") != NULL) {
                    piping = true;
                }
                    //write command for use in execvp()
                else {
                    if (waitBool && !piping) {
                        myargv[myargc] = strToken; //get args
                        //printf("%s\n", myargv[myargc]);
                        //printf("%d\n", pipeLoc);
                        myargc++; //count args
                    }
                    if(piping){
                        myargv2[args2] = strToken;
                        args2++;
                    }
                }
                strToken = strtok_r(NULL, " \n", &callHelp); //get successive tokens         
            }
            if(!running)
                break;
        }


    }
    return 0;
}
