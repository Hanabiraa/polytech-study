#include <iostream>
#include <string>
#include <queue>

typedef enum {
    LOW,
    NORMAL,
    HIGH
} ElementPriority;

typedef struct {
    std::string name;
} QueueElement;

class QueueWithPriority {
public:
    // Конструктор, создает пустую очередь
    QueueWithPriority() {
        low_q;
        normal_q;
        high_q;
    }

    // Деструктор
    ~QueueWithPriority() {
        while (!this->low_q.empty()) low_q.pop();
        while (!this->normal_q.empty()) normal_q.pop();
        while (!this->high_q.empty()) high_q.pop();
    }

    // Добавить в очередь элемент element с приоритетом priority
    void PutElementToQueue(const QueueElement &element, ElementPriority priority) {
        switch (priority) {
            case LOW:
                this->low_q.push(element);
                break;
            case NORMAL:
                this->normal_q.push(element);
                break;
            case HIGH:
                this->high_q.push(element);
                break;
            default:
                throw "Bad priority";
        }
    }

    // Получить элемент из очереди
    // метод должен возвращать элемент с наибольшим приоритетом, который был
    // добавлен в очередь раньше других
    QueueElement GetElementFromQueue() {
        QueueElement pop_el;
        if (!this->high_q.empty()) {
            pop_el = high_q.front();
            this->high_q.pop();
            return pop_el;
        } else if (!this->normal_q.empty()) {
            pop_el = normal_q.front();
            this->normal_q.pop();
            return pop_el;
        } else if (!this->low_q.empty()) {
            pop_el = low_q.front();
            this->low_q.pop();
            return pop_el;
        } else {
            throw "empty queue";
        }
    }

    // Выполнить акселерацию
    void Accelerate() {
        while (!this->low_q.empty()) {
            this->high_q.push(this->low_q.front());
            low_q.pop();
        }
    }

private:
    std::queue<QueueElement> low_q;
    std::queue<QueueElement> normal_q;
    std::queue<QueueElement> high_q;
};

int main() {
    auto q = QueueWithPriority();
    for (int i=1; i <= 5; ++i) {
        QueueElement el;
        el.name = "low + " + std::to_string(i);
        q.PutElementToQueue(el, LOW);
    }
    for (int i=1; i <= 5; ++i) {
        QueueElement el;
        el.name = "normal + " + std::to_string(i * 10);
        q.PutElementToQueue(el, NORMAL);
    }
    for (int i=1; i <= 5; ++i) {
        QueueElement el;
        el.name = "high + " + std::to_string(i * 100);
        q.PutElementToQueue(el, HIGH);
    }

    std::cout << "Print queue:\n";
    for (int i=0; i < 15; ++i) {
        QueueElement el = q.GetElementFromQueue();
        std::cout << el.name << '\n';
    }

    // ---- accelerate
    for (int i=1; i <= 5; ++i) {
        QueueElement el;
        el.name = "low + " + std::to_string(i);
        q.PutElementToQueue(el, LOW);
    }
    for (int i=1; i <= 5; ++i) {
        QueueElement el;
        el.name = "normal + " + std::to_string(i * 10);
        q.PutElementToQueue(el, NORMAL);
    }
    for (int i=1; i <= 5; ++i) {
        QueueElement el;
        el.name = "high + " + std::to_string(i * 100);
        q.PutElementToQueue(el, HIGH);
    }

    std::cout << "\n\nPrint queue after accelerate:\n";
    q.Accelerate();
    for (int i=0; i < 15; ++i) {
        QueueElement el = q.GetElementFromQueue();
        std::cout << el.name << '\n';
    }

    return 0;
}
