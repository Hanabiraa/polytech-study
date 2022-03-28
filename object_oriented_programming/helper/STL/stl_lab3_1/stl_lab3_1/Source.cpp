// � ������� ����� ���� ��������� ��������, ������� �������� ��� ���������� ������������� ���� �� ���� ������� ���������� 
//(low, normal, high). �������� �� ������� ����������� � ������������ � �� ������������(������� ����������� �������� � 
//����������� high, ����� normal, ����� low), �������� � ����������� ������������ ����������� �� ������� � ������� �� �����������.
//
// � ������� ����� ����� ����������� �������� ����������� � ��� �������� � ����������� low ����������� � ������ ����������� � 
//������� ����������� ���� ��������� �� high � ��������� �������� � ����������� normal.
//
// ����������� ���� �����, ��������� list ��� std::deque. ��������� ���� �����.
// https://baptiste-wicht.com/posts/2012/12/cpp-benchmark-vector-list-deque.html
//������������� ���������, �������� ���������� �����, ������������, ���  ����� �������� ���������.


#include <iostream>
#include <deque>


typedef enum
{
    LOW,
    NORMAL,
    HIGH
} ElementPriority;

typedef struct
{
    std::string name;
} QueueElement;

class QueueWithPriority
{
public:
    // �����������, ������� ������ �������
    std::deque<QueueElement> lowP;
    std::deque<QueueElement> normalP;
    std::deque<QueueElement> highP;

    // �����������, ������� ������ �������
   // QueueWithPriority();
    // ����������
 //   ~QueueWithPriority();

    //�������� ��������
    void printLowPQ() {
        for (int i = 0; i < lowP.size(); i++)
        {
            std::cout << lowP.at(i).name << " ";
        }
        std::cout << std::endl;
    }

    void printNormalPQ() {
        for (int i = 0; i < normalP.size(); i++)
        {
            std::cout << normalP.at(i).name << " ";
        }
        std::cout << std::endl;
    }

    void printHighPQ() {
        for (int i = 0; i < highP.size(); i++)
        {
            std::cout << highP.at(i).name << " ";
        }
        std::cout << std::endl;
    }


    // �������� � ������� ������� element � ����������� priority
    void PutElementToQueue(const QueueElement& element, ElementPriority priority)
    {
        if (priority == LOW)
        {
            lowP.push_back(element);
        }

        else if (priority == NORMAL)
        {
            normalP.push_back(element);
        }

        else if (priority == HIGH)
        {
            highP.push_back(element);
        }
    }


    // �������� ������� �� �������
    // ����� ������ ���������� ������� � ���������� �����������, ������� ���
    // �������� � ������� ������ ������
    QueueElement GetElementFromQueue()
    {
        if (!highP.empty())
        {
            QueueElement value;
            value = highP.front();
            highP.pop_front();
            return value;
        }

        if (!normalP.empty())
        {
            QueueElement value;
            value = normalP.front();
            normalP.pop_front();
            return value;
        }

        if (!lowP.empty())
        {
            QueueElement value;
            value = lowP.front();
            lowP.pop_front();
            return value;
        }

        else
        {
            std::cout << "The queue is empty" << std::endl;
        }
    }

    // ��������� �����������
   // ��� �������� � ����������� low ����������� � ������ ����������� �
   //������� ����������� ���� ��������� �� high � ��������� �������� � ����������� normal.
    void Accelerate()
    {
        int size = lowP.size();
        for (int i = 0; i < size; i++)
        {
            highP.push_back(lowP.front());
            lowP.pop_front();
        }
    }
};


int main() {
    setlocale(LC_ALL, "ru");

    QueueWithPriority chems = QueueWithPriority();

    //��������� �������    
    QueueElement elem_1;
    elem_1.name = "taskA";
    chems.PutElementToQueue(elem_1, LOW);

    QueueElement elem_2;
    elem_2.name = "taskB";
    chems.PutElementToQueue(elem_2, HIGH);

    QueueElement elem_3;
    elem_3.name = "storyC";
    chems.PutElementToQueue(elem_3, NORMAL);

    QueueElement elem_4;
    elem_4.name = "epicD";
    chems.PutElementToQueue(elem_4, HIGH);

    QueueElement elem_5;
    elem_5.name = "storyE";
    chems.PutElementToQueue(elem_5, NORMAL);

    QueueElement elem_6;
    elem_6.name = "taskF";
    chems.PutElementToQueue(elem_6, LOW);

    QueueElement elem_7;
    elem_7.name = "taskG";
    chems.PutElementToQueue(elem_7, NORMAL);

    QueueElement elem_8;
    elem_8.name = "storyH";
    chems.PutElementToQueue(elem_8, LOW);

    QueueElement elem_9;
    elem_9.name = "taskI";
    chems.PutElementToQueue(elem_9, HIGH);


    //������� �������
    std::cout << "������� ���������: " << std::endl;
    chems.printHighPQ();
    std::cout << std::endl;

    std::cout << "������� ���������: " << std::endl;
    chems.printNormalPQ();
    std::cout << std::endl;

    std::cout << "������ ���������: " << std::endl;
    chems.printLowPQ();
    std::cout << std::endl;

    //������� �� ������� �������
    std::cout << "����� �������:" << std::endl;
    QueueElement leaving = chems.GetElementFromQueue();
    std::cout << leaving.name << std::endl;


    //��� ������� � �������
    std::cout << std::endl << "� ������� ��������:" << std::endl;

    std::cout << "������� ���������: " << std::endl;
    chems.printHighPQ();
    std::cout << std::endl;

    std::cout << "������� ���������: " << std::endl;
    chems.printNormalPQ();
    std::cout << std::endl;

    std::cout << "������ ���������: " << std::endl;
    chems.printLowPQ();
    std::cout << std::endl;


    //��������� �����������
    chems.Accelerate();
    std::cout << "������� ����� ���������: " << std::endl;

    std::cout << "������� ���������: " << std::endl;
    chems.printHighPQ();
    std::cout << std::endl;

    std::cout << "������� ���������: " << std::endl;
    chems.printNormalPQ();
    std::cout << std::endl;

    std::cout << "������ ���������: " << std::endl;
    chems.printLowPQ();
    std::cout << std::endl;


    return 0;
}


