#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <string>
#include <map>

//const char PATH_TO_MAIN_DATA[] = "Main_data.txt"; // массив данных, требующих обработку (первые два числа размерность матрицы, потом сами данные)
//const char PATH_TO_INPUT_COMP[] = "Compair_data.txt"; // сравнение пар вариантов (0 при предпочтении большего значения, например - год выпуска,
//// 1 при предпочтении меньшего значения, например - цена)
//const char PATH_TO_INPUT_POWER[] = "Power_coeff.txt"; // массив весовых коэффициентов (в сумме равны 1)

const char PATH_TO_MAIN_DATA[] = "/Users/akira/Documents/projects/polytech-study/system_analysis_and_decision_making/courseWork/Main_data_var.txt";
const char PATH_TO_INPUT_COMP[] = "/Users/akira/Documents/projects/polytech-study/system_analysis_and_decision_making/courseWork/Compair_data_var.txt";
const char PATH_TO_INPUT_POWER[] = "/Users/akira/Documents/projects/polytech-study/system_analysis_and_decision_making/courseWork/Power_coeff_var.txt";

//считать размеры массива
std::pair<double, double> sizeArr(std::ifstream &in) {
    double i, j;
    in >> i >> j;
    return std::make_pair(i, j);
}

//выделение памяти для динамического двухмерного массива
double **createArr(double n, double m) {
    double **A;
    A = new double *[n];
    for (int i = 0; i < n; i++) {
        A[i] = new double[m];
    }
    return A;
}

//вывести двумерный массив
void writeArr(int starti, int startj, double **arr, double n, double m) {
    for (int i = starti; i < n; i++) {
        for (int j = startj; j < m; j++) {
            std::cout << arr[i][j] << "\t";
        }
        std::cout << std::endl;
    }
}

//вывести одномерный массив
void writeArr_x1(double *arr, double n) {
    for (int i = 0; i < n; i++) {
        std::cout << arr[i] << "\t";
    }
    std::cout << std::endl;
}

//считать массив размером NxM из входящего потока
void readFile(double **arr, double n, double m, std::ifstream &in) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            in >> arr[i][j];
        }
    }
}

//уничтожить двумерный массив
void distractionArray(double **arr, int n) {
    for (int i = 0; i < n; ++i) {
        delete[] arr[i];
    }
    delete[] arr;
}

//Вывести элемент пары на экран
void show(std::pair<double, double> i) //Функция, которая будет передаваться в алгоритм
{
    std::cout << i.first << " "; //просто выводит параметр на экран
}

//Записать массив в файл
void outputmf(double **a, double n, double m, int numofrow, std::ofstream &f) {
    int i, j;
    std::string strname = "out_dom_" + std::to_string(numofrow) + ".txt";
    f.open(strname);
    if (!f) {
        std::cerr << "File can not be opened\n";
        exit(0);
    }
    f << "This is: " << numofrow + 1 << " element" << std::endl;
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++)
            f << a[i][j] << "\t";
        f << std::endl;
    }
    f.close();
    f.clear();
}

//Построить матрицу на основе бинарных отношений (двунаправленный граф отражённый на матрице)
double **dom_matrix_creat_0(double *Dics_data, double **Dom_data, int n, int count) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < count; j++) {
            Dom_data[i][j] = 0;
        }
    }
    int count_row = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((Dics_data[i] == Dics_data[j]) and (i != j)) {
                Dom_data[i][count_row] = 0.5;
                Dom_data[j][count_row] = -0.5;
                count_row++;
            } else if ((Dics_data[i] > Dics_data[j]) and (i != j)) {
                Dom_data[i][count_row] = 1;
                Dom_data[j][count_row] = -1;
                count_row++;
            }
        }
    }
    return Dom_data;
}

double **dom_matrix_creat_1(double *Dics_data, double **Dom_data, int n, int count) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < count; j++) {
            Dom_data[i][j] = 0;
        }
    }
    int count_row = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((Dics_data[i] == Dics_data[j]) and (i != j)) {
                Dom_data[i][count_row] = 0.5;
                Dom_data[j][count_row] = -0.5;
                count_row++;
            } else if ((Dics_data[i] < Dics_data[j]) and (i != j)) {
                Dom_data[i][count_row] = 1;
                Dom_data[j][count_row] = -1;
                count_row++;
            }
        }
    }
    return Dom_data;
}

//получить количество связей из строки матрицы бинарных отношений
int map_count_con(double *Dics_data, int n) {
    int count_row = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((Dics_data[i] >= Dics_data[j]) and (i != j)) {
                count_row++;
            }
        }
    }
    return count_row;
}

//почитать призовое место в матрице
int count_max_pow(double *Dics_data, int n, double si) {
    std::map<double, double> mp;
    int count = 1;
    for (int i = 0; i < n; i++) {
        mp[Dics_data[i]] = i;
    }
    for (auto &item: mp) {
        if (item.first > si) count++;
    }
    return count;
}

