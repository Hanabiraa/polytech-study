//
// Created by Виталий Копылов on 10.04.2022.
//
#include <iostream>
#include <cmath>
#include <algorithm>
#include <vector>
#include <list>

using namespace std;

class Shape {
public:
    int x, y;

    bool isMoreLeft(Shape fig) {
        return this->x < fig.x;
    }

    bool isUpper(Shape fig) {
        return this->y > fig.y;
    }

    virtual void draw() {};
};

class Circle : public Shape {
public:
    Circle(int x, int y) {
        this->x = x;
        this->y = y;
    };

    void draw() override {
        cout << "Circle:\t\t(" << this->x << "," << this->y << ")\n";
    }
};

class Triangle : public Shape {
public:
    Triangle(int x, int y) {
        this->x = x;
        this->y = y;
    };

    void draw() override {
        cout << "Triangle:\t(" << this->x << "," << this->y << ")\n";
    }
};

class Square : public Shape {
public:
    Square(int x, int y) {
        this->x = x;
        this->y = y;
    };

    void draw() override {
        cout << "Square:\t\t(" << this->x << "," << this->y << ")\n";
    }
};

class LeftPredicate : public binary_function<Shape *, Shape *, bool> {
public:
    bool operator()(Shape *el1, Shape *el2) const {
        return el1->isMoreLeft(*el2);
    }
};

class UpperPredicate : public binary_function<Shape *, Shape *, bool> {
public:
    bool operator()(Shape *el1, Shape *el2) const {
        return el1->isUpper(*el2);
    }
};


void task2() {
    srand(12);
    list<Shape *> lst;

    Circle c(rand() % 100, rand() % 100);
    Triangle t(rand() % 100, rand() % 100);
    Square s(rand() % 100, rand() % 100);

    lst.push_back(&c);
    lst.push_back(&t);
    lst.push_back(&s);

    cout << "Исходный список:\n";
    for (auto el: lst) {
        el->draw();
    }


    lst.sort(LeftPredicate());
    cout << "\nСлева направо:\n";
    for (auto el: lst) {
        el->draw();
    }

    binary_negate<LeftPredicate> RightPredicate((LeftPredicate()));
    lst.sort(RightPredicate);
    cout << "\nСправа налево:\n";
    for (auto el: lst) {
        el->draw();
    }

    lst.sort(UpperPredicate());
    cout << "\nСверху вниз:\n";
    for (auto el: lst) {
        el->draw();
    }

    binary_negate<UpperPredicate> DownPredicate((UpperPredicate()));
    lst.sort(DownPredicate);
    cout << "\nСнизу вверх:\n";
    for (auto el: lst) {
        el->draw();
    }
}

