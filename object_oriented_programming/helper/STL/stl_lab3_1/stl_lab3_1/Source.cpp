// В очередь могут быть добавлены элементы, каждому элементу при добавлении присваивается один из трех уровней приоритета 
//(low, normal, high). Элементы из очереди извлекаются в соответствии с их приоритетами(сначала извлекаются элементы с 
//приоритетом high, потом normal, потом low), элементы с одинаковыми приоритетами извлекаются из очереди в порядки их поступления.
//
// В очереди также может происходить операция акселерации – все элементы с приоритетом low находящиеся в момент акселерации в 
//очереди увеличивают свой приоритет до high и «обгоняют» элементы с приоритетом normal.
//
// Реализовать этот класс, используя list или std::deque. Объяснить свой выбор.
// https://baptiste-wicht.com/posts/2012/12/cpp-benchmark-vector-list-deque.html
//Протестируете программу, добавьте отладочный вывод, показывающий, что  класс работает правильно.


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
    // Конструктор, создает пустую очередь
    std::deque<QueueElement> lowP;
    std::deque<QueueElement> normalP;
    std::deque<QueueElement> highP;

    // Конструктор, создает пустую очередь
   // QueueWithPriority();
    // Деструктор
 //   ~QueueWithPriority();

    //Показать элементы
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


    // Добавить в очередь элемент element с приоритетом priority
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


    // Получить элемент из очереди
    // метод должен возвращать элемент с наибольшим приоритетом, который был
    // добавлен в очередь раньше других
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

    // Выполнить акселерацию
   // все элементы с приоритетом low находящиеся в момент акселерации в
   //очереди увеличивают свой приоритет до high и «обгоняют» элементы с приоритетом normal.
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

    //Формируем очередь    
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


    //Выводим очередь
    std::cout << "Высокий приоритет: " << std::endl;
    chems.printHighPQ();
    std::cout << std::endl;

    std::cout << "Средний приоритет: " << std::endl;
    chems.printNormalPQ();
    std::cout << std::endl;

    std::cout << "Низкий приоритет: " << std::endl;
    chems.printLowPQ();
    std::cout << std::endl;

    //Убираем из очереди элемент
    std::cout << "Убран элемент:" << std::endl;
    QueueElement leaving = chems.GetElementFromQueue();
    std::cout << leaving.name << std::endl;


    //Кто остался в очереди
    std::cout << std::endl << "В очереди остались:" << std::endl;

    std::cout << "Высокий приоритет: " << std::endl;
    chems.printHighPQ();
    std::cout << std::endl;

    std::cout << "Средний приоритет: " << std::endl;
    chems.printNormalPQ();
    std::cout << std::endl;

    std::cout << "Низкий приоритет: " << std::endl;
    chems.printLowPQ();
    std::cout << std::endl;


    //Выполняем акселерацию
    chems.Accelerate();
    std::cout << "Очередь после ускорения: " << std::endl;

    std::cout << "Высокий приоритет: " << std::endl;
    chems.printHighPQ();
    std::cout << std::endl;

    std::cout << "Средний приоритет: " << std::endl;
    chems.printNormalPQ();
    std::cout << std::endl;

    std::cout << "Низкий приоритет: " << std::endl;
    chems.printLowPQ();
    std::cout << std::endl;


    return 0;
}


