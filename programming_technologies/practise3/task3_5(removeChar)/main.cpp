#include <iostream>

void removeChar(const char *, char *, char);

const int MAX_N_STRING = 20;

int main() {
    const char *str1 = "hello";
    const char *str2 = "h";
    const char *str3 = "hh";
    const char *str4 = "world";
    const char *str5 = "";

    char *modStr1 = new char[MAX_N_STRING];
    char modStr2[MAX_N_STRING];
    char modStr3[MAX_N_STRING];
    char modStr4[MAX_N_STRING];
    char modStr5[MAX_N_STRING];

    removeChar(str1, modStr1, 'l');
    removeChar(str2, modStr2, 'h');
    removeChar(str3, modStr3, 't');
    removeChar(str4, modStr4, '!');
    removeChar(str5, modStr5, '!');

    std::cout << "str: hello, symbol: l => " << modStr1 << '\n';
    std::cout << "str: h,     symbol: h => " << modStr2 << '\n';
    std::cout << "str: hh,    symbol: t => " << modStr3 << '\n';
    std::cout << "str: world, symbol: ! => " << modStr4 << '\n';
    std::cout << "str: empty, symbol: ! => " << modStr5 << '\n';

    delete [] modStr1;
    return 0;
}

void removeChar(const char *str, char *modStr, char symbol) {
    while (*str) {
        if (*str != symbol) {
            *modStr = *str;
            ++modStr;
        }
        ++str;
    }
    *modStr = '\0';
}
