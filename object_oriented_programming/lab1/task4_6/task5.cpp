//
// Created by sushi on 07.02.2022.
//

#include "task5.h"

void task5() {
    std::vector<int> v;
    while (1) {
        int n;
        std::cin >> n;
        if (!n) {
            break;
        }
        v.push_back(n);
    }

    std::cout << "raw vec: " << '\n';
    for (auto el : v) {
        std::cout << el << ' ';
    }

    switch (*(v.rbegin())) {
        case 1:
            for (auto it = v.begin(); it < v.end(); ++it) {
                if (*it % 2 == 0) {
                    it = v.erase(it);
                }
            }
            std::cout << "after vec: " << '\n';
            for (auto el : v) {
                std::cout << el << ' ';
            }
            break;
        case 2:
            for (auto it = v.begin(); it < v.end(); ++it) {
                if (*it % 3 == 0) {
                    it = v.insert(it+1, 3, 1);
                }
            }
            std::cout << "after vec: " << '\n';
            for (auto el : v) {
                std::cout << el << ' ';
            }
            break;
        default:
            break;
    }

}
