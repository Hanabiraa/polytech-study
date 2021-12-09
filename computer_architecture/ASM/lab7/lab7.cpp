#include <iostream>

int main()
{
    // Ввести три числа, просуммировать их и вывести сумму
    float num1 = 5.3;
    float num2 = 7.4;
    float num3 = 0.312;
    float acc = 0.0;
    
    __asm {
        finit
        fld num1
        fld num2
        fld num3
        fadd st(0), st(1)   // сложение с выталкиванием из стека
        fadd st(0), st(2)
        fstp acc // выгрузить в acc
    }

    std::cout << "Sum of: " << num1 << " + " << num2 << " + " << num3 << " = " << acc << '\n';


    // Получить NaN
    float numNaN = 0;
    __asm {
        finit
        fadd
        fstp numNaN
    }

    // проверить регистры FPU
    // 15 - Занятость FPU
    // 14, 10, 9, 8 - Код условия C3 C2 C1 C0
    // 13-11 - Указатель вершины стека
    // 7 - Суммарный статус ошибки
    // 6 - ошибка стека
    // 5 - антипереполнение
    // 4 - переполненение
    // 3 - деление на 0
    // 2 - денормализованный операнд
    // 1 - недействительность операции

    int regFlagsBefore = 0.0;
    int regFlagsAfter = 0x00F;
    __asm {
        finit
        fstcw regFlagsBefore
        fldcw regFlagsAfter
    }
    printf("Change FPU flags:\nBefore = %X\nAfter = %X", regFlagsBefore, regFlagsAfter);

    // особый случай FPU
    float bNum1 = 88888888831231231.0;
    float bnum2 = 123789123691239871289371892738971999.0;
    float sumBigNums = 0.0;

    __asm {
        finit
        fld bNum1
        fld bnum2
        fmul
        fstp sumBigNums
    }

    std::cout << "\nSum of: " << bNum1 << " * " << bnum2 <<  " = " << sumBigNums << '\n';
    return 0;
}
