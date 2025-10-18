org 0x7C00

%define ENDL         0x0A
%define VIDEO        0x10
%define KEYBOARD     0x16

%macro PRINTB 2
    mov SI, %1
    %%loop:
        lodsb            
        or AL, AL          
        jz %%done
        mov AH, 0x0E
        int VIDEO
        jmp %%loop
    %%done:
        %if %2 == 1
            mov AH, 0x02
            inc DH
            mov DL, 0
            int VIDEO 
        %endif
%endmacro

%macro PRINTS 1 
    %%loop:
        pop AX              
        mov AH, 0x0E
        int 0x10
        cmp SP, 0x7C00
        jne %%loop
        %if %1 == 1
            mov AH, 0x02
            inc DH
            mov DL, 0
            int VIDEO 
        %endif
%endmacro

%macro SCAN 0
    %%loop:
        mov AH, 0x00
        int KEYBOARD
        cmp AL, 0x0D
        jz %%done
        push AX
        mov AH, 0x0E
        int VIDEO
        jmp %%loop
    %%done:
        mov AH, 0x02
        inc DH
        mov DL, 0
        int VIDEO
%endmacro

main:
    mov SP, 0x7C00
    mov AX, 0x03       
    int VIDEO                ; clear the screen by refreshing video mode
    .loop:
        PRINTB ask, 1
        SCAN
        PRINTB welcome, 0
        PRINTS 0
        PRINTB exmark, 1
        jmp .loop
    
       

ask: db "Enter your name: ", 0
welcome: db "HELLO, ", 0
exmark: db "!", 0

times 510 - ($-$$) db 0
dw 0xAA55
