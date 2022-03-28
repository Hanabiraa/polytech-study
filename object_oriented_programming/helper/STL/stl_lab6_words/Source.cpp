//1.	�������� ���������, ������� ��������� ��������� �������� :
//a.������ ���������� ���������� �����
//b.�������� �����, ������ ��������� ������������������ �������� ����������� ��������� 
// � / ��� ������� ��������� � / ��� ��������� ����� ������
//c.������� ������ ���� �������������� � ������ ��� ����������
//(������� � ����, ��� ���� � �� �� ����� ����� �������������� � ������ ������ ���� ���)



#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <iterator>
#include <algorithm>

using namespace std;

vector<string> readFileWords (const string fileName)
{
	ifstream file(fileName);
	vector<string> wordArray;
	if (file.is_open())
	{
	string word;
	while (file >> word)
	{
		wordArray.push_back(word);
	}
	file.close();
	}
	return wordArray;
}

void printElem(string val)
{
	cout << val << "; ";
}


int main() {
		
	vector<string> wordArray = readFileWords("Text.txt");
	sort(wordArray.begin(), wordArray.end());
	wordArray.erase(unique(wordArray.begin(), wordArray.end()), wordArray.end());
	for_each(wordArray.begin(), wordArray.end(), printElem);
}