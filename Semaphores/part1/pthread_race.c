#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
/**
 * THESE DEFINE VALUES CANNOT BE CHANGED.
 * DOING SO WILL CAUSE POINTS TO BE DEDUCTED
 * FROM YOUR GRADE
 */
 /** BEGIN VALUES THAT CANNOT BE CHANGED */
#define MAX_THREADS 16
#define MAX_ITERATIONS 40
/** END VALUES THAT CANNOT BE CHANGED */
int var = 0;

pthread_mutex_t lock;

/**
 * use this struct as a parameter for the
 * nanosleep function.
 * For exmaple : nanosleep(&ts, NULL);
 */
struct timespec ts = {0, 123456};


void *adderThread(void *vargp){

    int *threadid = (int *)vargp;
    
    for(int i = 0; i < MAX_ITERATIONS; i++){
        pthread_mutex_lock(&lock);
        int temp = var;
        temp = temp + 10;
        //printf("Current Value written to Global Variables by ADDER thread id: %d is %d\n", *threadid, temp);
        nanosleep(&ts, NULL);
        var = temp;
        pthread_mutex_unlock(&lock);
    }
     
    
}

void *subThread(void *vargp){

    int *threadid = (int *)vargp;
    for(int i = 0; i < MAX_ITERATIONS; i++){
    
        nanosleep(&ts, NULL);
        pthread_mutex_lock(&lock);
        int temp = var;
        temp = temp - 10; 
        //printf("Current Value written to Global Variables by SUBTRACTOR thread id: %d is %d\n", *threadid, temp);
        var = temp;
        pthread_mutex_unlock(&lock);
    }
    
}


int
main(int argc, char** argv)
{   
    pthread_t tid[MAX_THREADS];
    for(int i = 0; i < MAX_THREADS; i++){

        if(i%2 == 0){
            pthread_create(&tid[i], NULL, adderThread, (void *)&tid);
        }
        else{
            pthread_create(&tid[i], NULL, subThread, (void *)&tid);
        }
    }
    for (int i = 0; i < MAX_THREADS; i++)
        pthread_join(tid[i], NULL);
    pthread_mutex_destroy(&lock);
    
    printf("Final Value of Shared Variable : %d\n", var);
    return 0;
}

