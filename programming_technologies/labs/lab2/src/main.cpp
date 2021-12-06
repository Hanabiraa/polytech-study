#include <iostream>
#include <iomanip>
#include <fstream>

/*
 * Напишите функцию main, в которой примените вашу функцию.
 * 1) Матрицы должны быть размещены в динамической памяти.
 * 2) Для заданий, где необходимо обработать матрицу, размерность матрицы и значения элементов необходимо считывать из файла
 * (для простоты можно считать матрицу квадратной), а результат вывести на экран. В файле может быть сколько угодно матриц.
 * 3) Для заданий, где необходимо заполнить матрицу, размерность запросить с клавиатуры,вывести результат на экран и в файл,а
 * после повторять операцию до ввода нулевого размера.
*/



/*
 * Вариант 11.
 * Для заданных k и m элементу a[k][m] присвоить значение 1,элементам,окаймляющим его
 * (соседним с ним по вертикали, горизонтали и диагоналям) –значения 2, элементам следующего окаймления-значение 3,
 * и так далее до заполнения матрицы.
 */

void printMatrix(int **, int, int);

void printMatrixInFile(int **, int, int, int, int, std::ofstream &);

void matrixFrame(int **, int, int, int, int);

int main() {
    std::ofstream outf("./../output/outfile.txt", std::ios::out);

    while (true) {
        int nRows, nColumn;
        int k, m;
        std::cout << "Enter matrix size (row, columns): ";
        std::cin >> nRows >> nColumn;
        if (nRows == 0 && nColumn == 0) {
            break;
        }
        std::cout << "Enter pos of first element (row, columns): ";
        std::cin >> k >> m;

        //  Initialization matrix
        int **matrix = new int *[nRows];
        for (int i = 0; i < nRows; ++i) {
            matrix[i] = new int[nColumn];
        }

        matrixFrame(matrix, nRows, nColumn, k, m);

        printMatrix(matrix, nRows, nColumn);
        printMatrixInFile(matrix, nRows, nColumn, k, m, outf);
    }
    outf.close();
    return 0;
}

// complexity O(N^2)
void matrixFrame(int **array, int nRow, int nCol, int k, int m) {
    for (int i = 0; i < nRow; ++i) {
        for (int j = 0; j < nCol; ++j) {
            int dk = abs(k - i);
            int dm = abs(m - j);
            array[i][j] = 1 + (dk > dm ? dk : dm);
        }
    }
}

void printMatrix(int **array, int nRow, int nCol) {
    for (int i = 0; i < nRow; ++i) {
        for (int j = 0; j < nCol; ++j) {
            std::cout << std::setw(2) << array[i][j];
        }
        std::cout << '\n';
    }
}

void printMatrixInFile(int **array, int nRow, int nCol, int k, int m, std::ofstream &outf) {
    outf << "=== rows: " << nRow << " cols: " << nCol << " ===\n";
    outf << "===  pos: (" << k << ',' << m << ") ===\n";
    for (int i = 0; i < nRow; ++i) {
        for (int j = 0; j < nCol; ++j) {
            outf << std::setw(2) << array[i][j];
        }
        outf << '\n';
    }
    outf << '\n';
}
