#include "queueExt.h"

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
        copyHead->next = new Node<T>;
        copyHead = copyHead->next;
        copyHead->data = uniqHead->data;
        copyHead->priority = uniqHead->priority;

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
    if (this == &other) {
        return *this;
    }

    while (headPtr) {
        Node<T> *temp = headPtr;
        headPtr = headPtr->next;
        delete temp;
    }

    if (other.headPtr != nullptr) {
        auto newNode = new Node<T>;
        newNode->data = other.headPtr->data;
        newNode->priority = other.headPtr->priority;
        newNode->next = nullptr;
        headPtr = newNode;

        auto uniqHead = other.headPtr->next;
        auto copyHead = headPtr;
        while (uniqHead != nullptr) {
            copyHead->next = new Node<T>;
            copyHead = copyHead->next;
            copyHead->data = uniqHead->data;
            copyHead->priority = uniqHead->priority;

            uniqHead = uniqHead->next;
        }
        copyHead->next = nullptr;
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
void queueExt<T>::push(T data, int priority) {
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

