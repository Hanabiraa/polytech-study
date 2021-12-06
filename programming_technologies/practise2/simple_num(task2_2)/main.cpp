#include <iostream>

bool checkSimple(int);

int main() {
    int border;
    std::cout << "Введите верхнюю границу чисел" << std::endl;
    std::cin >> border;



    // Complexity: O(n*n^(1/2))
    for (int i = 2; i <= border; ++i) {
        if (checkSimple(i)) {
            std::cout << i << ' ';
        }
    }

    return 0;
}

// Complexity: O(n^(1/2))
bool checkSimple(int num) {
    if (num < 2) {
        return false;
    }
    for (int i = 2; i * i <= num; ++i) {
        if (!(num % i)) {
            return false;
        }
    }
    return true;
}