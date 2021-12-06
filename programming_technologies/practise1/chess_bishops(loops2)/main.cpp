#include <iostream>

const int MAX_SIZE{8};
const int MIN_SIZE{1};

//  Bishop's moves
int main() {
    int x, y;
    std::cout << "Enter the coordinates of the bishop" << std::endl;
    std::cin >> x >> y;

//    main diagonal
    std::cout << "Main diagonal (down var y)" << std::endl;
    int initial_y{y - 1};
    int initial_x{x + 1};
    while (initial_y >= MIN_SIZE && initial_x <= MAX_SIZE) {
        std::cout << "{" << initial_x << "," << initial_y << "}" << std::endl;
        ++initial_x;
        --initial_y;
    }

    std::cout << "Main diagonal (up var y)" << std::endl;
    initial_y = y;
    initial_x = x;
    while (initial_y <= MAX_SIZE && initial_x >= MIN_SIZE) {
        if (initial_y != y && initial_x != x) {
            std::cout << "{" << initial_x-- << "," << initial_y++ << "}" << std::endl;
        } else {
            --initial_x;
            ++initial_y;
        }
    }

//  side diagonal
    std::cout << "Side diagonal (down var y)" << std::endl;
    initial_y = y;
    initial_x = x;
    while (initial_y >= MIN_SIZE && initial_x >= MIN_SIZE) {
        if (initial_y != y && initial_x != x) {
            std::cout << "{" << initial_x-- << "," << initial_y-- << "}" << std::endl;
        } else {
            --initial_x;
            --initial_y;
        }
    }

    std::cout << "Main diagonal (up var y)" << std::endl;
    initial_y = y;
    initial_x = x;
    while (initial_y <= MAX_SIZE && initial_x <= MAX_SIZE) {
        if (initial_y != y && initial_x != x) {
            std::cout << "{" << initial_x++ << "," << initial_y++ << "}" << std::endl;
        } else {
            ++initial_x;
            ++initial_y;
        }
    }

    return 0;
}
