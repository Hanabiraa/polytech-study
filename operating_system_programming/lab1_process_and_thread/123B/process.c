//
// Created by sushi on 27.02.2022.
//

#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>
#include "threads.c"

int MAX_THREADS = 4;

int main() {
    pthread_t tid[MAX_THREADS];
    int thread_order[MAX_THREADS];
    for (int i = 0; i < MAX_THREADS; ++i) {
        thread_order[i] = i;
        pthread_create(&tid[i], NULL, single_thread, &thread_order[i]);
    }
    for (int i = 0; i < MAX_THREADS; ++i) {
        pthread_join(tid[i], NULL);
    }
    return 0;
}


