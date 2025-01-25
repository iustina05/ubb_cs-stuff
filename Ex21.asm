bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir dw 12345, 20778, 4596
    len_sir equ ($-sir) / 2
    contor db 0
    rez times (len_sir * 4) db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, 0
        mov eax, 0
        mov edx, 0
        
        mov esi, sir
        mov edi, rez
        mov ecx, len_sir
        
        loopy1:
            push ecx
            mov ecx, 5
            mov eax, 0
            mov ax, [esi]
            loopy2:
                mov bx, 10
                div bx
                push dx
                mov dx, 0
                inc byte [contor]
                cmp ax, 0
                je final
            loop loopy2
            final:
            add esi, 2
            mov ecx, 5
            mov ebx, 0
            loopy3:
                dec byte [contor]
                mov eax, 0
                pop ax
                mov [edi], ax
                inc edi
                cmp byte [contor], 0
                je final2
            loop loopy3
            final2:
            pop ecx
        loop loopy1
                
                
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
