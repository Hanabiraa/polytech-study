#include <iostream>
#include <cmath>

double term(int, double);

double calcSum(double, int, double);

int main() {
//    std::cout << "Enter absError, nMax, x" << std::endl;
//    double absError, x;
//    int nMax;
//    std::cin >> absError >> nMax >> x;
    double x = -0.95;
    double h = 0.05;

    while (x < 0.95) {
        try {
            //        std::cout << calcSum(absError, nMax, x);
            std::cout << calcSum(0.000001, 20, x) << '\t';
        }
        catch (const char *e) {
            std::cout << e << '\t';
        }
        std::cout << 1 / sqrt(1 + x) << '\n';
        x += h;
    }
    return 0;
}

double calcSum(double absError, int nMax, double x) {
    if (x <= -1.0 || x >= 1.0) {
        throw "Error! var x too high";
    }

    double result = 1.0;
    double term_local = 0.0;
    for (int i = 1; i <= nMax; ++i) {
        term_local = term(i, x);
        result += term_local;

        if (fabs(term_local) < absError) {
            break;
        }
    }

    if (fabs(term_local) > absError) {
        throw "Error! last term > absError";
    }

    return result;
}

// result (-1)^n * (odd_sum/even_sum) * x^n, n - term position
double term(int n, double x) {
    int sign = 1;
    double even_sum = 1.0;
    double odd_sum = 1.0;
    double x_sum = 1.0;

    for (int i = 1; i <= 2 * n; i += 2) {
        odd_sum *= i;
        even_sum *= i + 1;

        x_sum *= x;
        sign = -sign;
    }
    return sign * (odd_sum / even_sum) * x_sum;
}