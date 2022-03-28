//1.	Разработать функтор, позволяющий собирать статистику о последовательности целых чисел(послед может содержать числа от - 500 до 500).
// Функтор после обработки последовательности алгоритмом for_each должен предоставлять следующую статистику :
//a.Максимальное число в последовательности
//b.Минимальное число в последовательности
//c.Среднее число в последовательности
//d.Количество положительных чисел
//e.Количество отрицательных чисел
//f.Сумму нечетных элементов последовательности
//g.Сумму четных элементов последовательности
//h.Совпадают ли первый и последний элементы последовательности.
//
//Проверить работу программы на случайно сгенерированных последовательностях.


#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <ctime>

using namespace std;

const int arrSize = 10;

class Sequence
{
	int max, min, avg;
	int count = 0, totalSum = 0, posNum = 0, negNum = 0, sumEven = 0, sumOdd = 0;
	bool firstEqualsLast = false;
	bool emptyFirst = true;
public:
	void operator()(const int elem)
	{
		if (emptyFirst)
		{
			int firtsElem = elem;
			min = elem;
			max = elem;
			avg = elem;
			emptyFirst = false;
		}

		if (elem > max) 
		{ 
			max = elem;  
		}
		if (elem < min) 
		{ 
			min = elem;  
		}
		++count;
		totalSum += elem;
		(elem > 0) ? ++posNum : ++negNum;
		(elem % 2 == 0) ? (sumEven += elem ) : (sumOdd = elem );
		if (elem == arrSize)
		{
			firstEqualsLast = true;
		}
	}
	void getSeriesStatistics()
	{
		if (!emptyFirst)
		{
			cout << "Max number in sequence = " << max << endl;
			cout << "Min number in sequence = " << min << endl;
			cout << "Average number in sequence: " << (double)totalSum / count << endl;
			cout << "Number of positives  = " << posNum << endl;
			cout << "Number of negatives = " << negNum << endl;
			cout << "Sum of odd numbers = " << sumOdd << endl;
			cout << "Sum of even numbers  = " << sumEven << endl;
			cout << "First and last elements are" << ((firstEqualsLast) ? "" : " not") << " equal";
		}
		else
		{
			cout << "Empty sequence!\n";
		}
	}

};


int main() {
	srand(time(0));

	int array[arrSize];

	for (int i = 0; i < arrSize; ++i)
	{
		array[i] = rand() % 1001 - 500;
	}

	Sequence series1 = for_each(array, &array[arrSize], Sequence());

	cout << "Test sequence:\n\n";

	for (int i = 0; i < arrSize; ++i)
	{
		if (i == 0)
			cout << "[ ";
		cout << array[i] << ((i != arrSize - 1) ? ", " : " ]\n\n");
	}

	cout << "\n-------------------------------------------------------------\n";
	series1.getSeriesStatistics();

	cout << "\n-------------------------------------------------------------\n\n";
	cout << endl;
	return 0;
}