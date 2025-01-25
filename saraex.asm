bits 32
global start

extern printf, scanf,exit
import printf msvcrt.dll
import scanf msvcrt.dll
import exit msvcrt.dll

segment data use32
    a dd 0
    b dd 0
    c dd 0
    format_s db "a+b-c=%d", 0 
    format db "%d", 0
segment code use32 class=code
start:
    push dword a
    push dword format
    call [scanf]
    add esp, 8  
    
    push dword b
    push dword format
    call [scanf]
    add esp, 8  
    
    push dword c
    push dword format
    call [scanf]
    add esp, 8 
    
    mov eax , 0   
    mov eax , [a]
    mov ebx, 0
    
    mov ebx, [b]
    mov ecx, 0
    mov ecx, [c]
    
    add eax, ebx
    sub eax, ecx
    
    push dword eax
    push dword format_s
    call [printf]
    add esp, 4*2

    push dword 0
    call [exit]
    
    