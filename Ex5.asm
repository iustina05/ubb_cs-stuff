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
    s1 db 7, 33, 55, 19, 46
    ls1 equ ($-s1)
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46
    ls2 equ ($-s2)
    const db 0
    d times ls2 db 0
        
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        mov edi, 0
        mov esi, 0
        
        mov edi, s2
        mov ecx, ls2
        mov eax, d

        loopy1:
            push ecx
            mov bl, [edi]
            mov ecx, ls1
            mov esi, s1
            mov byte [const], ls1
            inc byte [const]
            loopy2:
                cmp bl, [esi]
                je adding
                mov byte [eax], 0
                inc esi
            loop loopy2
            cmp ecx, 0
            je skip
            adding:
                sub byte [const], cl
                mov byte bl, [const]
                mov [eax], bl
            skip:
            inc edi
            inc eax
            pop ecx
        loop loopy1
            
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
