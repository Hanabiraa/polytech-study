#ifndef LAB4_POLYNOMIAL_H
#define LAB4_POLYNOMIAL_H

#include <iostream>
#include <vector>
#include <string>
#include <cmath>
#include <cctype>

class Polynomial {
public:
    Polynomial();

    explicit Polynomial(const std::string);

    Polynomial operator+(const Polynomial &) const;
    friend Polynomial operator+(const int num, const Polynomial &poly2);
    friend Polynomial operator+(const Polynomial &poly2,const int num);

    Polynomial operator-(const Polynomial &) const;
    friend Polynomial operator-(const int num, const Polynomial &poly2);
    friend Polynomial operator-(const Polynomial &poly2,const int num);

    Polynomial operator*(const Polynomial &) const;
    friend Polynomial operator*(const int num, const Polynomial &poly2);
    friend Polynomial operator*(const Polynomial &poly2,const int num);

    int calculate(const int);
    friend std::ostream &operator<<(std::ostream &, const Polynomial &);


private:
    std::vector<int> poly_;
};


#endif //LAB4_POLYNOMIAL_H
