//1.	???????? ????????? ? ??????????? ??????. 
//??????(??? ? ???????) ?????? ???????? ? ????? - ???? STL - ??????????(vector ??? list), ?????? ?????? ??????????, ????? ?? ???? ?????????? ?? ???????? ??????, 
// ????? ????? ?????? ? ????????? ? ?????????? ????? ??????????(????????: ??????????? typedef).
//
//????????? ?????? ???????????? ????????? ???????? :
//?	???????? ??????? ??????
//?	??????? ? ????????? ??????
//?	??????? ? ?????????? ??????
//?	??????? ?????? ????? / ????? ???????????????
//?	?????? ??????????????? ??????
//?	??????? ?????? ? ????? ???? ??????
//?	??????? ?????? / ????? ????? n ???????.
//
//???????, ??? ????? ??????? ???????? ????????? ?????????? ?????????????????, ??????? ????? ??????? ?????????????
//  ???????????? ???????? ?? ?????? ???? ??????.
//???????????? ??????????? ???????? ??????? ? ?????? ? ??????? ????? ? ??? ?? ???????, ??????? ? ??????????? 
// ?? ?????????? ???????? ?????????? ???? ??????? ????????, 
// ???? ??????? ? ???? ?? ?????????? ??????? : void modifyRecord(iterator pCurrentRecord, CRecord newRecord).
//????????? ????? ????? ????? ??????? ????(??? ?????? ????????????) ?????????  ???????? ?????? ????????? ??????????? ???????.

#include <iostream>
#include <list>
#include <string>
#include <vector>
#include <iterator>
#include <Windows.h>


using namespace std;

class Contact {
	string name;
	string phone;

public:
	Contact(): //??????????? ?? ?????????
		name("<unknown>"), 
		phone("<unknown>")
	{}
	Contact(const Contact& r): //??????????? ???????????
		name(r.getName()),
		phone(r.getPhone())
	{}
	Contact(const string& newName, const string& newPhone): //??????????? ? ???????????
	    name(newName),
		phone(newPhone)
	{}
	~Contact() {} //??????????

	Contact& operator=(const Contact& r) //???????? ?????????????
	{
		setName(r.getName());
		setPhone(r.getPhone());
		return *this;
	}
	//??????? ? ???????
	string getName() const
	{ return name; }
	void setName(const string& newName)
	{ name = newName; }
	string getPhone() const
	{ return phone; }
	void setPhone(const string& newPhone)
	{ phone = newPhone; }

	string toString() const
	{
		return "???: " + getName() + "; ???????: " + getPhone() + "\n";
	}
};

typedef list<Contact> phoneBook;

phoneBook pb;
phoneBook::iterator i;

//???????? ??????? ??????
void showRecord(phoneBook::iterator i) {
	Contact record = *i;
	cout << record.toString();
}
//	??????? ? ????????? ??????
string nextRecord(phoneBook::iterator i) {
	i++;
	return i->toString();
}
//	??????? ? ?????????? ??????
string prevRecord(phoneBook::iterator i) {
	i--;
	return i->toString();
}

string nextn() { // Skip N records and show the Nth
	int pos;
	cin >> pos; // Read N
	advance(i, pos);
	return i->toString();
}
string prevn() { // Skip N records backwards
	int pos;
	cin >> pos;
	advance(i, pos);
	return i->toString();
}
string reset() { // Reset the iterator to the beginning of the database
	i = pb.begin();
	return i->toString();
}
//	??????? ?????? ????? / ????? ??????????????? / ?????? ??????????????? ??????
template<class iterator>
void modifyRecord(iterator i, Contact record)
{
	*i = record;
}

//???? ????????
Contact readRecord()
{
	string name, phone;
	cout << "??????? ?????? ????????...\n";
	SetConsoleCP(1251);
	cin >> name >> phone;
	Contact recIn(name, phone);
	SetConsoleCP(866);
	return recIn;
}

int main() {
	setlocale(LC_ALL, "ru");
	int n, choice;
	Contact record;
	//????????? ?????
	Contact tmp("Alla", "99999999");
	pb.push_back(tmp);

	tmp.setName("Ivan");
	tmp.setPhone("909090909");
	pb.push_back(tmp);

	tmp.setName("Alex");
	tmp.setPhone("834568345");
	pb.push_back(tmp);

	tmp.setName("Claire");
	tmp.setPhone("420746590");
	pb.push_back(tmp);

	tmp.setName("StopWar");
	tmp.setPhone("24022022");
	pb.push_back(tmp);

	i = pb.begin();

	do {
		std::cout << '\n';
		std::cout << "1 - ???????? ??????? ??????\n";
		std::cout << "2 - ??????? ? ????????? ??????\n";
		std::cout << "3 - ??????? ? ?????????? ??????\n";
		std::cout << "4 - ??????? ?????? ????? ???????????????\n";
		std::cout << "5 - ??????? ?????? ????? ???????????????\n";
		std::cout << "6 - ?????? ??????????????? ??????\n";
		std::cout << "7 - ??????? ?????? ? ????? ???? ??????\n";
		std::cout << "8 - ??????? ?????? ????? n ???????\n";
		std::cout << "9 - ??????? ????? ????? n ???????\n";
		std::cout << "0 - Exit\n";
		std::cout << '\n';

		std::cin >> choice;

		switch (choice) {
		case 1:  //???????? ??????? ??????
			if (!pb.empty())
			{
				showRecord(i);
			}
			else
			{
				cerr << "???? ????\n";
			}
			break;
		case 2:  //??????? ? ????????? ??????
			if (!pb.empty() && i != --pb.end())
			{
				showRecord(++i);
			}
			else
			{
				cerr << "???? ???? ??? ??????????\n";
			}
			break;
		case 3: //??????? ? ?????????? ??????
			if (!pb.empty() && i != pb.begin())
			{
				showRecord(--i);
			}
			else
			{
				cerr << "???? ???? ??? ??? ?????? ?????? ???????\n";
			}
			break;
		case 4:  //??????? ?????? ????? ???????????????
			record = readRecord();
			modifyRecord(inserter<phoneBook>(pb, i), record);
			cout << "??????? ????????:\n" + record.toString();
			i = pb.begin();
			break;
		case 5: //??????? ?????? ????? ??????????????? 
			record = readRecord();
			modifyRecord(inserter<phoneBook>(pb, ++i), record);
			cout << "??????? ????????:\n" + record.toString();
			i = pb.begin();
			break;
		case 6: //?????? ??????????????? ??????
			record = readRecord();
			modifyRecord(i, record);
			cout << "??????? ??????? ??:\n" + record.toString();
			i = pb.begin();
			break;
		case 7: //??????? ?????? ? ????? ???? ?????? 
			record = readRecord();
			modifyRecord(back_inserter<phoneBook>(pb), record);
			cout << "??????? ??????? ??:\n" + record.toString();
			i = pb.begin();
			break;
		case 8: //??????? ?????? ????? n ??????? 
			cout << "?? ??????? ????? ??????: ";
			int n;
			cin >> n;
			if (n < distance(i, pb.end())) {
				advance(i, n);
				showRecord(i);
			}
			else
			{
				cout << "????? ?? ??????? ??????????? \n ";
			}
			break;
		case 9: //??????? ????? ????? n ???????
			cout << "?? ??????? ????? ?????: ";
			cin >> n;
			if (n - 1 < distance(pb.begin(), i)) {
				advance(i, -n);
				showRecord(i);
			}
			else
			{
				cout << "????? ?? ??????? ??????????? \n ";
			}
			break;
		}
	} while (choice);

	return 0;
}