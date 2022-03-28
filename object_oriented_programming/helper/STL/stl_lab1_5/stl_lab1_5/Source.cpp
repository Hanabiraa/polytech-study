//5)	Напишите программу, сохраняющую в векторе числа, полученные из стандартного ввода(окончанием ввода является число 0).
//Удалите все элементы, которые делятся на 2 (не используете стандартные алгоритмы STL), если последнее число 1.
//Если последнее число 2, добавьте после каждого числа которое делится на 3 три единицы.

#include <iostream>
#include <vector>

#include <algorithm>
#include <fstream>
#include <string>

template <typename T>
void printVector(std::vector<T> vec)
{
	for (int i = 0; i < vec.size(); i++)
	{
		std::cout << vec[i] << " ";
	}
	std::cout << '\n';
}

bool isEven(int i) { return ((i % 2) == 0); }


std::vector<int> enterArrayOptions()
{
	std::vector<int> vec;
	int last = 0;
	bool check = true;
	while (check)
	{
		std::cout << "Enter the element: " << '\n';
		std::cin >> last;
		if (last == 0) { 
			check = false;
		}
		else {
			vec.push_back(last); 
		}
		
	} 
	if (vec.back() == 1) {
		std::remove_if(vec.begin(), vec.end(), isEven);
	}
	if (vec.back() == 2) {
		for (int i = 0; i < vec.size(); i++) {
			if (vec.at(i) % 3 == 0) {
				vec.insert((vec.begin() + i + 1), 3, 1);
				i += 3;
			}
		}
	}
	return vec;
}

int main() {

	std::vector<int> taskFive = enterArrayOptions();
	std::cout << R"(Enter numbers. To stop press 0. Last number: 1 - all even numbers will be deleted; 
					2 - 111 will be added after every multiple by 3  )" << '\n';
	printVector(taskFive);
	std::cout << "****************************************" << '\n';
	 
}