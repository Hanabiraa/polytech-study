#include "queueExt.h"
#include "queueExt.cpp"

int main() {
    std::cout << "===== INT =====" << '\n';
    queueExt<int> q1{};
    q1.push(11, 3);
    q1.push(12, 2);
    q1.push(13, 4);
    q1.push(14, 5);
    q1.push(15, 6);
    q1.push(10, 1);
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';

    std::cout << "===== FLOAT =====" << '\n';
    queueExt<float> q2{};
    q2.push(5.5, 1);
    q2.push(6.6, 2);
    q2.push(7.7, 3);
    q2.push(8.8, 4);
    q2.push(9.9, 5);
    q2.push(10.10, 6);
    std::cout << q2.pop() << '\n';
    std::cout << q2.pop() << '\n';
    std::cout << q2.pop() << '\n';
    std::cout << q2.pop() << '\n';
    std::cout << q2.pop() << '\n';
    std::cout << q2.pop() << '\n';
    return 0;
}
