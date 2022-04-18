#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

void sig_handler_usr1(int sig) {
    printf("\n\nusr1 handler %d\n", sig);
    if (sig == SIGUSR1) {
        printf("father: my signal\n");
    } else {
        printf("father: not my signal\n");
    }
    signal(SIGUSR1, sig_handler_usr1);
}

void sig_handler_usr2(int sig) {
    printf("\n\nusr2 handler %d\n", sig);
    if (sig == SIGUSR2) {
        printf("father: my signal\n");
    } else {
        printf("father: not my signal\n");
    }
    signal(SIGUSR2, sig_handler_usr2);
}

int main() {
    int father_pid, son_pid, status;
    father_pid = getpid();
    printf("sig_father %d is starting\n", father_pid);


    if ((son_pid = fork()) == 0) {
        execl("son", "Sig_son", NULL);
    }

    signal(SIGUSR1, sig_handler_usr1);
    signal(SIGUSR2, sig_handler_usr2);
    signal(SIGINT, SIG_DFL);
    signal(SIGCHLD, SIG_IGN);
    //printf("father end\n");

    wait(&status);
    printf("father end\n");
    return 0;
}