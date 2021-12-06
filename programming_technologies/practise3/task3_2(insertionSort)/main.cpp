#include <iostream>
#include <cstdlib>

const int N_SMALL_ARRAY = 5;
const int N_MEDIUM_ARRAY = 25;
const int N_BIG_ARRAY = 50;

void insertionSort(int[], int);
void printArray(int [], int, char[]);

int main() {
    // random value arrays
    int smallArray[N_SMALL_ARRAY];
    int mediumArray[N_MEDIUM_ARRAY];
    int bigArray[N_BIG_ARRAY];

    // bad arrays, useless test arrays
//    int PosOneElArray[1] = {2};
//    int NegOneElArray[1] = {-2};
//    int TwoElArray[2]    = {-2, -4};

    // initialize
    for (int &i: smallArray) i = std::rand() % 100 - 50;
    for (int &i: mediumArray) i = std::rand() % 100 - 50;
    for (int &i: bigArray) i = std::rand() % 100 - 50;

    // print arrays
    std::cout << "Three random arrays before sorting:\n";
    std::cout << "===================================\n";
    printArray(smallArray, N_SMALL_ARRAY, "Small array: ");
    printArray(mediumArray, N_MEDIUM_ARRAY, "Medium array: ");
    printArray(bigArray, N_BIG_ARRAY, "Big array: ");

    // sort
    insertionSort(smallArray, N_SMALL_ARRAY);
    insertionSort(mediumArray, N_MEDIUM_ARRAY);
    insertionSort(bigArray, N_BIG_ARRAY);

    // print arrays
    std::cout << "\n\nThree random arrays after sorting:\n";
    std::cout << "===================================\n";
    printArray(smallArray, N_SMALL_ARRAY, "Small array: ");
    printArray(mediumArray, N_MEDIUM_ARRAY, "Medium array: ");
    printArray(bigArray, N_BIG_ARRAY, "Big array: ");

    return 0;
}

// Time complex: O(N^2) - Average
void insertionSort(int arr[], int N) {
    for (int i = 0; i < N; ++i) {
        int val = arr[i];
        int j = i;
        while (j >= 1 && (arr[j-1] > val)) {
            arr[j] = arr[j-1];
            j--;
        }
        arr[j] = val;
    }
}

void printArray(int arr[], int N, char str[]="Size of array: ") {
    std::cout << str << N << '\n';

    for (int i = 0; i < N; ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << '\n';
}