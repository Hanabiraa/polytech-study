//
// Created by sushi on 07.02.2022.
//

#include "sorts.h"

// operator []
void insertsort_with_brackets(std::vector<int> &v) {
    int tmp;
    for (int i = 1, j; i != v.size(); ++i) {
        tmp = v[i];
        for (j = i - 1; j >= 0 && v[j] > tmp; --j) {
            v[j + 1] = v[j];
        }
        v[j + 1] = tmp;
    }
}

// operator at()
void insertsort_with_at(std::vector<int> &v) {
    int tmp;
    for (int i = 1, j; i != v.size(); ++i) {
        tmp = v.at(i);
        for (j = i - 1; j >= 0 && v.at(j) > tmp; --j) {
            v.at(j + 1) = v.at(j);
        }
        v.at(j + 1) = tmp;
    }
}

// итераторы
void insertsort_with_iterators(std::vector<int> &v) {
    int tmp;
    for (std::vector<int>::iterator i = v.begin() + 1, j; i != v.end(); ++i) {
        tmp = *i;
        for (j = i - 1; j >= v.begin() && *j > tmp; --j)
            *(j + 1) = *j;
        *(j + 1) = tmp;
    }
}

