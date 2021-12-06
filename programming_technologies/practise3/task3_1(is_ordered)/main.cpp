#include <iostream>
#include <cmath>

bool isOrdered(const int arr[], int size);

int main() {
    int arr1[5] = {1, 2, 3, 4, 5};
    int arr2[5] = {1, 2, -3, 4, 5};
    int arr3[1] = {-6};
    // bad
//    int arr4[0] = {};
    int * arr5 = new int [5];

    // 0-9
    for (int i = 0; i < 5; ++i) {
        arr5[i] = std::rand() % 10;
        std::cout << ' ' << arr5[i];
    }

    std::cout << "\nright order: " << isOrdered(arr1, 5) << '\n';
    std::cout << "bad order: " << isOrdered(arr2, 5) << '\n';
    std::cout << "right order, size 1: " << isOrdered(arr3, 1) << '\n';
    std::cout << "random order: " << isOrdered(arr5, 5) << '\n';
    return 0;
}

bool isOrdered(const int * arr, int size) {
    for (int i = 0; i < size - 1; ++i) {
        if (arr[i] > arr[i + 1]) {
            return false;
        }
    }
    return true;
}