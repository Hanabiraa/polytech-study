#include <iostream>
#include <chrono>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <unistd.h>
#include <functional>
#include <mutex>
#include <vector>
#include <cstdlib>
#include <unistd.h>

template<typename T>
class SharedQueue {
    std::vector <T> vec;
    std::recursive_timed_mutex m;
public:
    void get_el() {
        m.lock();
        if (!vec.empty()) {
            std::cout << "THREAD " << std::this_thread::get_id() << "\tget element: " << vec.back() << '\n';\
            vec.pop_back();
        } else {
            std::cout << "THREAD wait builder " << std::this_thread::get_id() << '\n';
        }
        sleep(1);
        m.unlock();
    };

    void push(int val) {
        m.lock();
        std::cout << "BUILDER " << std::this_thread::get_id() << "\tadd element: " << val << '\n';
        vec.push_back(val);
        sleep(1);
        m.unlock();
    };
};

void add_elem(SharedQueue<int> &container) {
    int counter = rand() % 3;
    for (int i = 0; i < counter; ++i) {
        container.push(rand() % 50);
    }
}

void get_elem(SharedQueue<int> &container) {
    container.get_el();
    sleep(1);
}

int main() {
    srand(3);
    SharedQueue<int> q;

    while (true) {
        std::thread builder(&add_elem, std::ref(q));
        std::thread getter1(&get_elem, std::ref(q));
        std::thread getter2(&get_elem, std::ref(q));
        std::thread getter3(&get_elem, std::ref(q));

        builder.join();
        getter1.join();
        getter2.join();
        getter3.join();
    }

    return 0;
}