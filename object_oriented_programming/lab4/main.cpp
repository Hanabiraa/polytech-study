#include <vector>
#include <list>
#include <string>
#include <iterator>
#include <iostream>
#include <algorithm>

using namespace std;


class Person {
    string name;
    string phone;
public:
    Person() :
            name("<unknown>"),
            phone("<unknown>") {}

    Person(const Person &r) :
            name(r.getName()),
            phone(r.getPhone()) {}

    Person(const string &newName, const string &newPhone) :
            name(newName),
            phone(newPhone) {}

    ~Person() {}

    Person &operator=(const Person &r) {
        setName(r.getName());
        setPhone(r.getPhone());
        return *this;
    }

    string getName() const { return name; }

    void setName(const string &newName) { name = newName; }

    string getPhone() const { return phone; }

    void setPhone(const string &newPhone) { phone = newPhone; }

    string toString() const {
        return getName() + ": " + getPhone() + "\n";
    }
};

typedef list<Person> PhBook;

PhBook db;
PhBook::iterator i = db.begin();


// Command handlers:
string help() { // Show help
    return
            "----------------STL iterators sample: phonebook-------------\n"
            "Command list:\n"
            "help - show this screen\n"
            "reset - reset iterator to first record\n"
            "curr - show current record\n"
            "next - moven to next record\n"
            "prev - moven to previous record\n"
            "nextn <n> - skip several records\n"
            "prevn <n> - skip several records backwards\n"
            "before <name> <phone> - insert a record before the current\n"
            "after <name> <phone> - insert a record after the current\n"
            "back <name> <phone> - insert a record at the end of the database\n"
            "change <name> <phone> - change the current record\n"
            "Ctrl-Z or F6 - quit\n"
            "------------------------------------------------------------\n";
}

string reset() {
    i = db.begin();
    return "Success\n";
}

string curr() {
    return i->toString();
}

string next() {
    if (i != db.end()) {
        i++;
        return "Success\n";
    }
    throw "Failed!";
}

string prev() {
    if (i != (db.begin()--)) {
        i--;
        return "Succes\n";
    }
    throw "Failed!";
}

string change() {
    string name, phone;
    cout << "name: ";
    cin >> name;
    cout << "phone: ";
    cin >> phone;
    i->setName(name);
    i->setPhone(phone);
    return "Success\n";
}

string moven() {
    int n;
    cin >> n;
    cout << n;
    int dist;
    if (n > 0) {
        dist = distance(i, db.end());
    } else {
        dist = distance((db.begin()--), i);
    }
    if (abs(n) < dist) {
        advance(i, n);
        return "Success\n";
    }
    throw "Failed!";
}

template<class it_>
string change(it_ it) { // Modify a record pointed to by a specified it_
    string name, phone;
    cout << "name: ";
    cin >> name;
    cout << "phone: ";
    cin >> phone;

    Person rec(name, phone);
    *it = rec;
    i = db.begin();

    return "Success\n";
}

// A command handler: called by transform() (see below)
string cmdHandler(string cmd) {
    try {
        if (cmd == "help") {
            return help();
        } else if (cmd == "reset") {
            return reset();
        } else if (cmd == "curr") {
            return curr();
        } else if (cmd == "next") {
            return next();
        } else if (cmd == "prev") {
            return prev();
        } else if (cmd == "nextn") {
            return moven(); //nextn
        } else if (cmd == "prevn") {
            return moven(); //prevn
        } else if (cmd == "change") {
            return change();
        } else if (cmd == "before") {
            return change(inserter<PhBook>(db, i));
        } else if (cmd == "after") {
            // Same: insert into the current position
            return change(inserter<PhBook>(db, ++i));
        } else if (cmd == "back") {
            // Insert to the end of the database (push back)
            return change(back_inserter<PhBook>(db));
        } else {
            return "Invalid command! Type 'help' for a list of commands\n";
        }
    } catch (...) {
        return "Past-end iterator dereferenced!\n";
    }
}

int main() {
    db.push_back(
            Person("Roman", "1")
    );
    db.push_back(
            Person("Grigory", "2")
    );
    db.push_back(
            Person("Lev", "3")
    );
    db.push_back(
            Person("Alexander", "4")
    );

    i = db.begin();
    cout << help();
    while (true) {
        string cmd;
        cout << "cmd: ";
        cin >> cmd;
        cout << cmdHandler(cmd);
    }
    return 0;
}
