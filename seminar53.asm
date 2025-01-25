bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf, printf , fprintf, fclose, fopen, fread, fscanf, fwrite; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
import fwrite msvcrt.dll
import fscanf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nf db 'a,txt', 0
    ma db 'r' , 0 
    descript dd 0 
    formats db '%d', 0 
    nr dd 0 
    err db 'eroare la citirea'
; our code starts here
segment code use32 class=code
    start:
        ; ...
    push dword ma
    push dword nf 
    call[fopen] 
    add esp , 4*2
    cmp eax, 0 
    je eroare
    mov [descript], eax 
    mov ebx , 0 
    repeta :
        push dword nr
        push dword formats
        push dword descript
        
        call[fscanf]
        add esp , 4*3
        
        cmp eax, 0 
        je gata_citire
        add ebx , [nr]
        
    jmp repeta 
    gata_citire:
    push EBX
    push dword formats
    call [printf]
    add esp , 4*2
    jmp final 
    eroare:
    push dword err
    call [printf] 
    add esp , 4*1
    
    
    
    
    
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
