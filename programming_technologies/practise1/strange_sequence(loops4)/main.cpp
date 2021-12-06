#include <iostream>

int STOP_SIGNAL{0};

int main() {
    int negative_sum{0};
    int positive_sum{0};
    int counter{0};
    int positive_counter{0};

    int max_var{0};
    int max_pos{0};
    int min_var{0};
    int min_pos{0};

    int next;
    std::cout << "enter num: ";
    std::cin >> next;
    ++counter;

    while (next != STOP_SIGNAL) {
        next > 0 ? positive_sum+=next, ++positive_counter : negative_sum+=next;

        if (next > max_var) {
            max_var = next;
            max_pos = counter;
        } else if (next < min_var) {
            min_var=next;
            min_pos=counter;
        }

        ++counter;

        std::cout << "enter num: ";
        std::cin >> next;
    }
    --counter;

    std::cout << "STOP SIGNAL was inputted" << std::endl;

    std::cout << "sum of all elements: "        << positive_sum+negative_sum << std::endl;
    std::cout << "mean of all elements: "       << static_cast<float>(positive_sum+negative_sum) / static_cast<float>(counter) << std::endl;
    std::cout << "mean of positive elements: "  << static_cast<float>(positive_sum) / static_cast<float>(positive_counter) << std::endl;

    std::cout << "max var: "        << max_var << std::endl;
    std::cout << "max var pos: "    << max_pos << std::endl;
    std::cout << "min var: "        << min_var << std::endl;
    std::cout << "min var pos: "    << min_pos << std::endl;




    return 0;
}
