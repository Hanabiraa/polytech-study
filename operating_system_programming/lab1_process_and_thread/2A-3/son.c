#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <pthread.h>

int main() {
    int pid, ppid, status;
    FILE *f = fopen("out.txt", "a+");

    pid = getpid();
    ppid = getppid();
    fprintf(f, "son:\nparent pid: %i\nmy pid: %i\n", ppid, pid);

    fclose(f);
    return 0;
}
