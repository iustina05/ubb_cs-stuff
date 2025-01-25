bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern concat
extern exit ,scanf,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll                 ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
global start
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
a db 'abcdef', 0 
 la equ $-a-1
b db '0123', 0 
 lb equ $-b-1
r times la+lb+1 db 0 
; our code starts here
segment code use32 class=code public
    start:
        ; ...
    push dword lb 
    push dword b 
    push dword la
    push dword a
    push dword r 
    call concat
    
    push dword r 
    call [printf]
    add esp , 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
