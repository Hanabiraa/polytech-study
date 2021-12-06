#ifndef LAB5_QUEUEEXT_H
#define LAB5_QUEUEEXT_H

#include <iostream>

template<class T>
class queueExt {
public:
    queueExt();

    ~queueExt();

    void push(T, int);

    T pop();

private:
    template<class TData>
    struct Node {
        TData data;
        int priority;
        Node<TData> *next;
    };

    Node<T> *headPtr;
};

#endif //LAB5_QUEUEEXT_H
