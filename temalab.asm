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
    a dq 1234123412341234h ; 00010010001101000001001000110100000100100011'010'00001001000110100b
    b dd 0
    c db 0 
    n db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov eax , [a]
    mov ebx , 000E0000h ; izoleaza bitii 17-19
    and ebx , eax 
    ror ebx , 17 ; in bl este N
    mov cl  , bl 
    mov eax ,[a+4] ; in eax este dumblu cuvantul sup a lui a
    rol eax , cl  ; eax=48D048D0h = B B=0100100'01101'00000100'100'011010000
    ; obtinerea lui b
    
    mov ebx , 00000E00h  ; izoleaza 9-11
    ror ebx , 9 ; devin bitii 0-2 din c 
    ; prima parte c 
    
    mov edx , 01F00000h ; izoleaza 20-24
    and edx , eax 
    ror edx , 17 ; muta pe 3-7 
    or ebx , edx ; rezultatul v a fi in ebx 
    
    
    
    
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
