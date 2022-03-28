//6)	Напишите функцию void fillRandom(double* array, int size) заполняющую массив случайными значениями в интервале от - 1.0 до 1.0.
//Заполните с помощью заданной функции вектора размером 5, 10, 25, 50, 100 и отсортируйте его содержимое
//(с помощью любого разработанного ранее алгоритма модифицированного для сортировки действительных чисел)

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

void sortWithAt(std::vector<double>& vec)
{
	int size = vec.size();
	for (int i = 0; i < size - 1; i++)
	{
		for (int j = 0; j < size - i - 1; j++)
		{
			if (vec.at(j) > vec.at(j + 1))
			{
				std::swap(vec.at(j), vec.at(j + 1));
			}
		}
	}
}

void fillRandom(double* array, int size) {
	for (int i = 0; i < size; i++)
	{
		array[i] = (rand() % 200 - 100) * 0.01;
	}
}

std::vector<double> createAndSort(int size)
{
	double* arr = new double[size];
	fillRandom(arr, size);
	std::vector<double> vec(arr, arr + size);
	sortWithAt(vec);
	return vec;
}


int main() {

	std::vector<double> taskSix1 = createAndSort(5);
	std::vector<double> taskSix2 = createAndSort(10);
	std::vector<double> taskSix3 = createAndSort(25);
	std::vector<double> taskSix4 = createAndSort(50);
	std::vector<double> taskSix5 = createAndSort(100);
	std::cout << "Array of 5 elements: " << '\n';
	printVector(taskSix1);
	std::cout << "****************************************" << '\n';
	std::cout << "Array of 10 elements: " << '\n';
	printVector(taskSix2);
	std::cout << "****************************************" << '\n';
	std::cout << "Array of 25 elements: " << '\n';
	printVector(taskSix3);
	std::cout << "****************************************" << '\n';
	std::cout << "Array of 50 elements: " << '\n';
	printVector(taskSix4);
	std::cout << "****************************************" << '\n';
	std::cout << "Array of 100 elements: " << '\n';
	printVector(taskSix5);
	std::cout << "****************************************" << '\n';



}