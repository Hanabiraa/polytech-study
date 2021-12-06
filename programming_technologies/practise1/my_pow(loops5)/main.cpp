#include <iostream>

int main() {
    double a;
    int b;

    std::cout << "enter a, b which a^b" << std::endl;
    std::cin >> a >> b;

    double res = 1.0;
    int bAbs = (b < 0) ? -b : b;
    for (int i = 1; i <= bAbs; ++i) {
        res *= a;
    }

    std::cout << (b < 0 ? 1.0 / res : res);
    return 0;
}
