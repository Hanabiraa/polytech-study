#include <iostream>
#include <string>

bool findDigit(int num, int subNum);
bool findNumStr(int num, int subNum);

int main() {
    std::cout << "есть цифра в числе: " << findDigit(12345, 5) << std::endl;
    std::cout << "нет цифры в числе: " << findDigit(12345, -1) << std::endl;
    std::cout << "нет цифры в числе: " << findDigit(12345, 6) << std::endl;
    std::cout << "есть цифра в числе (строка): " << findNumStr(12345, 2) << std::endl;
    std::cout << "нет цифры в числе (строка): " << findNumStr(12345, -1) << std::endl;
    return 0;
}

// simple
bool findDigit(int num, int subNum) {
    if (subNum > 9 || subNum < 0) {
        return false;
    }

    while (num != 0) {
        int remainder = num % 10;
        num /= 10;

        if (remainder == subNum) {
            return true;
        }
    }
    return false;
}

// string
bool findNumStr(int num, int subNum) {
    size_t pos = std::to_string(num).find(std::to_string(subNum));
    return (pos != std::string::npos);
}
