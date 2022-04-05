//
// Created by ... on 28.03.2022.
//

#include <mutex>
#include <iostream>
#include <vector>
#include <cstdlib>
#include <unistd.h>

template<typename T>
class SharedQueue {
    std::vector<T> vec;
    std::recursive_mutex m;
public:
    void get_el() {
        m.lock();
        std::cout << "THREAD " << std::this_thread::get_id() << "get element: " << vec.back() << '\n';\
        vec.pop_back();
        sleep(1);
        m.unlock();
    };

    void push(int val) {
        m.lock();
        std::cout << "BUILDER " << std::this_thread::get_id() << "add element " << val << '\n';
        vec.push_back(val);
        sleep(1);
        m.unlock();
    };

    bool is_empty() {
        return vec.empty();
    }
};