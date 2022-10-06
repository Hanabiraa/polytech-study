#include <iostream>
#include <chrono>
#include <thread>
#include <mutex>
#include "shared.h"
#include <cstdlib>
#include <unistd.h>
#include <functional>

void add_elem(SharedQueue<int> &container) {
    srand(0);
    int counter = rand() % 10;
    for (int i = 0; i < counter; ++i) {
        container.push(rand() % 50);
    }
}

void get_elem(SharedQueue<int> &container) {
    container.get_el();
}

int main() {
    srand(0);
    SharedQueue<int>  q;
    std::thread builder(add_elem, std::ref(q));

    builder.join();

//    std::thread getter1(get_elem, std::ref(q));
//    std::thread getter2(get_elem, std::ref(q));
//    std::thread getter3(get_elem, std::ref(q));
//
//    getter1.join();
//    getter2.join();
//    getter3.join();
    sleep(10);


    return 0;
}