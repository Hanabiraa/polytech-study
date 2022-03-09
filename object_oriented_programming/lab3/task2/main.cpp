#include <iostream>
#include <list>
#include <vector>
#include <cstdlib>

std::list<int> gen_list(int n) {
    std::srand(0);
    std::list<int> list;
    for (int i = 0; i < n; ++i) {
        list.push_back(std::rand() % 21);
    }
    return list;
}

void print(const std::list<int> &list) {
    if (!list.size()) {
        return;
    }

    std::cout << "Исходный список, size: " << list.size() << "\t:= ";
    for (auto el: list) {
        std::cout << el << ' ';
    }
    std::cout << '\n';

    std::cout << "Модифицированный вывод\t\t:= ";
    auto head = list.begin();
    auto tail = --list.end();
    while (true) {
        if (head != tail) {
            std::cout << *head << ' ';
            std::cout << *tail << ' ';
            ++head;
        }
        if (head != tail) {
            --tail;
        } else {
            if (list.size() % 2) std::cout << *tail << ' ';
            break;
        }
    }
    std::cout << "\n\n";
}

int main() {
    std::vector<int> size = {0, 1, 2, 3, 4, 5, 7, 14};

//    auto l = gen_list(2);
//    print(l);
    for (auto n : size) {
        auto l = gen_list(n);
        print(l);
    }
    return 0;
}
