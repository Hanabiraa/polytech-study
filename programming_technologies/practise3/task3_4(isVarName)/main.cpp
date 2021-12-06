#include <iostream>
#include <cctype>

bool isVarName(const char * str);

int main() {
    char str1[] = "Var1";
    char str2[] = "var1";
    char str3[] = "_var1";
    char str3_1[] = "a___";
    char str4[] = "1ard";
    char str5[] = "*ard";
    char str6[] = "a1.rd";
    char str7[] = "a1,rd";
    char str8[] = "\n1,rd";
    char str9[] = " \n1,rd";
    char str10[] = "asdr*d";

    std::cout << "good expr: " << isVarName(str1) << '\n';
    std::cout << "good expr: " << isVarName(str2) << '\n';
    std::cout << "good expr: " << isVarName(str3) << '\n';
    std::cout << "good expr: " << isVarName(str3_1) << '\n';
    std::cout << "bad expr: " << isVarName(str4) << '\n';
    std::cout << "bad expr: " << isVarName(str5) << '\n';
    std::cout << "bad expr: " << isVarName(str6) << '\n';
    std::cout << "bad expr: " << isVarName(str7) << '\n';
    std::cout << "bad expr: " << isVarName(str8) << '\n';
    std::cout << "bad expr: " << isVarName(str9) << '\n';
    std::cout << "bad expr: " << isVarName(str10) << '\n';

    return 0;
}


bool isVarName(const char * str) {
    if (iscntrl(str[0]) || isdigit(str[0]) || ispunct(str[0]) && str[0] != '_' || isspace(str[0])) {
        return false;
    }
    for (int i = 1; str[i] != '\0'; ++i) {
        if (!(isalnum(str[i]) || str[i] == '_')) {
            return false;
        }
    }
    return true;
}