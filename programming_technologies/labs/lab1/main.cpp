#include <iostream>

/*
 * Вариант 11.
 * В массиве целых чисел найдите сумму индексов минимального и максимального элементов
 */
const int ARRAY_SIZE = 10;

int sumMaxMinPos(const int[], int);

int main() {
    int arr1[1] = {4};
    int arr2[2] = {-2, -2};
    int arr3[7] = {-5, 2, 1, 8, 9, 4, -100};
    int arr4[8] = {-5, 2, 1, 8, 9, 4, -100, 50};

    // for keyboard input
//    int size;
//    std::cin >> size;
//    int arrDyn[size];
    int arrDyn[ARRAY_SIZE];
    for (auto &i: arrDyn) { i = std::rand() % 100 - 50; }

    std::cout << "array:\n";
    for (auto &i: arr1) { std::cout << i << ' '; }
    std::cout << "\nfunc result: " << sumMaxMinPos(arr1, 1) << "\n\n";

    std::cout << "array:\n";
    for (auto &i: arr2) { std::cout << i << ' '; }
    std::cout << "\nfunc result: " << sumMaxMinPos(arr2, 2) << "\n\n";

    std::cout << "array:\n";
    for (auto &i: arr3) { std::cout << i << ' '; }
    std::cout << "\nfunc result: " << sumMaxMinPos(arr3, 7) << "\n\n";

    std::cout << "array:\n";
    for (auto &i: arr4) { std::cout << i << ' '; }
    std::cout << "\nfunc result: " << sumMaxMinPos(arr4, 8) << "\n\n";

    std::cout << "array:\n";
    for (auto &i: arrDyn) { std::cout << i << ' '; }
    std::cout << "\nfunc result: " << sumMaxMinPos(arrDyn, ARRAY_SIZE) << "\n\n";

    return 0;
}


// Time complexity: O(N)
// Space complexity: O(1)
int sumMaxMinPos(const int *arr, int size) {
    int globalMaxPos = 0;
    int globalMinPos = 0;

    for (int i = 1; i < size; i += 2) {
        int localMaxPos;
        int localMinPos;

        if (arr[i] > arr[i - 1]) {
            localMaxPos = i;
            localMinPos = i - 1;
        } else {
            localMaxPos = i - 1;
            localMinPos = i;
        }

        if (arr[localMaxPos] > arr[globalMaxPos]) { globalMaxPos = localMaxPos; }
        if (arr[localMinPos] < arr[globalMinPos]) { globalMinPos = localMinPos; }
    }

    if (size % 2) {
        if (arr[size - 1] > arr[globalMaxPos]) { globalMaxPos = size - 1; }
        if (arr[size - 1] < arr[globalMinPos]) { globalMinPos = size - 1; }
    }

    return (globalMaxPos + globalMinPos);
}
