#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <iterator>
#include <algorithm>
#include <cstdlib>

typedef struct {
    int key1;
    int key2;
    std::string str;
} DataStruct;

void print(std::vector<DataStruct> &v) {
    for (auto el: v) {
        std::cout << "struct: " << "n1:" << el.key1 << "\tn2:" << el.key2 << "\tword: " << el.str << '\n';
    }
}

int main() {
    std::srand(0);
    std::vector<DataStruct> v;
    for (int i = 0; i < 10; ++i) {
        auto ex = DataStruct();
        ex.key1 = rand() % 10 - 5;
        ex.key2 = rand() % 10 - 5;
        ex.str = "word" + std::to_string(i);
        v.push_back(ex);
    }
    std::cout << "unsorted\n";
    print(v);
    std::sort(v.begin(), v.end(), [](DataStruct &el1, DataStruct &el2){
        if (el1.key1 != el2.key1)
        {
            return el1.key1 < el2.key1;
        }
        else if (el1.key2 != el2.key2)
        {
            return el1.key2 < el2.key2;
        }
        else
        {
            return el1.str.length() < el2.str.length();
        }
    });
    std::cout << "\n\nsorted:\n";
    print(v);
    return 0;
}
