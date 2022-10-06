//
// Created by Виталий Копылов on 10.04.2022.
//Написать программу, которая выполняет следующие действия (все операции должны выполняться с помощью стандартных алгоритмов):
// a) Заполняет вектор геометрическими фигурами. Геометрическая фигура может быть треугольником, квадратом, прямоугольником или пяти угольником. Структура описывающая геометрическую фигуру  определена ниже,
// b) Подсчитывает общее количество вершин всех фигур содержащихся в векторе (так треугольник добавляет к общему числу 3, квадрат 4 и т.д.)
// c) Подсчитывает количество треугольников, квадратов и прямоугольников в векторе
// d) Удаляет все пятиугольники
// e) На основании этого вектора создает vector<Point>, который содержит координаты одной из вершин (любой) каждой фигуры, т.е. первый элемент этого вектора содержит координаты одной из вершину первой фигуры, второй элемент этого вектора содержит координаты одной из вершину второй фигуры и т.д.
// f) Изменяет вектор так, чтобы он содержал в начале все треугольники, потом все квадраты, а потом прямоугольники.
// g) Распечатывает вектор после каждого этапа работы
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <ctime>

using namespace std;

typedef struct {
    int x, y;
} Point;

typedef struct {
    int vertex_num;      // количество вершин, для треугольника 3, для квадрата и
    // прямоугольника 4, для пяти угольника 5
    vector<Point> vertexes;   // вектор содержащий координаты вершин фигуры
    // Для треугольника содержит 3 элемента
    // Для квадрата и прямоугольника содержит 4
    // элемента
    // Для пятиугольника 5 элементов
} Shape;

bool isTriangle(Shape &k);

bool isRectangle(Shape &k);

bool isPentagon(Shape &k);

vector<Shape> genShapes();

Shape genShape(int);

void printShape(Shape fig);

int count(vector<Shape>);

void task2() {
    // инициация
    vector<Shape> figs{25};
    srand(2);
    generate(figs.begin(), figs.end(), []() {
        Shape fig;
        fig.vertex_num = rand() % 3 + 3;
        for (auto i = 0; i < fig.vertex_num; ++i) {
            Point dot;
            dot.x = rand() % 100;
            dot.y = rand() % 100;
            fig.vertexes.push_back(dot);
        }
        return fig;
    });
    cout << "Исходный массив: \n";
    for_each(figs.begin(), figs.end(), [](Shape fig) {
        cout << "Number of vertices: " << fig.vertex_num << '\t';
        for (auto dot: fig.vertexes) {
            cout << "(" << dot.x << ";" << dot.y << ")\t";
        }
        cout << endl;
    });

    // подсчет вершин
    int count = 0;
    for_each(figs.begin(), figs.end(), [&count](Shape fig) {
        count += fig.vertex_num;
    });
    cout << "\nОбщее количество вершин: " << count;

    // подсчет треугольников, квадратов, прямоугольников
    cout << "\nОбщее количество треугольников, квадратов, прямоугольник: "
         << count_if(figs.begin(), figs.end(), [](Shape fig) {
             if (fig.vertex_num == 3 || fig.vertex_num == 4) {
                 return true;
             }
             return false;
         }) << '\n';

    // удаление пятиугольников
    figs.erase(remove_if(figs.begin(), figs.end(), [](Shape fig) {
        if (fig.vertex_num == 5) {
            return true;
        }
        return false;
    }), figs.end());
    cout << "\nСписок после удаления пятиугольников:\n";
    for_each(figs.begin(), figs.end(), [](Shape fig) {
        cout << "Number of vertices: " << fig.vertex_num << '\t';
        for (auto dot: fig.vertexes) {
            cout << "(" << dot.x << ";" << dot.y << ")\t";
        }
        cout << endl;
    });

    // создание вектора точек
    vector<Point> dots_;
    for_each(figs.begin(), figs.end(), [&dots_](Shape fig) {
        dots_.push_back(fig.vertexes[0]);
    });

    cout << "\nСписок точек:\n";
    for_each(dots_.begin(), dots_.end(), [](Point dot) {
        cout << "(" << dot.x << ";" << dot.y << ")\t";
    });

    // сортировка
    cout << "\n\n\nСортировка:\n";
    sort(figs.begin(), figs.end(), [](Shape fig1, Shape fig2) {
        return fig1.vertex_num < fig2.vertex_num;
    });
    for_each(figs.begin(), figs.end(), [](Shape fig) {
        cout << "Number of vertices: " << fig.vertex_num << '\t';
        for (auto dot: fig.vertexes) {
            cout << "(" << dot.x << ";" << dot.y << ")\t";
        }
        cout << endl;
    });
}

