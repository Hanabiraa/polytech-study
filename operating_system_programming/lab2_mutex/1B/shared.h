//
// Created by ... on 28.03.2022.
//

#include <mutex>
#include <vector>

class threadSafe_queue {

    std::vector<int> vec;
    std::mutex m;

public:

    int& retrieve_and_delete() {
        int front_value = 0;
        m.lock();
        if( !vec.empty() ) {
            front_value = vec.front();
            vec.pop();
        }
        m.unlock();
        return front_value;
    };

    void push(int val) {
        m.lock();
        rawQueue.push(val);
        m.unlock();
    };

};