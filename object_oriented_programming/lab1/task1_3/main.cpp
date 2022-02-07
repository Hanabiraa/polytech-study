#include "sorts.h"

void create_tests_vectors(std::vector<std::vector<int>> &tests);

void speed_tests(const std::vector<std::vector<int>> &tests);

int main() {
    // initialize
    std::vector<std::vector<int>> tests{};
    create_tests_vectors(tests);

//    print raw
//    std::cout << "Raw tests: \n";
//    for (auto test: tests) {
//        std::cout << "test size: " << test.size() << '\n';
//        for (auto el: test) {
//            std::cout << el << ' ';
//        }
//        std::cout << '\n';
//    }

    speed_tests(tests);
}

void create_tests_vectors(std::vector<std::vector<int>> &tests) {
    std::srand(1);
    int size = 1000;
    for (; size <= 3000; size += 1000) {
        std::vector<int> test;
        for (int j = 0; j < size; ++j) {
            test.push_back(std::rand() % 100 - 50);
        }
        tests.push_back(test);
    }
}

void speed_tests(const std::vector<std::vector<int>> &tests) {
    for (auto test: tests) {
        std::vector<std::time_t> time_diff;
        std::time_t start;
        std::time_t end;

        auto sample = test;
        start = std::clock();
        insertsort_with_brackets(sample);
        end = std::clock();
        time_diff.push_back(end-start);

        sample = test;
        start = std::clock();
        insertsort_with_at(sample);
        end = std::clock();
        time_diff.push_back(end-start);

        sample = test;
        start = std::clock();
        insertsort_with_iterators(sample);
        end = std::clock();
        time_diff.push_back(end-start);

        sample = test;
        start = std::clock();
        std::sort(sample.begin(), sample.end());
        end = std::clock();
        time_diff.push_back(end-start);

//        for (auto el : sample) {
//            std::cout << el << ' ';
//        }
//        std::cout << '\n';

        std::cout << "for size: " << sample.size() << '\n';
        std::cout << "operator [] time: " << time_diff[0] << " clocks" << '\n';
        std::cout << "at()        time: " << time_diff[1] << " clocks" << '\n';
        std::cout << "iterator    time: " << time_diff[2] << " clocks" << '\n';
        std::cout << "std::sort   time: " << time_diff[3] << " clocks" << '\n';
        std::cout << '\n';
    }
}
