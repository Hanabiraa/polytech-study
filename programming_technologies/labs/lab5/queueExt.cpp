#include "queueExt.h"

template<class T>
queueExt<T>::queueExt() {
    headPtr = nullptr;
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
    Node<T> *newNode = new Node<T>;
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
    Node<T> *temp = headPtr;
    headPtr = headPtr->next;
    delete temp;
    return data;
}
