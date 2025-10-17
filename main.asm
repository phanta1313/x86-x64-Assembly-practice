org 0x7C00

%define ENDL    0x0A

%macro PRINTS 1
    mov si, %1
    %%loop:
        lodsb            
        or al, al          
        jz %%done
        mov ah, 0x0E 
        int 0x10
        jmp %%loop
    %%done:
        mov ah, 0x02
        inc dh
        mov dl, 0
        int 0x10            ; move cusror down and left

%endmacro

main:
    mov ax, 0x03       
    int 0x10                ; clear the screen by refreshing  video mode
 
    PRINTS s1
    PRINTS s2
    PRINTS s3
    PRINTS s1
    jmp $              

s1 db "Hello, world!", 0
s2 db "string2", 0
s3 db "DSHUAKDHsao", 0

times 510 - ($-$$) db 0
dw 0xAA55
