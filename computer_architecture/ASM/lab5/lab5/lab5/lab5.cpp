#include <iostream>

int main()
{
    int x = 32;
    __asm {
        mov eax, [x]
        mov [x], 16;
    }
    std::cout << x;
}