DOSSEG      ; for MASM | TASM
.MODEL TINY ; memory model. Code, Data, , Stack - in one memory segment <64kb
.STACK 100h
.DATA
    Message DB 13,10,'Hi Hello! ',13,10,'$'
.CODE
MAIN:
    mov ax,@Data

    mov ds,ax   ; pointer to start of data
    mov ah,9    ; ah=9 - special code for output DS:DX, str must terminated by '$'
    mov dx,OFFSET Message

    int 21h     ; 21h interrupt

    ; ------end programm -------
    mov ah, 4ch 
    int 21h
END MAIN