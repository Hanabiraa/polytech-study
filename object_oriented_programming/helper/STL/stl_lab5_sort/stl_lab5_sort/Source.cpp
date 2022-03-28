//Написать программа, которая выполняет следующие действия :
//a.Заполняет vector<DataStruct> структурами DataStruct, при этом key1 и key2, генерируются случайным образом в диапазоне от - 5 до 5, 
//str заполняется из таблицы(таблица содержит 10 произвольных строк, индекс строки генерируется случайным образом)
//b.Выводит полученный вектор на печать
//c.Сортирует вектор следующим образом :
//i.По возрастанию key1
//ii.Если key1 одинаковые, то по возрастанию key2
//iii.Если key1 и key2 одинаковые, то по возрастанию длинны строки str
//d.Выводит полученный вектор на печать


#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <iterator>
#include <algorithm>

using namespace std;

//описание структуры
struct DataStruct
{
	int key1;
	int key2;
	string str;
	DataStruct()
	{
		key1 = 0;
		key2 = 0;
		str = "";
	};
};
//задаем псевдонимы типов
typedef struct DataStruct DataStruct;
typedef vector<DataStruct> DataVector;


DataVector randomGenerator(const int n)
{
	DataStruct tmp;
	DataVector newVector;
	ifstream file("Text.txt");
	vector<string> myArray;
	//чтение из файла и добавление в вектор
	if (file.is_open())
	{
		string line;
		for (int i = 0; i < 10; ++i)
		{
			getline(file, line);
			myArray.push_back(line);
		}
		file.close();
	}
	//key1 и key2, генерируются случайным образом в диапазоне от - 5 до 5, 
	//str заполняется из таблицы(таблица содержит 10 произвольных строк, 
	//индекс строки генерируется случайным образом
	for (int i = 0; i < n; i++) {
		tmp.key1 = rand() % 11 - 6;
		tmp.key2 = rand() % 11 - 6;
		int r = rand() % 9;
		tmp.str = myArray.at(r);
		newVector.push_back(tmp);
	}
	return newVector;
}
//вывод на печать
void printDataVector(const DataVector newVector)
{
	for (const DataStruct& i : newVector) //для каждого элемента из вектора
	{
		cout << "key1 = " << i.key1 << "\tkey2 = " << i.key2 << "\tstr = " << i.str << endl;
	}
}

void sortVector(DataVector& toSort)
{
	sort(toSort.begin(), toSort.end(), [](DataStruct& ds1, DataStruct& ds2)
		{
			bool result;
			if (ds1.key1 != ds2.key1)
			{
				result = ds1.key1 < ds2.key1;
			}
			else if (ds1.key2 != ds2.key2)
			{
				result = ds1.key2 < ds2.key2;
			}
			else
			{
				result = ds1.str.length() < ds2.str.length();
			}
			return result;
		});
}


int main() {
	 
	DataVector newVector = randomGenerator(7);
	printDataVector(newVector);
	sortVector(newVector);
	cout << "Sorted vector: \n";
	printDataVector(newVector);

}


