#include <stdio.h>
#include <signal.h>
#include <unistd.h>

int main() {
    int son_pid;
    int status;
    son_pid = getpid();
    printf("sig_son %d is starting\n", son_pid);

    status = kill(getppid(), SIGUSR1);
    if (status == -1) {
        perror("kill");
    } else {
        printf("Send signal SIGUSR1 to Father\n");
    }

    status = kill(getppid(), SIGUSR2);
    if (status == -1) {
        perror("kill");
    } else {
        printf("Send signal SIGUSR2 to Father\n");
    }


    status = kill(getppid(), SIGCHLD);
    if (status == -1) {
        perror("kill");
    } else {
        printf("Send signal SIGCHLD to Father\n");
    }

    status = kill(getppid(), SIGINT);
    if (status == -1) {
        perror("kill");
    } else {
        printf("Send signal SIGINT to Father\n");
    }

    return 0;
}
