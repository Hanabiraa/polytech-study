//2.	�������� ���������, ������� ��������� ��������� ��������(��� �������� ������ ����������� � ������� ����������� ����������) :
//	a.��������� ������ ��������������� ��������.�������������� ������ ����� ���� �������������, ���������, ��������������� ��� 
//	���� ����������.��������� ����������� �������������� ������  ���������� ����,
//	b.������������ ����� ���������� ������ ���� ����� ������������ � �������(��� ����������� ��������� � ������ ����� 3, ������� 4 � �.�.)
//	c.������������ ���������� �������������, ��������� � ��������������� � �������
//	d.������� ��� �������������
//	e.�� ��������� ����� ������� ������� vector<Point>, ������� �������� ���������� ����� �� ������(�����) ������ ������, 
//	�.�.������ ������� ����� ������� �������� ���������� ����� �� ������� ������ ������, 
//	������ ������� ����� ������� �������� ���������� ����� �� ������� ������ ������ � �.�.
//	f.�������� ������ ���, ����� �� �������� � ������ ��� ������������, ����� ��� ��������, � ����� ��������������.
//	g.������������� ������ ����� ������� ����� ������


#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <ctime>


using namespace std;

typedef struct
{
    int x, y;
} Point;

typedef struct
{

    int vertex_num;      // ���������� ������, ��� ������������ 3, ��� �������� �
    vector<Point> vertices;   // ������ ���������� ���������� ������ ������
} Shape;

vector<Point> points;

void print(vector<Shape> vec)
{
    cout << endl << "List of figures: \n" ;
    for (int i = 0; i < vec.size(); i++)
    {
        cout << "Number of vertices: " << vec[i].vertex_num << endl;

        for (int j = 0; j < vec[i].vertex_num; j++)
        {
            cout << "Vertex " << j + 1 << ": " << vec[i].vertices[j].x << "," << vec[i].vertices[j].y << endl;
        }
    }
    cout << endl;
}

//	a.��������� ������ ��������������� ��������.
void addShape(vector<Shape>& vec)
{
    Shape shapeIn;

    cout << "Choose the number of vertexes (3, 4, 5): ";
    cin >> shapeIn.vertex_num;

    for (int i = 0; i < shapeIn.vertex_num; i++)
    {
        Point p;
        cout << "Enter x" << i + 1 << ": ";
        cin >> p.x;
        cout << "Enter y" << i + 1 << ": ";
        cin >> p.y;
        shapeIn.vertices.push_back(p);
    }

    vec.push_back(shapeIn);
}

//	b.������������ ����� ���������� ������ ���� ����� ������������ � �������
int countVertices(vector<Shape>& vec)
{
    int count = 0;
    for (int i = 0; i < vec.size(); i++)
    {
        count += vec.at(i).vertex_num;
    }
    return count;
}


bool isTriangle(Shape& k)
{
    return k.vertex_num == 3;
}

bool isRectangle(Shape& k)
{
    return k.vertex_num == 4;
}

bool isPentagon(Shape& k)
{
    return k.vertex_num == 5;
}


//	c.������������ ���������� �������������, ��������� � ��������������� � �������
void countTypes(vector<Shape>& vec)
{

    int triangleNum = count_if(vec.begin(), vec.end(), isTriangle);
    int rectangleNum = count_if(vec.begin(), vec.end(), isTriangle);
    cout << "Number of tiangles = " << triangleNum << endl;
    cout << "Number of rectangles = " << rectangleNum << endl;

}

//	d.������� ��� �������������
void removePentagons(vector<Shape>& vec)
{
    vec.erase(remove_if(vec.begin(), vec.end(), isPentagon), vec.end());
}

//	e.�� ��������� ����� ������� ������� vector<Point>, ������� �������� ���������� ����� �� ������(�����) ������ ������, 
//	�.�.������ ������� ����� ������� �������� ���������� ����� �� ������� ������ ������, 
//	������ ������� ����� ������� �������� ���������� ����� �� ������� ������ ������ � �.�.
vector<Point> oneVertex(vector<Shape> vec)
{
    vector<Point> anyVertex;
    for (int i = 0; i < vec.size(); i++)
    {
        Point tmp = vec[i].vertices[0];
        anyVertex.push_back(tmp);
    }

    return anyVertex;
}

//	f.�������� ������ ���, ����� �� �������� � ������ ��� ������������, ����� ��� ��������, � ����� ��������������.

void sortByVertices(vector<Shape>& vec)
{
    sort(vec.begin(), vec.end(), [](Shape& s1, Shape& s2)
        {
            return s1.vertex_num < s2.vertex_num;
        });
}

int main() {
  
    srand(time(NULL));

    vector<Shape> figures;


    for (int i = 5; i > 2; --i)
    {
        Shape newShape;
        newShape.vertex_num = i;
        Point newPoint;

        for (int j = 0; j < i + 1; j++)
        {
            newPoint.x = rand() % 10;
            newPoint.y = rand() % 10;
            newShape.vertices.push_back(newPoint);
        }
        figures.push_back(newShape);
    }

    print(figures);
    
    while (true)
    {
        cout << "Choose the action:" << endl;
        cout << "1 - Add figure" << endl;
        cout << "2 - Count all vertices" << endl;
        cout << "3 - Count triangles and rectangles" << endl;
        cout << "4 - Remove all pentagons" << endl;
        cout << "5 - Creat Point vector that includes one vertex from each figure" << endl;
        cout << "6 - Sort figures by number of vertices " << endl;
        cout << "Press any button to exit" << endl << endl;
        cout << "Your choice: ";

        int choise;
        cin >> choise;

        switch (choise)
        {
        case 1: //Add figure
        {
            addShape(figures);
            print(figures);
            break;
        }
        case 2: //Count all vertices
        {
            countVertices(figures);
            break;
        }
        case 3: //Count triangles and rectangles
        {
            countTypes(figures);
            break;
        }
        case 4: //Remove all pentagons
        {
            removePentagons(figures);
            print(figures);
            break;
        }
        case 5: //Creat Point vector that includes one vertex from each figure
        {
            vector<Point> newPoint = oneVertex(figures);
            for (int i = 0; i < newPoint.size(); i++)
            {
                cout << "Vertex " << i << ": " << newPoint.at(i).x << "," << newPoint.at(i).y << endl;
            }
            break;
        }
        case 6: //Sort figures by number of vertices
        {
            sortByVertices(figures);
            print(figures);
            break;
        }
        default:
            return 0;
            break;
        }
    }

}