#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

void client(int, int);

void server(int, int);

int main(int argc, char **argv) {
    int pipe1[2], pipe2[2];
    pid_t childpid;
    pipe(pipe1);
    pipe(pipe2);
    if ((childpid = fork()) == 0) {// child
        close(pipe1[1]);
        close(pipe2[0]);
        server(pipe1[0], pipe2[1]);
        exit(0);
    }
// parent
    close(pipe1[0]);
    close(pipe2[1]);
    client(pipe2[0], pipe1[1]);
    waitpid(childpid, NULL, 0);
    exit(0);
}

void client(int readfd, int writefd) {
    const int MAXLINE = 1000;

    size_t len;
    ssize_t n;
    char buff[MAXLINE];
    printf("Input file name here: ");
    fgets(buff, MAXLINE, stdin);
    len = strlen(buff);
    if (buff[len - 1] == '\n')
        len--;
    write(writefd, buff, len);
    while ((n = read(readfd, buff, MAXLINE)) > 0) {
        printf("%s", buff);
    }
}

void server(int readfd, int writefd) {
    const int MAXLINE = 1000;

    int fd;
    ssize_t n;
    char buff[MAXLINE + 1];

    if ((n = read(readfd, buff, MAXLINE)) == 0) {
        write(writefd, "error! NULL read pipe\n", MAXLINE);
        return;
    }
    // вызов ошибки пустого пайпа
//    if ((n = read(readfd, buff, MAXLINE)) > 0) {
//        write(writefd, "error! NULL read pipe\n", MAXLINE);
//        return;
//    }
    buff[n] = '\0';
    if ((fd = open(buff, O_RDONLY)) < 0) {
        write(writefd, "error. Bad file name!\n", MAXLINE);
    } else {
        while ((n = read(fd, buff, MAXLINE)) > 0) {
            write(writefd, buff, n);
        }
        close(fd);
    }
}