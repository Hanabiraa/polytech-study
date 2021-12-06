#include <iostream>
#include <cmath>


double RUNGE_STRICT = 0.3;

// 1/sin(x)^2 = -ctg(x)
double f(double x) {
    return (1 / pow(sin(x), 2));
}

// метод трапеций
double integral(double, double, int);

int main() {
    int n = 100;
    double integral1n = integral(1.0, 2.0, n);
    double integral2n = integral(1.0, 2.0, n * 2);
    double runge = integral2n - integral1n;

    while (((runge < 0) ? -runge : runge) > RUNGE_STRICT) {
        ++n;
        integral1n = integral(1.0, 2.0, n);
        integral2n = integral(1.0, 2.0, n * 2);
        runge = integral2n - integral1n;
    }

    std::cout << "           runge: " << ((runge < 0) ? -runge : runge) << std::endl;
    std::cout << "  integral for n: " << integral1n << std::endl;
    std::cout << "integral for 2*n: " << integral2n << std::endl;
    return 0;
}

// dx * sum(f(x - dx/2))
double integral(double a, double b, int n) {
    double dx = (b - a) / n;
    double result = 0.0;

    while (a <= b) {
        result += f(a - dx / 2);
        a += dx;
    }
    return result * dx;
}