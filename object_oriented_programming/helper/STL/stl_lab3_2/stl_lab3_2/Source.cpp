//2.	–азработайте программу, котора€
//a.«аполн€ет list < int> 15 случайными значени€ми от 1 до 20, список может содержать от 0 до 20 значений(об€зательно проверить
//  на длине списка 0, 1. 2, 3, 4, 5, 7, 14)
//b.¬ыводит содержимое списка в следующем пор€дке : первый элемент, 
//последний элемент, второй элемент, предпоследний элемент, тритий элемент и т.д.


#include <iostream>
#include <list>

//заполнение списка значени€ми
void fillList(std::list<int>& testList, int size)
{
	for (int i = 0; i < size; i++) {
		testList.push_back(rand() % 19 + 1);
	}
}


//вывод на печать
void printList(std::list<int>& testList)
{
	for (std::list<int>::iterator iter = testList.begin(); iter != testList.end(); iter++)
	{
		std::cout << *iter << " ";
	}
	std::cout << std::endl;
}

//помен€ть пор€док - вначале берем из начала списка, потом с конца, потом оп€ть сначала
void printChangedOrder(std::list<int>& testList)
{
	if (!testList.empty())
	{
		//два итератора - чтобы идти с начала списка и с конца
		std::list<int>::iterator it1 = testList.begin();
		std::list<int>::iterator it2 = --testList.end();

		//немного разные подходы дл€ списка с четным кол-вом элементов и нечетным
		if (testList.size() % 2 == 0) 
		{
			for (int i = 0; i < testList.size() / 2; i++, it1++, it2--)
			{
				std::cout << *it1 << " ";
				std::cout << *it2 << " ";
			}
		}
		else
		{
			for (int i = 0; i < testList.size() / 2 + 1; i++, it1++, it2--)
			{
				std::cout << *it1 << " ";
				if (it1 == it2) break;
				std::cout << *it2 << " ";
			}
		}
		std::cout << std::endl;
	}
}

int main() {
	int array[8] = { 0, 1, 2, 3, 4, 5, 7, 14 };
	for (int i : array)
	{
		std::list<int> newList;
		int len = i;

		fillList(newList, len);
		std::cout << "List of " << i << " elements: ";
		printList(newList);
		std::cout << "********************************* \n\n";
		std::cout <<  " Reordered list: ";
		printChangedOrder(newList);
		std::cout << "********************************* \n\n";


	}

}