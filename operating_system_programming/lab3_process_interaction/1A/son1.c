#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void sig_handler_usr1(int sig)
{
    printf("son1 get USR1 signal %d and DEFAULT ACTIONS\n",sig);
    signal(SIGUSR1,SIG_DFL);
}

int main()
{
    int son_pid;
    son_pid=getpid();
    printf("son1 %d is starting\n",son_pid);
    signal(SIGUSR1,sig_handler_usr1);

    kill(son_pid,SIGUSR1);
}