//
// Created by Виталий Копылов on 10.04.2022.
//Написать программу, которая выполняет следующие действия:
// a) Читает содержимое текстового файла
// б) Выделяет слова, словом считаются последовательность символов разделенных пробелами и/или знаками табуляции и/или символами новой строки
// в) Вывести список слов присутствующий в тексте без повторений (имеется в виду, что одно и то же слово может присутствовать в списке только один раз)

#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <iterator>
#include <algorithm>

std::vector<std::string> readF(const std::string &);

void printS(const std::string &);

void stripS(std::string &str);

void task1() {
    std::string fileName = "/Users/akira/Documents/projects/polytech-study/object_oriented_programming/lab6/task1text.txt";
    std::vector<std::string> words = readF(fileName);
    std::for_each(words.begin(), words.end(), stripS);
    std::sort(words.begin(), words.end());
    words.erase(
            std::unique(words.begin(), words.end()),
            words.end()
            );
    std::for_each(words.begin(), words.end(), printS);
}

std::vector<std::string> readF(const std::string &fileName) {
    std::ifstream f(fileName);
    std::vector<std::string> words;

    if (f.is_open()) {
        std::string word;
        while (f >> word) {
            words.push_back(word);
        }
        f.close();
    }
    return words;
}

void printS(const std::string &word) {
    std::cout << word << ' ';
}

void stripS(std::string &str) {
    if (str.length() != 0) {
        auto w = std::string(" ");
        auto n = std::string("\n");
        auto r = std::string(".");
        auto t = std::string(",");
        auto v = std::string(1, str.front());
        while ((v == w) || (v == t) || (v == r) || (v == n)) {
            str.erase(str.begin());
            v = std::string(1, str.front());
        }
        v = std::string(1, str.back());
        while ((v == w) || (v == t) || (v == r) || (v == n)) {
            str.erase(str.end() - 1);
            v = std::string(1, str.back());
        }
    }
}