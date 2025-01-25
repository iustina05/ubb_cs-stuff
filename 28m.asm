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
b dw 3
c dw 3
e dw 20
g dw 10
h dw 6
; our code starts here
segment code use32 class=code
start:;(e+g-h)/3+b*c
mov eax, [e]
mov ebx, [g]
add eax, ebx;in eax e+g
mov ebx, [h] 
sub eax, ebx;in eax deimpartitul

mov ecx, 0;pregatim pt impartire
mov edx, 0;
mov ecx,3;impartitorul
div cx; in eax rez fractiei, in edx restul

push eax;salvam rez pe stiva
mov eax,[b]
mov ebx, [c]
mul ebx; in eax b*c
mov ebx, eax; in ebx b*c

pop eax 
add eax, ebx; rez final in eax

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
; asta merge