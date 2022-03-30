//8 в 4 Акомелков А.Г
#include <iostream>
#include <string>#include <Windows.h>
#include <string>


using namespace std;
void main()
{
    string sFileName;
    BITMAPFILEHEADER bmpFileHeader;
    BITMAPINFOHEADER bmpInfoHeader;
    int Width, Height;
    RGBQUAD Palette[16];
    BYTE* inBuf;
    BYTE* outBuf;
    HANDLE hInputFile, hOutFile;
    DWORD RW;
    sFileName = "my.bmp";
    hInputFile = CreateFileA(sFileName.c_str(), GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
    if (hInputFile == INVALID_HANDLE_VALUE)
        return;
    hOutFile = CreateFileA("Result.bmp", GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, 0, NULL);
    if (hOutFile == INVALID_HANDLE_VALUE)
    {
        CloseHandle(hInputFile);
        return;
    }
    // Считываем инфу
    ReadFile(hInputFile, &bmpFileHeader, sizeof(bmpFileHeader), &RW, NULL);
    ReadFile(hInputFile, &bmpInfoHeader, sizeof(bmpInfoHeader), &RW, NULL);
    // Установим указатель на начало растра
    SetFilePointer(hInputFile, bmpFileHeader.bfOffBits, NULL, FILE_BEGIN);
    Width = bmpInfoHeader.biWidth;
    Height = bmpInfoHeader.biHeight;
    // Выделим память
    inBuf = new BYTE[Width];
    outBuf = new BYTE[Width/2];
    // Заполним заголовки
    bmpFileHeader.bfOffBits = sizeof(bmpFileHeader) + sizeof(bmpInfoHeader) + 64;
    bmpInfoHeader.biBitCount = 4;
    bmpInfoHeader.biCompression = BI_RGB;
    bmpFileHeader.bfSize = bmpFileHeader.bfOffBits + ((Width / 2) * Height) + Height * ((3 * Width / 2) % 4);
    // Запишем заголовки
    WriteFile(hOutFile, &bmpFileHeader, sizeof(bmpFileHeader), &RW, NULL);
    WriteFile(hOutFile, &bmpInfoHeader,	sizeof(bmpInfoHeader), &RW, NULL);
    // Палитра черно-белая
    for (int i = 0; i < 16; i++)
    {
        Palette[i].rgbBlue = i * 16;
        Palette[i].rgbGreen = i * 16;
        Palette[i].rgbRed = i * 16;
    }
    WriteFile(hOutFile, Palette, 16 * sizeof(RGBQUAD), &RW, NULL);
    // Начнем преобразовывать
    double b = 0.019, g = 0.015, r = 0.03;
    for (int i = 0; i < Height; i++)
    {
        int inNum = 0;
        ReadFile(hInputFile, inBuf, sizeof(BYTE) * Width, &RW, NULL);
        for (int j = 0; j < Width / 2; j++) {
            outBuf[j] = (inBuf[inNum]) * 16;
            outBuf[j] = outBuf[j] + (r * inBuf[inNum + 1] + g * inBuf[inNum + 1] + b * inBuf[inNum + 1]);
            inNum += 2;
        }
        WriteFile(hOutFile, outBuf, sizeof(BYTE) * Width / 2, &RW, NULL);
        // Пишем мусор для выравнивания
        WriteFile(hOutFile, Palette, (3 * Width / 2) % 4, &RW, NULL);
        SetFilePointer(hInputFile, (3 * Width) % 4, NULL, FILE_CURRENT);
    }
    delete[] inBuf;
    delete[] outBuf;
    CloseHandle(hInputFile);
    CloseHandle(hOutFile);
    cout << "Updating has come to the end successfully!";
}