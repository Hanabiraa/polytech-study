#include "queueExt.h"
#include "queueExt.cpp"

template<class T>
queueExt<T> createQueue(int size) {
    queueExt<T> q{};
    for (int i=0; i < size; ++i) {
        q.push(static_cast<T>(i), i);
    }
    return q;
}

int main() {
    std::cout << "===== INT =====" << '\n';
    queueExt<int> q1{};
    q1.push(11, 1);
    q1.push(12, 2);
    q1.push(13, 3);
    q1.push(14, 4);
    q1.push(15, 5);

    std::cout << q1 << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';
    std::cout << q1.pop() << '\n';

    std::cout << "===== FLOAT =====" << '\n';
    queueExt<float> q2{};
    q2.push(5.5, 6);
    q2.push(6.6, 5);
    q2.push(7.7, 4);
    q2.push(8.8, 3);
    q2.push(9.9, 2);
    std::cout << q2 << "\t\t\t<- original queue" << '\n';
    q2.deleteLessOrEqvPrior(0);
    std::cout << q2 << "\t\t\t<- after .deleteLessOrEqvPrior(...)" << '\n';

    std::cout << "===== COPY =====" << '\n';
    queueExt<int> q3;
    q3.push(10, 1);
    q3.push(11, 1);
    q3.push(12, 1);

    queueExt<int> q4(q3);
    std::cout << "q3: " << q3 << '\n';
    std::cout << "q4: " << q4 << "\t\t<- copy" << '\n';
    std::cout << '\n';
    q3.pop();
    q3.pop();
    q3.pop();
    q4.push(999, 0);
    std::cout << "q3: " << q3 << "\t\t\t\t<- 3x pop()"  << '\n';
    std::cout << "q4: " << q4 <<  "\t<- 1x push()" << '\n';

    std::cout << "===== COPY ASSIGNMENT =====" << '\n';
    queueExt<int> q5{};
    queueExt<int> q6{};
    q5.push(10, 1);
    q5.push(11, 1);
    q5.push(12, 1);

    q6 = q5;
    std::cout << "q5: " << q5 << '\n';
    std::cout << "q6: " << q6 << "\t\t\t<- copy" <<  '\n';
    std::cout << '\n';

    q5.pop();
    q5.pop();
    q5.pop();
    q5.push(1, 1);
    q6.push(999, 0);
    std::cout << "q5: " << q5 << "\t\t\t\t\t<- 3x pop(), 1x push()" << '\n';
    std::cout << "q6: " << q6 << "\t\t<- 1x push()" << '\n';
    std::cout << '\n';

    q5 = q6;
    q5.push(2222, 30);
    q6.pop();
    q6.pop();
    std::cout << "q5: " << q5 << "\t<- copy from q6, 1x push()" << '\n';
    std::cout << "q6: " << q6 << "\t\t\t\t<- 2x pop()" << '\n';

    std::cout << "===== MOVE =====" << '\n';
    queueExt<int> q7 = createQueue<int>(20);
    queueExt<double> q8;
    q8 = createQueue<double>(20);

    std::cout << "           move example: " << q7 << '\n';
    std::cout << "move assignment example: " << q8 << '\n';
    std::cout << "       q7 elements type: " << typeid(q7.pop()).name() << '\n';
    std::cout << "       q8 elements type: " << typeid(q8.pop()).name() << '\n';

    queueExt<double> q9 = std::move(q8);
    std::cout << "    std::move() example: " << q9 << '\n';


    return 0;
}
