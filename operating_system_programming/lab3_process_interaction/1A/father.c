#include <stdio.h>
#include <signal.h>
#include <unistd.h>

int main() {
    int father_pid = getpid();
    int s1_pid;
    int s2_pid;
    int s3_pid;
    int status;


    printf("sig_father %d is starting\n", father_pid);

    if ((s1_pid = fork()) == 0) {
        execl("son1", "SON1", NULL);
    }

    if ((s2_pid = fork()) == 0) {
        execl("son2", "SON2", NULL);
    }

    if ((s3_pid = fork()) == 0) {
        execl("son3", "SON3", NULL);
    }

    //sleep(100);
    //printf("father end\n");
    printf("father end\n");
    return 0;
}

