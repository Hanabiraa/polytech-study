//
// Created by sushi on 27.02.2022.
//
#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>

void *single_thread(void *arg);

void *single_thread(void *arg) {
    pthread_t tid = pthread_self();
    int local_arg = *(int *)arg;
    for (int i=0;i < 5; ++i) {
        printf("Thread #%i tid=%ld\t\t ITERATION #%i\n",local_arg, tid, i);
        sleep(5);
    }
    return NULL;
}