//
// Created by sushi on 07.02.2022.
//

#include "task4.h"

void task4() {
    std::ifstream in("/work/polytech-study/object_oriented_programming/lab1/task4_6/input.txt");

    const int BUFFER_SIZE = 100;

    char ** res = (char **) malloc(1 * sizeof(char *));
    int i = 0;
    while (!in.eof()) {
        char *buffer = new char[BUFFER_SIZE];
        in >> buffer;
        res[i] = buffer;
        ++i;
        res =  (char **) realloc(res, (i + 1) * sizeof(char *));
    }

    std::vector<char *> v(res, res + i);

    for (auto str : v) {
        std::cout << str << '\n';
    }
    in.close();
}
