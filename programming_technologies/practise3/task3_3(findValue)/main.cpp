#include <iostream>

int findValue(int [], int, int);

//СДЕЛАЙ БИНАРНЫМ ПОИСКОМ ЛОХ

const int ARR_SIZE = 25;
int main() {
    int arr[ARR_SIZE] = {-39, -29, -27, -24, -24, -23, -21, -20, -15, -15, -14, -10, -1, 9, 12, 12, 13, 17, 17, 18, 22, 32, 36, 40, 42};
    int smallArr[2] = {-1, 2};
    int oneArr[1] = {5};
    int dupArr[6] = {1,1,5,5,5,5};

//    std::cout << "index of nearest el: " << findValue(smallArr, 2, 1) << std::endl;
//    std::cout << "index of nearest el: " << findValue(oneArr, 1, 1) << std::endl;

    std::cout << "index of nearest el: " << findValue(arr, ARR_SIZE, -40) << std::endl;
//    std::cout << "index of nearest el: " << findValue(arr, ARR_SIZE, 40) << std::endl;
//
//    std::cout << "index of nearest el: " << findValue(dupArr, 6, 2) << std::endl;
    return 0;
}

int findValue(int * arr, int N, int value) {
    if (N == 1) {
        return 0;
    }

    if (*arr >= value) {
        return abs(*arr-value) < abs(*(--arr)-value) ? 0 : -1;
    }
    return 1 + findValue(++arr, N-1, value);
}