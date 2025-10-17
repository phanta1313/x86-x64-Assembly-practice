org 0x7C00

%define ENDL         0x0A
%define VIDEO        0x10
%define KEYBOARD     0x16

%macro PRINTS 1
    mov si, %1
    %%loop:
        lodsb            
        or al, al          
        jz %%done
        mov ah, 0x0E 
        int VIDEO
        jmp %%loop
    %%done:
        mov ah, 0x02
        inc dh
        mov dl, 0
        int VIDEO            ; move cusror down and left
%endmacro

%macro SCANS 0
    %%loop:
        mov ah, 0x00
        int 0x16
        cmp al, 0x0D
        jz %%done
        mov ah, 0x0E
        int VIDEO
        jmp %%loop
    %%done:
        mov ah, 0x02
        inc dh
        mov dl, 0
        int VIDEO
%endmacro

main:
    mov ax, 0x03       
    int VIDEO                ; clear the screen by refreshing video mode
    SCANS
    PRINTS ok
    
    hlt   

ok: db "Ok."

times 510 - ($-$$) db 0
dw 0xAA55
