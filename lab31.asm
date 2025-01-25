bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;c+d-a-b+(c-a) ...
    a db -5        ; a este un byte (8 biți, cu semn)
    b dw -2          ; b este un word (16 biți, cu semn)
    c dd 50      ; c este un doubleword (32 biți, cu semn)
    d dq 15        ; d este un quadword (64 biți, cu semn)

; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov al ,[a]
    cbw
    cwde; apare in eax acuma 
    mov ebx ,[c]
    sub ebx,eax ;ebx=c-a
    push ebx
    mov ecx , 0
    mov ecx ,[c]
    cdq
    add ecx, [d] ;ecx=c+d 65
    adc edx, [d+4]  ;edx:ecx avem rezultatulw
    mov  al,[a]
    cbw
    cwde 
    sub ecx, eax ; 70
    mov eax ,0    
    mov ax ,[b]
    cwde
    sub ecx, eax
    pop ebx
    add ecx,ebx
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
