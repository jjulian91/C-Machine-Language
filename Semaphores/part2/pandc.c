    #include <stdio.h>
    #include <string.h>
    #include <pthread.h>
    #include <ctype.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <time.h>
    #include <semaphore.h>
    #include <stdbool.h>

    /*
    *
    * global vars
    *
    */
    int buffers, producers, consumers;
    int produced, consumed, pSleep, cSleep;
    int overConsume, consumeRemainder;
    int var = 1;
    int *numBuffers;
    sem_t full, empty, Lock;
    int countIn = 0, countOut = 0;
    int *itemAdded, *itemRemoved;
    int addedIndex = 0, removedIndex = 0;

    struct threadArgs{
        int* numberItems;
        pthread_t id;
    };

    /* 
     * Function to remove item.
     * Item removed is returned
     */
    int dequeue_item()
    {
        int itemRem = numBuffers[countOut];
        numBuffers[countOut] = '\0';
        countOut = (countOut + 1) % buffers;
        return itemRem;
    }

    /* 
     * Function to add item.
     * Item added is returned.
     * It is up to you to determine
     * how to use the ruturn value.
     * If you decide to not use it, then ignore
     * the return value, do not change the
     * return type to void. 
     */
    int enqueue_item(int item)
    {
        numBuffers[countIn] = item;
        countIn = (countIn + 1) % buffers;
        return item;
    }

    /*
    * Function for producers to produce
    * Passes in number of items to add to array
    * 
    *
    */
    void *produce(void *products){
        struct threadArgs *prodArgs = (struct threadArgs *)products;
         
        int *producedTemp = ((int *)prodArgs->numberItems);
        pthread_t id = ((pthread_t )prodArgs->id);
        int item;
        for(int i = 0; i < *producedTemp; i++){
            sem_wait(&empty);
            sem_wait(&Lock);
            item = enqueue_item(var++);
            itemAdded[addedIndex] = item;
            addedIndex++;
            sem_post(&Lock);
            sem_post(&full);
            sleep(pSleep);
            printf("%d was produced by Producer->         %lu\n",item, id);
            
        }
        printf("Thread %lu joined\n", id);
        pthread_exit(0);
    }


    /*
    * Function for producers to produce
    * Passes in number of items to add to array
    * 
    */
    void *consume(void *consume){
        struct threadArgs *consArgs = (struct threadArgs *)consume;
        int *consumeTemp = (int *)consArgs->numberItems;
        pthread_t id = (pthread_t )consArgs->id-producers;
        int item;
        for(int i = 0; i < *consumeTemp; i++){
            sem_wait(&full);
            sem_wait(&Lock);
            item = dequeue_item();
            itemRemoved[removedIndex] = item; 
            removedIndex++;
            sem_post(&Lock);
            sem_post(&empty);
            sleep(cSleep);
            printf("%d was Consumed by Consumer->        %lu\n", item, id);
        }
        printf("Thread %lu joined\n", id);
        pthread_exit(0);
    }


    int main(int argc, char** argv) {

        //reads in args
        if(argc == 7){    
            buffers = atoi(argv[1]); //n
            producers = atoi(argv[2]); //p
            consumers = atoi(argv[3]); //c
            produced = atoi(argv[4]); //x
            pSleep = atoi(argv[5]);     
            cSleep = atoi(argv[6]);           
        }
        else{
            perror("incorrect number of arguments");
        }

        //init lock
        sem_init(&Lock, 0, 1);
        sem_init(&full, 0, 0);
        sem_init(&empty, 0, buffers);


        //calculate consumer
        consumed = (producers*produced)/consumers;

        //check for overcomsumed
        if((producers*produced)%consumers != 0){
            overConsume = 1;
            consumeRemainder = ((producers*produced)%consumers);
        }

        int totalThreads = consumers + producers;
        //print for help
        printf("Number of Buffers :     %d\n", buffers);
        printf("Number of Producers :     %d\n", producers);
        printf("Number of Consumers :     %d\n", consumers);
        printf("Number of Items produced by each Producer :     %d\n", produced);
        printf("Number of Items consumed by each Consumer :     %d\n", consumed);
        printf("Time of Producer Sleep :     %d\n", pSleep);
        printf("Time of Consumer Sleep :     %d\n", cSleep);
        printf("OverConsume? :      %d\n", overConsume);
        printf("Over consume Amount :    %d\n", consumeRemainder);

        int overConsumed = consumeRemainder + consumed;

        itemAdded = (int *)malloc(sizeof(int)*produced*producers);
        itemRemoved = (int *)malloc(sizeof(int)*produced*producers);

        //Create N buffers of size x;
        numBuffers = (int *)malloc(sizeof(int)*buffers); //populate number of buffers

        //set up threadID's
        pthread_t tid[totalThreads];
        for(int i = 0; i < (totalThreads); i++){
            tid[i] = i+1;
        }

        time_t start = time(0);
        for(int i = 0; i < totalThreads; i++){
            struct threadArgs *args = (struct threadArgs *)malloc(sizeof(struct threadArgs));
            args->id = tid[i];
            //printf("making things\n");
            if(i < producers){
                args->numberItems = &produced;
                if(pthread_create(&tid[i], NULL, produce, (void *)args))
                    perror("unable to Create PRODUCER\n");

            }
            else{
                if(i-producers == consumers-1){
                   args->numberItems = &overConsumed;
                    if(pthread_create(&tid[i], NULL, consume, (void *)args))
                        perror("unable to Create Over Consumer\n");
                }
                else{
                    args->numberItems = &consumed;
                    if(pthread_create(&tid[i], NULL, consume, (void *)args))
                        perror("unable to Create Consumer\n");

                }

            }
       }
        //waiting for threads to join.
        for(int i = 0; i < totalThreads; i++) {
            pthread_join(tid[i], NULL);
        }

        time_t end = time(0);
      

        bool test = true; //test not failed

        for(int i = 0; i <= addedIndex; i++){
            if(itemAdded[i] != itemRemoved[i])
                test = false;
            printf("%d   |", itemAdded[i]);
            printf("     %d\n", itemRemoved[i]);
        }
        time_t final = end - start;

        if(test)
            printf("Success! you've passed\n");
        else{printf("Sorry please check your work\n");}

        printf("Elapsed Time:     %lu seconds\n", final);
            //printf("added %d elements\n", addedIndex);
            //printf("removed %d elements\n", removedIndex);


        //getrid of lock
        sem_destroy(&Lock);
        sem_destroy(&full);
        sem_destroy(&empty);
    }
