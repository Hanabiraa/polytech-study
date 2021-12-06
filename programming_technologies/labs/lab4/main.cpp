#include "polynomial.h"

int main() {
    Polynomial poly1("-3x^3+4x^2+2x^1+1");
    Polynomial poly2("+3x^3-4x^2-2x^1-1x^0");
    Polynomial poly3("-21");

    Polynomial poly4("-2x^6+5x^3");
    Polynomial poly5("+12x^1+1");

    Polynomial poly6();

    Polynomial poly7("+2x^2+1");
    Polynomial poly8("-3x^2-2x^1");



    std::cout << "Polynomial 1: " << poly1 << '\n';
    std::cout << "Polynomial 2: " << poly2 << '\n';
    std::cout << "Polynomial 3: " << poly3 << '\n';
    std::cout << "Polynomial 4: " << poly4 << '\n';
    std::cout << "Polynomial 5: " << poly5 << '\n';
    std::cout << "Polynomial 6: " << poly6 << '\n';
    std::cout << "Polynomial 7: " << poly7 << '\n';
    std::cout << "Polynomial 8: " << poly8 << '\n' << '\n';

    std::cout << "Polynomial 1 + Polynomial 2: " << poly1 + poly2 << '\n';
    std::cout << "Polynomial 1 + Polynomial 3: " << poly1 + poly3 << '\n';
    std::cout << "Polynomial 4 + Polynomial 5: " << poly4 + poly5 << '\n';
    std::cout << "Polynomial 3 + 21: " << poly3 + 21 << '\n';
    std::cout << "21 + Polynomial 3: " << 21 + poly3 << '\n' << '\n';

    std::cout << "Polynomial 1 - Polynomial 2: " << poly1 - poly2 << '\n';
    std::cout << "Polynomial 3 - Polynomial 2: " << poly3 - poly2 << '\n';
    std::cout << "Polynomial 3 - 21: " << poly3 - 21 << '\n';
    std::cout << "21 - Polynomial 3: " << 21 - poly3 << '\n' << '\n';

    std::cout << "Polynomial 7 * Polynomial 8: " << poly7 * poly8 << '\n';
    std::cout << "Polynomial 3 * 2: " << poly3 * 2 << '\n';
    std::cout << "2 * Polynomial 4: " << 2 * poly4 << '\n' << '\n';

    std::cout << "calculate Polynomial 3 with x=2: " << poly3.calculate(2) << '\n';
    std::cout << "calculate Polynomial 7 with x=2: " << poly7.calculate(2) << '\n';

    return 0;
}
