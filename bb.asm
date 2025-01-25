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
    e dw 9
    g dw 5
    h dw 2
    c dw 3
    b dw 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov ax, [e]
    add ax, [g]
    sub ax, [h]
    mov bx, 3
    div bx
    mov bx, [b]
    mov cx, [c]
    mul cx
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
