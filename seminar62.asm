bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)        

; declare external functions needed by our program
extern factorial
extern exit ,scanf,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll                 ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
global start  
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
n dd 0 
format db '%u'
; our code starts here
segment code use32 class=code public
    start:
        ; ...
    push dword n 
    push dword format
    call [scanf]
    add esp, 8
    push dword [n]
    call factorial 
    push eax
    push format 
    call [printf]
    add esp , 8 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
