//
// Created by Виталий Копылов on 10.04.2022.
//
#include <iostream>
#include <cmath>
#include <algorithm>
#include <vector>

using namespace std;


class ProdByPi {
public:
    void operator()( float &el) const {
        el *= PI;
    }

private:
    float PI = M_PI;
};

void task1() {
    vector<float> v1 = {1, 2, 3, 4, 5};
    ProdByPi prodByPi;
    for_each(v1.begin(), v1.end(), ProdByPi());
    for_each(v1.begin(), v1.end(), [](auto el){cout << el << ' ';});
}