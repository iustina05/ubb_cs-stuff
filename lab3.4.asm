bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...x-(a*100+b)/(b+c-1)
a dw 3
b db -4
c dw 7
x dq 1000
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov ax ,[a]
    imul 100 ;dx:ax are rez
    mov bx ,ax
    mov al , [b]
    cbw
    add ax , bx ; avem a*100+b in ax
    mov bx ,0
    mov bx , [c]
    add bx , ax ;in bx avem b+c
    dec bx 
    mov ax,bx
    cwd
    idiv bx
    mov ebx , [x]
    mov ecx , [x+4]
    push dx
    push ax 
    pop eax
    cdq
    sub ebx , eax 
    sbb ecx, edx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
