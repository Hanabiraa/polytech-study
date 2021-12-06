#include <iostream>
#include <cstdlib>

void quickSort(int[], int, int low = 0);

void printArray(int [], int, char[]);

const int N_SMALL_ARRAY = 5;
const int N_MEDIUM_ARRAY = 25;
const int N_BIG_ARRAY = 50;

int main() {
    // random value arrays
    int smallArray[N_SMALL_ARRAY];
    int mediumArray[N_MEDIUM_ARRAY];
    int bigArray[N_BIG_ARRAY];

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
    quickSort(smallArray, N_SMALL_ARRAY);
    quickSort(mediumArray, N_MEDIUM_ARRAY);
    quickSort(bigArray, N_BIG_ARRAY);


    // print arrays
    std::cout << "\n\nThree random arrays after sorting:\n";
    std::cout << "===================================\n";
    printArray(smallArray, N_SMALL_ARRAY, "Small array: ");
    printArray(mediumArray, N_MEDIUM_ARRAY, "Medium array: ");
    printArray(bigArray, N_BIG_ARRAY, "Big array: ");

    return 0;
}

// Time complex: O(NlogN) - Average
void quickSort(int *arr, int high, int low) {
    int i = low;
    int j = high-1;
    int pivot = (arr[i] + arr[j]) / 2;

    while (i <= j) {
        while (arr[i] < pivot) ++i;
        while (arr[j] > pivot) --j;

        if (i <= j) {
            int tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
            i++;
            j--;
        }
    }
    if (j > low) quickSort(arr, high = j, low = low);
    if (i < high) quickSort(arr, high = high, low = i);
}

void printArray(int arr[], int N, char str[] = "Size of array: ") {
    std::cout << str << N << '\n';

    for (int i = 0; i < N; ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << '\n';
}