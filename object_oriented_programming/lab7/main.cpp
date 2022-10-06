#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <ctime>

using namespace std;

class Sequence {
    int max, min, avg, firstElem;
    int count = 0, totalSum = 0, posNum = 0, negNum = 0, sumEven = 0, sumOdd = 0;
    bool firstEqualsLast = false;
    bool emptyFirst = true;
public:
    void operator()(const int elem) {
        if (emptyFirst) {
            int firstElem = elem;
            min = elem;
            max = elem;
            avg = elem;
            emptyFirst = false;
        }

        if (elem > max) {
            max = elem;
        }
        if (elem < min) {
            min = elem;
        }
        ++count;
        totalSum += elem;
        (elem > 0) ? ++posNum : ++negNum;
        (elem % 2 == 0) ? (sumEven += elem) : (sumOdd = elem);
        if (elem == 100) {
            firstEqualsLast = (firstElem == elem);
        }
    }

    void getSeriesStatistics() {
        if (!emptyFirst) {
            cout << "Max number in sequence = " << max << endl;
            cout << "Min number in sequence = " << min << endl;
            cout << "Average number in sequence: " << (double) totalSum / count << endl;
            cout << "Number of positives  = " << posNum << endl;
            cout << "Number of negatives = " << negNum << endl;
            cout << "Sum of odd numbers = " << sumOdd << endl;
            cout << "Sum of even numbers  = " << sumEven << endl;
            cout << "First and last elements are" << ((firstEqualsLast) ? "" : " not") << " equal";
        } else {
            cout << "Empty sequence!\n";
        }
    }

};


int main() {
    srand(time(0));
    vector<int> arr(100);

    generate(arr.begin(), arr.end(), [](){
        return rand() % 1001 - 500;
    });


    Sequence series1 = for_each(arr.begin(), arr.end(), Sequence());

    cout << "Test sequence:\n[ ";

    for_each(arr.begin(), arr.end(), [](const int el) { cout << el << ", "; });
    cout << " ]\n\n";

    series1.getSeriesStatistics();
    cout << endl;
    return 0;
}