//почитать призовое место в матрице
int count_point(double si) {
    if (si == 1) return 3;
    else if (si == 2) return 2;
    else if (si == 3) return 1;
    else
        return 0;
}

//посчитать количество доминирующих связей в строке матрице (двунаправленный граф отражённый на матрице)
int count_dom_in_row(double *Dics_data, int n) {
    int dom_count = 0;
    for (int j = 0; j < n; j++) {
        if ((Dics_data[j] == 1) or (Dics_data[j] == 0.5)) {
            dom_count++;
        }
    }
    return dom_count;
}

//посчитать силу
double count_dom_pow_in_row(double *Dics_data, int n) {
    double dom_count = 0.0;
    for (int j = 0; j < n; j++) {
        if (Dics_data[j] > 0) {
            dom_count += Dics_data[j];
        }
    }
    return dom_count;
}

int block_in_row(double *Dics_data, int n) {
    int dom_count = 0;
    for (int j = 0; j < n; j++) {
        if ((Dics_data[j] == -1) or (Dics_data[j] == -0.5)) {
            dom_count++;
        }
    }
    if (dom_count != 0) return 0;
    else
        return 1;
}

int count_clear_dom(double *Dics_data, int n) {
    int dom_count = 0;
    for (int j = 0; j < n; j++) {
        if ((Dics_data[j] == 1)) {
            dom_count++;
        }
    }
    return dom_count;
}

int count_ecv_dom(double *Dics_data, int n) {
    int dom_count = 0;
    for (int j = 0; j < n; j++) {
        if ((Dics_data[j] == 0.5)) {
            dom_count++;
        }
    }
    return dom_count;
}

void writeArrTheBest(double **arr, double n, double m, int numRow) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            std::cout << arr[i][j] << "\t";
        }
        std::cout << std::endl;
    }
}

