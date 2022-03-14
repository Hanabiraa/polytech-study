#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include "shmem.h"
#include <stdlib.h>

Message *msgptr;
int shmid, semid;

void hndlr(int sig) //обработчик сигнала SIGINT
{
    signal(SIGINT, hndlr);

    //отключение от области разделяемой памяти
    if (shmdt(msgptr) < 0) {
        printf("Server: error\n");
        exit(-1);
    }

    //удаление созданных объектов
    if (shmctl(shmid, IPC_RMID, 0) < 0) {
        printf("Server : can't delete area\n");
        exit(-1);
    }
    printf("Server: area is deleted\n");

    if (semctl(semid, 0, IPC_RMID) < 0) {
        printf("Server : can't delete semaphore\n");
        exit(-1);
    }
    printf("Server: semaphores are deleted\n");
}

int main(void) {
    key_t key;
    signal(SIGINT, hndlr);

    //получение ключа как для семафора так и для разделяемой памяти
    if ((key = ftok("/work/polytech-study/operating_system_programming/lab2_mutex/1A/mem.txt", 'A')) < 0) {
        printf("Server: can't get a key\n");
        exit(-1);
    }

    //создание области разделяемой памяти
    if ((shmid = shmget(key, sizeof(Message), PERM | IPC_CREAT))
        < 0) {
        printf("Server: can't create an area\n");
        exit(-1);
    }
    printf("Server: area is created\n");

    //присоединение области
    if ((msgptr = (Message *) shmat(shmid, 0, 0)) < 0) {
        printf("Server: error of joining\n");
        exit(-1);
    }
    printf("Server: area is joined\n");

    //создание группы из 2 семафоров
    //1 – для синхронизации работы с разделяемой памятью
    //2 – для синхронизации выполнения процессов
    if ((semid = semget(key, 2, PERM | IPC_CREAT)) < 0) {
        printf("Server: can't create a semaphore\n");
        exit(-1);
    }
    printf("Server: semaphores are created\n");

    while (1) {
        //ожидание начала работы клиента
        if (semop(semid, &proc_wait[0], 1) < 0) {
            printf("Server: execution complete\n");
            exit(-1);
        }

        //ожидание завершения работы клиента с разделяемой памятью
        if (semop(semid, &mem_lock[0], 2) < 0) {
            printf("Server: can't execute a operation\n");
            exit(-1);
        }
        //вывод сообщения, записанного клиентом разделяемую память
        printf("Server: read message\n%s", msgptr->buff);
        sleep(10);
        //запись сообщения в разделяемую память
        sprintf(msgptr->buff, "Message from server with PID = % d\n", getpid());

        //освобождение ресурса
        if (semop(semid, &mem_unlock[0], 1) < 0) {
            printf("Server: can't execute a operation\n");
            exit(-1);
        }
    }
}