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
;x-(a*100+b)/(b+c-1); a-word; b-byte; c-word; x-qword fara semn
a dw 3
b db 4
c dw 7
x dq 1000
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov ax ,[a]
    mov bx,100
    mul bx ;dx:ax are rez
    mov cl , [b]
    mov ch , 0 
    add ax , cx ; avem a*100+b in ax
    mov bx ,0
    mov bx , [c]
    add bx , cx ;in bx avem b+c
    mov cx , 0 
    mov cx , 1 
    sub bx, cx ; in bx avem b+c-1 
    div bx
    mov ebx , [x]
    mov ecx , [x+4]
    push dx
    push ax 
    pop eax
    sub ebx , eax 
    sbb ecx, 0
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
