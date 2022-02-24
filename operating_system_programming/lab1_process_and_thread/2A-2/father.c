#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int pid, ppid, status;
    FILE *f = fopen("out.txt", "w");

    pid = getpid();
    ppid = getppid();
    fprintf(f, "father:\nparent pid: %i\nmy pid: %i\n\n", ppid, pid);
    fclose(f);
    if (fork() == 0) {
        execl("son", "son", NULL);
    }
    return 0;

}
