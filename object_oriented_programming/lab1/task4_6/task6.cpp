//
// Created by sushi on 07.02.2022.
//

#include "task6.h"

void task6() {
    std::vector<std::vector<double>> samples;
    std::vector<int> sizes{5, 10, 25, 50, 100};

    for (auto size: sizes) {
        std::vector<double> sample;
        fillRandom(sample, size);
        samples.push_back(sample);
    }

    std::cout << "unsorted vectors: \n";
    for (int i = 0; i < samples.size(); ++i) {
        std::cout << i << ": ";
        for (auto el: samples[i]) {
            std::cout << el << ' ';
        }
        std::cout << '\n';
    }

    // sort
    for (auto &sample : samples) {
        std::sort(sample.begin(), sample.end());
    }

    std::cout << "\n\n\nsorted vectors: \n";
    for (int i = 0; i < samples.size(); ++i) {
        std::cout << i << ": ";
        for (auto el: samples[i]) {
            std::cout << el << ' ';
        }
        std::cout << '\n';
    }
}

void fillRandom(std::vector<double> &v, int size) {
    std::random_device rd{};
    std::mt19937 gen{rd()};
    std::normal_distribution<> d{-1, 1};

    for (int i = 0; i < size; ++i) {
        v.push_back(d(gen));
    }
}