#ifndef LAB5_QUEUEEXT_H
#define LAB5_QUEUEEXT_H

#include <iostream>
#include <algorithm>

template<class T>
class queueExt {
public:
    queueExt();

    queueExt(const queueExt<T> &);

    queueExt(queueExt<T> &&) noexcept;

    queueExt<T> &operator=(const queueExt<T> &);

    queueExt<T> &operator=(queueExt<T> &&) noexcept;

    ~queueExt();

    void push(const  T&, int);

    T pop();

    void deleteLessOrEqvPrior(int);

    template<class TOstream>
    friend std::ostream &operator<<(std::ostream &, const queueExt<TOstream> &);

private:
    void swap(queueExt<T> &other) noexcept {
        std::swap(this->headPtr, other.headPtr);
    }

    template<class TData>
    struct Node {
        TData data;
        int priority;
        Node<TData> *next;
    };

    Node<T> *headPtr;
};

#endif //LAB5_QUEUEEXT_H


template<class T>
queueExt<T>::queueExt() {
    headPtr = nullptr;
}

template<class T>
queueExt<T>::queueExt(const queueExt<T> &other) {
    if (other.headPtr == nullptr) {
        headPtr = nullptr;
        return;
    }
    auto newNode = new Node<T>;
    newNode->data = other.headPtr->data;
    newNode->priority = other.headPtr->priority;
    newNode->next = nullptr;
    headPtr = newNode;

    auto uniqHead = other.headPtr->next;
    auto copyHead = headPtr;
    while (uniqHead != nullptr) {
        auto nextNewNode = new Node<T>;
        nextNewNode->data = uniqHead->data;
        nextNewNode->priority = uniqHead->priority;
        copyHead->next = nextNewNode;

        copyHead = copyHead->next;
        uniqHead = uniqHead->next;
    }
    copyHead->next = nullptr;
}

template<class T>
queueExt<T>::queueExt(queueExt<T> &&other) noexcept {
    headPtr = other.headPtr;
    other.headPtr = nullptr;
}

template<class T>
queueExt<T> &queueExt<T>::operator=(const queueExt<T> &other) {
    if (this != &other) {
        while (headPtr) {
            Node<T> *tmpLocal = headPtr;
            headPtr = headPtr->next;
            delete tmpLocal;
        }

        auto tmp = other;
        swap(tmp);

        // При выходе из функции tmp вызовет деструктор
//        while (tmp.headPtr) {
//            Node<T> *tmpLocal = tmp.headPtr;
//            tmp.headPtr = tmp.headPtr->next;
//            delete tmpLocal;
//        }
    }
    return *this;
}

template<class T>
queueExt<T> &queueExt<T>::operator=(queueExt<T> &&other) noexcept {
    if (this != &other) {
        headPtr = other.headPtr;
        other.headPtr = nullptr;
    }
    return *this;
}

template<class T>
queueExt<T>::~queueExt() {
    while (headPtr) {
        Node<T> *temp = headPtr;
        headPtr = headPtr->next;
        delete temp;
    }
}


template<class T>
void queueExt<T>::push(const T& data, int priority) {
    auto newNode = new Node<T>;
    newNode->data = data;
    newNode->priority = priority;
    newNode->next = nullptr;

    if (headPtr == nullptr) {
        headPtr = newNode;
    } else {
        Node<T> *prev = nullptr;
        Node<T> *curr = headPtr;
        while (curr && curr->priority <= priority) {
            prev = curr;
            curr = curr->next;
        }

        if (prev) {
            newNode->next = curr;
            prev->next = newNode;
        } else {
            newNode->next = curr;
            headPtr = newNode;
        }
    }
}

template<class T>
T queueExt<T>::pop() {
    if (!headPtr) {
        throw std::logic_error("Stack is empty!");
    }
    T data = headPtr->data;
    auto *temp = headPtr;
    headPtr = headPtr->next;
    delete temp;
    return data;
}

template<class T>
std::ostream &operator<<(std::ostream &os, const queueExt<T> &q) {
    auto ptr = q.headPtr;
    while (ptr) {
        os << ptr->data << ' ';
        ptr = ptr->next;
    }
    return os;
}

template<class T>
void queueExt<T>::deleteLessOrEqvPrior(int bound) {
    while (headPtr->priority <= bound && headPtr) {
        Node<T> *temp = headPtr;
        headPtr = headPtr->next;
        delete temp;
    }
}