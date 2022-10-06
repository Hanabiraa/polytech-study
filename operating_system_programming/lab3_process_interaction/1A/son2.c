#include <stdio.h>
#include <signal.h>
#include <unistd.h>


void sig_handler_usr1(int sig)
{
    printf("son2 get USR1 signal %d and IGNORE\n",sig);
    signal(SIGUSR1,SIG_IGN);
}

int main()
{
    int son_pid;
    son_pid=getpid();
    printf("\nson2 %d is starting\n",son_pid);

    signal(SIGUSR1,sig_handler_usr1);

    kill(son_pid,SIGUSR1);

}
