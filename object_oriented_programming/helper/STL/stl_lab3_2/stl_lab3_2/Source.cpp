//2.	������������ ���������, �������
//a.��������� list < int> 15 ���������� ���������� �� 1 �� 20, ������ ����� ��������� �� 0 �� 20 ��������(����������� ���������
//  �� ����� ������ 0, 1. 2, 3, 4, 5, 7, 14)
//b.������� ���������� ������ � ��������� ������� : ������ �������, 
//��������� �������, ������ �������, ������������� �������, ������ ������� � �.�.


#include <iostream>
#include <list>

//���������� ������ ����������
void fillList(std::list<int>& testList, int size)
{
	for (int i = 0; i < size; i++) {
		testList.push_back(rand() % 19 + 1);
	}
}


//����� �� ������
void printList(std::list<int>& testList)
{
	for (std::list<int>::iterator iter = testList.begin(); iter != testList.end(); iter++)
	{
		std::cout << *iter << " ";
	}
	std::cout << std::endl;
}

//�������� ������� - ������� ����� �� ������ ������, ����� � �����, ����� ����� �������
void printChangedOrder(std::list<int>& testList)
{
	if (!testList.empty())
	{
		//��� ��������� - ����� ���� � ������ ������ � � �����
		std::list<int>::iterator it1 = testList.begin();
		std::list<int>::iterator it2 = --testList.end();

		//������� ������ ������� ��� ������ � ������ ���-��� ��������� � ��������
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