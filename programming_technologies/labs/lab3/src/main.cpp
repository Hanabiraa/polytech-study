#include <iostream>
#include <fstream>
#include <string>
#include <cctype>

char *foo(char *destination, const char *source);

std::string bar(const std::string &source);

void printString(const char *source);

void printString(const std::string &source);

const int BUFFER_SIZE = 16;

int main() {
    std::ifstream in("./../data/input.txt");
    while (!in.eof()) {
        char *buffer = new char[BUFFER_SIZE];
        in.getline(buffer, BUFFER_SIZE);
        int size = std::atoi(buffer);
        delete[] buffer;

//        int size;
//        in >> size;
//        in.get();

        char *strCharRaw = new char[size + 1];
        char *strCharConvert = new char[size + 1];
        in.getline(strCharRaw, size + 1);
        foo(strCharConvert, strCharRaw);
        printString(strCharConvert);

        std::string strStringRaw = std::string(strCharRaw);
        printString(bar(strStringRaw));

        delete[] strCharRaw;
        delete[] strCharConvert;
    }
    in.close();


    return 0;
}

char *foo(char *destination, const char *source) {
    while (*source) {
        *destination = (std::isupper(*source)) ? std::tolower(*source) : *source;
        ++destination;
        ++source;
    }
    *destination = '\0';
    return destination;
}

std::string bar(const std::string &source) {
    std::string destination;
    for (char ch: source) {
        destination.push_back((std::isupper(ch)) ? std::tolower(ch) : ch);
    }
    return destination;
}

void printString(const char *source) {
    std::cout << "  char: ";
    while (*source) {
        std::cout << *source;
        source++;
    }
    std::cout << '\n';
}

void printString(const std::string &source) {
    std::cout << "string: " << source << "\n\n";
}

