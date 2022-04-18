#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void sig_handler_usr1(int sig)
{
    printf("son3 get USR1 signal %d and The signal has been processed\n",sig);
    signal(SIGUSR1,sig_handler_usr1);

}

int main()
{
    int son_pid;
    son_pid=getpid();
    printf("\nson3 %d is starting\n",son_pid);

    signal(SIGUSR1,sig_handler_usr1);

    kill(son_pid,SIGUSR1);

}