int main() {
    std::ofstream f; //поток для записи данных в файл
    std::ifstream in; //поток для считывания основных данных
    std::ifstream in_pow; //поток для считывания данных о силе
    std::ifstream in_com; //поток для считывания данных о том какой вид сравнения надо использоваться
    std::ifstream in_nam; //поток для считывания данных о том какой вид сравнения надо использоваться


    int x;
    double errTemp;
    int Result_data_size = 14;
    int kmax_result_size = 4;
    in.open(PATH_TO_MAIN_DATA);
    in_pow.open(PATH_TO_INPUT_POWER);
    in_com.open(PATH_TO_INPUT_COMP);
    std::pair<double, double> addres = sizeArr(in);
    double **Dics_data = createArr(addres.first, addres.second);

    readFile(Dics_data, addres.first, addres.second, in);
//Массив сравнений

    // std::cout << addres.first << " " << addres.second << std::endl;

    x = 0;
    double *Comp_arr = new double[addres.first];
    while (!in_com.eof()) {
        in_com >> Comp_arr[x];
        x++;
    }
    if (x != addres.first) {
        std::cout << "Error Comp: the number of elements in Data_comparison_conf.txt does not match the task ";
        return 0;
    }

    // массив силы!
    x = 0;
    errTemp = 0.0;
    double *Pow_arr = new double[addres.first];
    while (!in_pow.eof()) {
        in_pow >> Pow_arr[x];
        errTemp += Pow_arr[x];
        x++;
    }
    if (x != addres.first) {
        std::cout << "Error Pow: the number of elements in Data_power.txt does not match the task ";
        return 0;
    }
    in.close();
    in_pow.close();
    in_com.close();

    double **Result_data = createArr(addres.second, Result_data_size);
    for (int i = 0; i < addres.second; i++) {
        for (int j = 0; j < Result_data_size; j++) {
            Result_data[i][j] = 0;
        }
    }

    for (int i = 0; i < addres.first; i++) {
        int count = map_count_con(Dics_data[i], addres.second);
        double **Dom_data = createArr(addres.second, count);
        double **kMax = createArr(addres.second, kmax_result_size);
        double *arr = new double[addres.second];
        double Mull_koef = 0;
//создание графа отношений
        if (Comp_arr[i] == 0.0)
            Dom_data = dom_matrix_creat_0(Dics_data[i], Dom_data, addres.second, count);
        else if (Comp_arr[i] == 1.0)
            Dom_data = dom_matrix_creat_1(Dics_data[i], Dom_data, addres.second, count);
        else if (Comp_arr[i] == -1.0) {
            distractionArray(Dom_data, addres.second);
            continue;
        }

        for (int j = 0; j < addres.second; j++) {
            Result_data[j][0] = count_dom_in_row(Dom_data[j], count);
            arr[j] = Result_data[j][0];
            for (int k = 0; k < kmax_result_size; k++) {
                kMax[j][k] = 0;
            }
        }

        for (int j = 0; j < addres.second; j++) {
            int temp_dom = count_max_pow(arr, addres.second, Result_data[j][0]);
            int temp_block = block_in_row(Dom_data[j], count);
            kMax[j][0] = count_clear_dom(Dom_data[j], count) + 0 + count_ecv_dom(Dom_data[j], count);
            kMax[j][1] = count_clear_dom(Dom_data[j], count) + 0;
            kMax[j][2] = count_clear_dom(Dom_data[j], count) + count_ecv_dom(Dom_data[j], count);
            kMax[j][3] = count_clear_dom(Dom_data[j], count);
            Result_data[j][7] += count_dom_pow_in_row(Dom_data[j], count);
            Result_data[j][8] += count_dom_pow_in_row(Dom_data[j], count) * Pow_arr[i];
            if (kMax[j][3] == (addres.second - 1)) Mull_koef = 2;
            else Mull_koef = 0;
            Result_data[j][10] += count_dom_pow_in_row(kMax[j], kmax_result_size) * Pow_arr[i];
            Result_data[j][12] += count_dom_pow_in_row(kMax[j], kmax_result_size) * Pow_arr[i] * Mull_koef;
            if (temp_dom == 1) {
                Result_data[j][1] += temp_dom;
                Result_data[j][2] += Pow_arr[i];
            }
            if (temp_block == 1) {
                Result_data[j][4] += block_in_row(Dom_data[j], count);
                Result_data[j][5] += Pow_arr[i];
            }
        }
        outputmf(Dom_data, addres.second, count, i, f);
        distractionArray(Dom_data, addres.second);
        distractionArray(kMax, addres.second);

    }
    double *pos_dom = new double[addres.second];
    double *pos_block = new double[addres.second];
    double *pos_dom_pow = new double[addres.second];
    double *pos_kMax_Sjp = new double[addres.second];
    double *pos_kMax_Sjm = new double[addres.second];
    for (int j = 0; j < addres.second; j++) {
        pos_dom[j] = Result_data[j][2];
        pos_block[j] = Result_data[j][5];
        pos_dom_pow[j] = Result_data[j][8];
        pos_kMax_Sjp[j] = Result_data[j][10];
        pos_kMax_Sjm[j] = Result_data[j][12];
    }
    for (int j = 0; j < addres.second; j++) {
        Result_data[j][3] = count_max_pow(pos_dom, addres.second, Result_data[j][2]);
        Result_data[j][6] = count_max_pow(pos_block, addres.second, Result_data[j][5]);
        Result_data[j][9] = count_max_pow(pos_dom_pow, addres.second, Result_data[j][8]);
        Result_data[j][11] = count_max_pow(pos_kMax_Sjp, addres.second, Result_data[j][10]);
        Result_data[j][13] = count_max_pow(pos_kMax_Sjm, addres.second, Result_data[j][12]);
    }

    double **Final_data = createArr(addres.second, 6);
    for (int j = 0; j < addres.second; j++) {
        pos_dom[j] = Result_data[j][3];
        pos_block[j] = Result_data[j][6];
        pos_dom_pow[j] = Result_data[j][9];
        pos_kMax_Sjp[j] = Result_data[j][11];
        pos_kMax_Sjm[j] = Result_data[j][13];
    }

    for (int j = 0; j < addres.second; j++) {
        Final_data[j][0] = count_point(Result_data[j][3]);
        Final_data[j][1] = count_point(Result_data[j][6]);
        Final_data[j][2] = count_point(Result_data[j][9]);
        Final_data[j][3] = count_point(Result_data[j][11]);
        Final_data[j][4] = count_point(Result_data[j][13]);
        Final_data[j][5] = count_point(Result_data[j][3]) +
                           count_point(Result_data[j][6]) + count_point(Result_data[j][9]) +
                           count_point(Result_data[j][11]) + count_point(Result_data[j][13]);
    }

    double *pos_final = new double[addres.second];
    for (int j = 0; j < addres.second; j++) {
        pos_final[j] = Final_data[j][5];
    }
    for (int j = 0; j < addres.second; j++) {
        Final_data[j][6] = count_max_pow(pos_final, addres.second, Final_data[j][5]);
    }
    std::cout << "Исходные данные" << std::endl;
    writeArr(0, 0, Dics_data, addres.first, addres.second);
    std::cout << "Механизм доминирования" << std::endl;
    writeArr(0, 1, Result_data, addres.second, 4);
    std::cout << "Механизм блокировки" << std::endl;
    writeArr(0, 4, Result_data, addres.second, 7);
    std::cout << "Турнирный механизм" << std::endl;
    writeArr(0, 8, Result_data, addres.second, 10);
    std::cout << "Механизм k-Max" << std::endl;
    writeArr(0, 10, Result_data, addres.second, 14);
    std::cout << "Подсчет баллов" << std::endl;
    writeArrTheBest(Final_data, addres.second, 7.0, 1);
    distractionArray(Result_data, addres.second);
    distractionArray(Dics_data, addres.first);
    f.close();
}