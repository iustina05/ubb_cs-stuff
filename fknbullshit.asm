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
    a dq 7777777777777777h ; quadword-ul A (64 biti)
    b dd 0                  ; B (cuvânt de 32 de biti)
    c db 0                  ; Octetul C
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov eax, [a]            ; incarcam partea inferioara a lui A în eax
    shr eax, 17             ; mutam bitii 17-19 pe pozitiile 0-2
    and eax, 00000007h      ; izolam acesti 3 biti (0x07)
    mov ecx, eax            ; stocam valoarea N în ecx (acesta va fi numarul de pozitii pentru rotire)
    mov edx, [a+4]          ; incarcam partea superioara a lui A (următorii 32 de biti)
    rol edx, cl
    mov [b], edx 
    mov eax, [b]            ; incarcam B în eax
    shr eax, 9              ; mutam bitii 9-11 pe pozitiile 0-2
    and eax, 00000007h      ; izolam acești 3 biti
    mov dl, al              ; stocam acesti biti în dl (octetul C)
    mov [c], dl  
    mov eax, [b]            ; incarcam din nou B în eax
    shr eax, 20             ; mutam bitii 20-24 pe pozitiile 0-4
    and eax, 0000001Fh      ; izolam acești 5 biti (0x1F)
    shl eax, 3              ; mutam acești biti în pozitiile 3-7
    or dl, al
    mov [c], dl             ;rezultatul ar trebui sa fie in dl 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
