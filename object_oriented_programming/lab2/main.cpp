#include <iostream>
#include <fstream>

using namespace std;

int main() {
    string strCounter1;
    string strCounter2;
    string str;
    string strInput;
    int pos;
    std::ifstream in("/work/polytech-study/object_oriented_programming/lab2/in.txt");
    if (!in.is_open()) {
        std::cout << "error";
        return -1;
    }
    while (!in.eof()) {
        in >> strInput;
        if (strInput.length() >=10 ) {
            strInput = " Vau!!!";
        }
        else if (strInput[0] == ',' or strInput[0] == '.' or strInput[0] == '!' or strInput[0] == ':' or strInput[0] == ';'){
            strInput.insert(1, string(" "));
        }
        else {
            strInput = " " + strInput;
        }
        while ((pos = str.find("  ")) != str.npos){
            str.erase(pos,1);
        }
        strCounter2 = strCounter1;
        strCounter1 += strInput;


        if (strCounter1.length() > 40) {
            strCounter2.erase(0,1);
            str += strCounter2 + '\n';
            strCounter1 = strInput;
        }

    }
    in.close();
    strCounter1.erase(0,1);
    std::ofstream outf("/work/polytech-study/object_oriented_programming/lab2/out.txt");
    if (!outf)
    {
        cerr << "error" << endl;
        exit(1);
    }
    outf << str;
    return 0;
}
