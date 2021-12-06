#include "polynomial.h"

Polynomial::Polynomial() {
    poly_.insert(poly_.begin(), 25, 0);
}

Polynomial::Polynomial(const std::string rawPoly) {
    try {
        // normalization
        poly_.insert(poly_.begin(), 25, 0);

        for (int i = 0; i < rawPoly.size(); ++i) {
            // read sign
            int sign = 1;
            switch (rawPoly[i]) {
                case '-':
                    sign = -1;
                    break;
                case '+':
                    sign = 1;
                    break;
                default:
                    std::string errorMes = "problem with sign, iterator pos: ";
                    errorMes += std::to_string(i);
                    throw (errorMes);
            }
            ++i;

            // read coef
            if (!(std::isdigit(rawPoly[i]))) {
                std::string errorMes = "problem with term, after sign bad symbols, iterator pos: ";
                errorMes += std::to_string(i);
                throw (errorMes);
            }

            std::string coefNum;
            while (std::isdigit(rawPoly[i]) && i < rawPoly.size()) {
                coefNum += rawPoly[i];
                ++i;
            }

            // read degree and set coef value depend on degree
            if (rawPoly[i] != 'x' && i < rawPoly.size()) {
                std::string errorMes = "problem with term var x, iterator pos: ";
                errorMes += std::to_string(i);
                throw (errorMes);
            }

            // for degree = 0
            if (rawPoly[i] != 'x' && i >= rawPoly.size()) {
                poly_[0] = sign * std::stoi(coefNum);
                break;
            }

            ++i;
            if (rawPoly[i] != '^' && i < rawPoly.size()) {
                std::string errorMes = "problem with degree, iterator pos: ";
                errorMes += std::to_string(i);
                throw (errorMes);
            }
            ++i;

            if (!(std::isdigit(rawPoly[i]))) {
                std::string errorMes = "problem with term, after sign bad symbols, iterator pos: ";
                errorMes += std::to_string(i);
                throw (errorMes);
            }

            // read degree
            std::string degreeNum;
            while (std::isdigit(rawPoly[i]) && i < rawPoly.size()) {
                degreeNum += rawPoly[i];
                ++i;
            }
            --i;

            // set coef value depend on degree
            poly_[std::stoi(degreeNum)] = sign * std::stoi(coefNum);
        }
    }
    catch (std::string str) {
        std::cout << "Bad allocation: " << str << '\n';
        throw;
    }
    catch (...) {
        throw;
    }
}

std::ostream &operator<<(std::ostream &stream, const Polynomial &poly) {
    for (int i = poly.poly_.size() - 1; i > 0; --i) {
        if (poly.poly_[i] != 0) {
            stream << ((poly.poly_[i] > 0) ? '+' : '-') << ' ' << abs(poly.poly_[i]) << "x^" << i << ' ';
        }
    }
    if (poly.poly_[0] != 0) {
        stream << ((poly.poly_[0] > 0) ? '+' : '-') << ' ' << abs(poly.poly_[0]);
    }
    return stream;
}

Polynomial Polynomial::operator+(const Polynomial &poly2) const {
    Polynomial answer;
    std::vector<int> smallPoly;
    if (this->poly_.size() > poly2.poly_.size()) {
        answer.poly_ = this->poly_;
        smallPoly = poly2.poly_;
    } else {
        answer.poly_ = poly2.poly_;
        smallPoly = this->poly_;
    }

    for (int i = 0; i < smallPoly.size(); ++i) {
        answer.poly_[i] += smallPoly[i];
    }
    return answer;
}

Polynomial operator+(const int num, const Polynomial &poly2) {
    Polynomial answer;
    answer.poly_ = poly2.poly_;
    answer.poly_[0] += num;
    return answer;
}

Polynomial operator+(const Polynomial &poly2, const int num) {
    Polynomial answer;
    answer.poly_ = poly2.poly_;
    answer.poly_[0] += num;
    return answer;
}

Polynomial Polynomial::operator-(const Polynomial &poly2) const {
    Polynomial answer;
    std::vector<int> smallPoly;
    if (this->poly_.size() > poly2.poly_.size()) {
        answer.poly_ = this->poly_;
        smallPoly = poly2.poly_;
    } else {
        answer.poly_ = poly2.poly_;
        smallPoly = this->poly_;
    }

    for (int i = 0; i < smallPoly.size(); ++i) {
        answer.poly_[i] -= smallPoly[i];
    }
    return answer;
}

Polynomial operator-(const int num, const Polynomial &poly2) {
    Polynomial answer;
    answer.poly_ = poly2.poly_;
    answer.poly_[0] -= num;
    return answer;
}

Polynomial operator-(const Polynomial &poly2, const int num) {
    Polynomial answer;
    answer.poly_ = poly2.poly_;
    answer.poly_[0] -= num;
    return answer;
}

Polynomial Polynomial::operator*(const Polynomial &poly2) const {
    Polynomial answer;
    int sizeAnswerCoedArr = this->poly_.size() + poly2.poly_.size();
    answer.poly_.insert(answer.poly_.begin(), sizeAnswerCoedArr, 0);

    for (int i = 0; i < this->poly_.size(); ++i) {
        for (int j =0; j < poly2.poly_.size(); ++j) {
            answer.poly_[i+j] += this->poly_[i] * poly2.poly_[j];
        }
    }

    return answer;
}

Polynomial operator*(const int num, const Polynomial &poly2) {
    Polynomial answer;
    answer.poly_ = poly2.poly_;
    for (auto &x : answer.poly_) {
        x *= num;
    }
    return answer;
}

Polynomial operator*(const Polynomial &poly2, const int num) {
    Polynomial answer;
    answer.poly_ = poly2.poly_;

    for (auto &x : answer.poly_) {
        x *= num;
    }
    return answer;
}

int Polynomial::calculate(const int num) {
    int answer = 0;
    for (int i=0; i < this->poly_.size(); ++i) {
        answer += this->poly_[i] * pow(num, i);
    }
    return answer;
}
