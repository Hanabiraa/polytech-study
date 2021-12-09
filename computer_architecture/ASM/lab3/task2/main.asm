; Напишите программу на Ассемблере пересылки одноразрядных
; данных из одного массива в другой с использованием строковых команд.
; Выведите данные на экране компьютера с использованием 21 прерывания


DOSSEG      ; for MASM | TASM
.MODEL SMALL ; memory model. Code, Data, , Stack - in one memory segment <64kb

; --- MACRO SIGNATURE ---
print_symbol macro symbol
    mov dl, symbol
    mov ah, 2
    int 21h
endm

print_space macro
    mov dl, ' '
    mov ah, 2
    int 21h
endm

print_string macro string
    lea dx, string
    mov ah, 9
    int 21h
endm
; ------------------------
.STACK 100h
.DATA
    ; --- data ---
    A DW 0,1,234,30057,40,55,123,7,8,9
    B DW 10 DUP(0)
    MESSAGE1 DB 13, 10, 10, 'Start programm: Copy and print arrays', 10, 13, '$'
    MESSAGE2 DB 'Array output: ', '$'

.CODE
INIT:
    MAIN PROC
        ; --- init segments ---
        mov ax, @Data   ; init ds, es
        mov ds, ax
        mov es, ax
        mov bx, 10      ; size of arrays

        ; --- message ---
        print_string MESSAGE1

        ; --- call func ---
        lea si, A
        lea di, B
        call COPY_ARRAY

        ; --- message ---
        print_string MESSAGE2
        
        ; --- call func ---
        lea si, B
        call PRINT_ARRAY

        ; ------end programm -------
        mov ah, 4ch 
        int 21h
    MAIN ENDP 

    ; ==== FUNCTIONS ====
    COPY_ARRAY PROC
        ; input:    SI = offset address of the array to be copied
        ;           DI = offset address of the array to copy
        ;           BX = size
        ;
        ; output:   none

        mov cx, bx
        rep movsw
        ; --- exit ---
        ret
    COPY_ARRAY ENDP

    PRINT_ARRAY PROC
        ; input:    SI = offset address of array
        ;           BX = size
        ;
        ; output:   none

        mov cx, bx
        ; --- print brace before array-pring ---
        print_symbol '['
        print_space

        @@PRINT_SYMBOL_LOOP:
            ; --- convert to dec-num from ascii-code ---
            mov ax, 0
            mov ax, [si]
            call PRINT_NUMBER
            print_space
            ; --- change ptr to next ---
            add si, 2
        loop @@PRINT_SYMBOL_LOOP

         ; --- print brace after array-pring ---
        print_symbol ']'
        ; --- exit ---
        ret
    PRINT_ARRAY ENDP

    PRINT_NUMBER PROC
        ; input:    AX = number to convert from ascii-num to dec-num
        ;
        ; output:   none

        ; --- save state ---
        push bx
        push cx
        push dx
        
        ; --- set param: cx - counter, bx - base of decimal
        mov cx, 0
        mov bx, 10
        
        @OUTPUT:
            mov dx, 0

            div bx
            push dx ; remainder; ax - whole from division
            inc cx  ; for next loop

            ; --- if ax == 0, go next, else @OUTPUT ---
            test ax, ax
            jnz @OUTPUT
        
        @@PRINT:
            pop dx
            add dl, 30h
            print_symbol dl
        loop @@PRINT

        ; --- load state ---
        pop dx
        pop cx
        pop bx
        ; --- exit ---
        ret
    PRINT_NUMBER ENDP

END INIT
