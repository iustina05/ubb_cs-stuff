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

    S1 db  '+', '4', '2', 'a', '8', '4', 'X', '5'
    ls1 equ $-S1
    S2 db 'a', '4', '5'
    ls2 equ $-S2 
    D times ls1+ls2 db 0 
    
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov esi , S1
    mov edi , D 
    mov ecx , ls1 
    jecxz finalS1 ;pregatim s1 
    
    ;CLD ; s--d
    repeta1 :
    mov AL ,[esi]
    mov [edi] , AL 
    inc edi   ; creste cu 1 i++
    add esi , 3 
    sub ecx , 2 
    cmp ecx, 0 
    
    jle iesire ; din primul sir se muta in D el de pe poz multiplu de 3 , int cu semn 
    
    loop repeta1 ; in loop ex o dec deci punem doar sub 2
    
    
    iesire:
    finalS1:
   ; std  ; seteaza direction flag 1 d--s
    mov esi , S2+ls2-1
    mov ecx , ls2
    jecxz finalS2 
    
    repeta2   :
    
    mov AL ,[esi]
    mov [edi], AL 
    dec esi 
    inc edi   
    loop repeta2 ; 
    
    finalS2 :
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
