#ifndef LAB5_QUEUEEXT_H
#define LAB5_QUEUEEXT_H

#include <iostream>
#include <complex>

template<class T>
class queueExt {
public:
    queueExt();

    queueExt(const queueExt<T> &);

    queueExt(queueExt<T> &&) noexcept;

    queueExt<T> &operator=(const queueExt<T> &);

    queueExt<T> &operator=(queueExt<T> &&) noexcept;

    ~queueExt();

    void push(T, int);

    T pop();

    void deleteLessOrEqvPrior(int);

    template<class TT>
    friend std::ostream &operator<<(std::ostream &, const queueExt<TT> &);

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
