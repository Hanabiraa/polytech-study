#include <iostream>
#include <fstream>
#include <string>
#include <vector>

//функция чтения из файла
std::string readFile(const std::string path)
{
	std::ifstream file(path);
	if (!file.is_open()) {
		std::cerr << "Невозможно открыть файл!\n";
		exit(EXIT_FAILURE);
	}
	return std::string((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
}

bool isPunctuationMark(char& ch)
{
	if (ch == ',' || ch == '.' || ch == '!' || ch == '?' || ch == ':' || ch == ';') {
		return true;
	}
	return false;

}

bool isSpaceSymbol(char& ch)
{
	if (ch == '\n' || ch == '\t' || ch == '\r') {
		return true;
	}
	return false;
}

//2.	Отформатировать текст следующим образом :
//a.Не должно быть  пробельных символов отличных от пробела
//b.Не должно идти подряд более одного пробела
//c.Между словом и знаком препинания не должно быть пробела
//d.После знака препинания всегда должен идти пробел
//e.Слова длиной более 10 символов заменяются на слово «Vau!!!»
void adjustSpacesAndMarks(std::string& str)
{
	for (int i = 0; i < str.length(); i++) {
		//a.Не должно быть  пробельных символов отличных от пробела
		if (isSpaceSymbol(str.at(i)))
		{
			str.erase(str.begin() + i);
			str.insert(str.begin() + i, ' ');
		}
		//b.Не должно идти подряд более одного пробела
        //c.Между словом и знаком препинания не должно быть пробела
		if (i < str.length() - 1) {
			if (str.at(i) == ' ' && (isPunctuationMark(str.at(i + 1)) || isSpaceSymbol(str.at(i + 1)) || str.at(i + 1) == ' ')) {
				str.erase(str.begin() + i);
				if (i > 0)
				{
					i--;
				}
				continue;
			}
		//d.После знака препинания всегда должен идти пробел
			if (isPunctuationMark(str.at(i)) && str.at(i + 1) != ' ') {
				str.insert(str.begin() + i + 1, ' ');
			}
		}
	}
	//e.Слова длиной более 10 символов заменяются на слово «Vau!!!»
	std::string strTmp;
	std::string tmp;
	for (char i : str)
	{
		if (i != ' ' && !isPunctuationMark(i))
		{
			tmp += i;
		}
		else
		{
			if (tmp.size() <= 10)
			{
				strTmp += tmp;
			}
			else
			{
				tmp = "Vau!!!";
				strTmp += tmp;
			}
			strTmp += i;
			tmp.clear();
		}
	}	
	str = strTmp+tmp;
}


//3.	Преобразовать полученный текст в набор строка, каждая из которых содержит целое количество строк
//(слово должно целиком находиться в строке) и ее длинна не превышает 40 символов.
std::vector<std::string> adjustLineLength(std::string& str)
{
	std::vector<std::string> vecStr;
	std::string tmp;

	const int MAX_STR = 40;
	int counter = 0;
	//читаем по символу и записываем отдельные слова в tmp 
	for (char i : str) {
		if (i != ' ' && !isPunctuationMark(i)) {
			tmp += i;
		}
		//после окончания слова проверяем длинну строки, если с добавлением слова она не превысит 40 символов - добавляем в последний эл-т
		else
		{
			tmp += i;
			if (tmp.size() + counter <= MAX_STR)
			{
				if (vecStr.empty()) {
					vecStr.push_back(tmp);
				}
				vecStr.back() = vecStr.back() + tmp;
				counter += tmp.size();
			}
			else
			{
				vecStr.push_back(tmp);
				counter = tmp.size();
			}
			tmp.clear();
		}
	}
	return vecStr;
}


int main() {

	std::string input_file;
	input_file = "Text.txt";

	std::string theText;
	theText = readFile(input_file);
	std::cout << "Original text\n" << theText << '\n';

	adjustSpacesAndMarks(theText);
	std::cout << "New text\n" << theText << '\n';
	std::vector<std::string> finalText = adjustLineLength(theText);
	std::cout << "\nFinal text\n";

	for (std::string i : finalText)
	{
		std::cout << i << '\n';
	}
	return 0;
}