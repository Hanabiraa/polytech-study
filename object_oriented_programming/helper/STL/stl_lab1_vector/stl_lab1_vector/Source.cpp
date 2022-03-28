#include <iostream>
#include <vector>
#include <chrono>
#include <algorithm>
#include <fstream>
#include <string>

//add date, author, task
//add comments here

std::vector<int> sortWithBrackets(std::vector<int> vec)
{
	auto start = std::chrono::high_resolution_clock::now();
	int size = vec.size();
	for (int i = 0; i < size - 1; i++)
	{
		for (int j = 0; j < size - i - 1; j++)
		{
			if (vec[j] > vec[j + 1])
			{
				std::swap(vec[j], vec[j+1]);
			}
		}
	}
	auto end = std::chrono::high_resolution_clock::now();
	std::chrono::duration<float> duration = end - start;
	std::cout << "Execution time - using []: " << duration.count() << " seconds\n";
	return vec;
}

std::vector<int> sortWithAt(std::vector<int> vec)
{
	auto start = std::chrono::high_resolution_clock::now();
	int size = vec.size();
	for (int i = 0; i < size - 1; i++)
	{
		for (int j = 0; j < size - i - 1; j++)
		{
			if (vec.at(j) > vec.at(j+1))
			{
				std::swap(vec.at(j), vec.at(j + 1));
			}
		}
	}
	auto end = std::chrono::high_resolution_clock::now();
	std::chrono::duration<float> duration = end - start;
	std::cout << "Execution time - using at(): " << duration.count() << " seconds\n";
	return vec;
}

std::vector<int> sortWithIterators(std::vector<int> vec)
{
	auto start = std::chrono::high_resolution_clock::now();

	for (std::vector<int>::iterator i = vec.begin(); i != vec.end(); ++i) {
		for (std::vector<int>::iterator j = vec.begin(); j < i; ++j)
			if (*i < *j)
				std::iter_swap(i, j);
	}

	auto end = std::chrono::high_resolution_clock::now();
	std::chrono::duration<float> duration = end - start;
	std::cout << "Execution time - using iterators: " << duration.count() << " seconds\n";
	return vec;
}

std::vector <int> readInVector(std::string path)
{
	std::ifstream fin;
	fin.open(path);

	if (!fin.is_open())
	{
		std::cerr << "File can't be opened:" << '\n';
	}

	int const size = 10;
	int array[size];

	while (fin)
	{
		for (int i = 0; i < size; i++)
		{
			fin >> array[i];
		}
	}
	fin.close();
	std::vector<int> vec(array, array + size);
	return vec;
}


template <typename T>
void printVector(std::vector<T> vec)
{
	for (int i = 0; i < vec.size(); i++)
	{
		std::cout << vec[i] << " ";
	}
	std::cout << '\n';
}

int main() {

	std::vector<int> vOriginal;
	for (int i = 0; i < 1000; i++)
	{
		vOriginal.push_back(std::rand());
	}

	std::cout << "Elements before sorting" << std::endl;
	//printVector(vOriginal);
	std::cout << "****************************************" << '\n';

	std::cout << "Elements after sorting with []" << std::endl;
	std::vector<int> v1 = sortWithBrackets(vOriginal);
	//printVector(v1); 
	std::cout << "****************************************" << '\n';

	std::cout << "Elements after sorting with at()" << std::endl;
	std::vector<int> v2 = sortWithAt(vOriginal);
	//printVector(v2); 
	std::cout << "****************************************" << '\n';

	std::cout << "Elements after sorting with Iterators" << std::endl;
	std::vector<int> v3 = sortWithIterators(vOriginal);
	//printVector(v3);
	std::cout << "****************************************" << '\n';

	std::cout << "Elements after sorting with 'sort' function" << std::endl;
	auto start = std::chrono::high_resolution_clock::now();
	std::sort(vOriginal.begin(), vOriginal.end());
	auto end = std::chrono::high_resolution_clock::now();
	std::chrono::duration<float> duration = end - start;
	std::cout << "Execution time - using sort: " << duration.count() << " seconds\n";
	//printVector(vOriginal);
	std::cout << "****************************************" << '\n';

	std::string path = "text.txt";
	std::vector<int> v5 = readInVector(path);


}