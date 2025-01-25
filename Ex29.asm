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
    s1 db 2d, 3d, 4d
    l1 equ ($-s1)
    s2 db 6d, 2d, 8d, 9d, 10d, 12d
    l2 equ ($-s2)
    cont db l1
    cont1 db 0
    cont2 db 0
    rez times l2 db 0
   
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        mov edi, 0
        mov esi, 0
        
        mov esi, s1
        mov edi, s2
        mov edx, rez
        
        mov ecx, l2
        
        loopy:
            sub cl, [cont]
            push ecx
            cmp byte [cont], 0
            je skip
            mov ecx, l1
            loopy2:
                mov al, [edi]
                cmp [esi], al
                jae put_esi
                cmp al, [esi]
                ja put_edi
                
            put_esi:
                mov al, [esi]
                mov [edx], al
                inc edi
                inc esi
                inc edx
                dec byte [cont]
                loop loopy2
            put_edi:
                mov al, [edi]
                mov [edx], al
                inc edi
                inc esi
                inc edx
                dec byte [cont]
                loop loopy2
            skip:
            mov byte bl, [cont1]
            cmp bl, [cont2]
            je put_1
            
            inc byte [cont2]
            mov byte [edx], 0
            inc edx
            
            jmp skip2
            put_1:
                inc byte [cont1]
                mov byte [edx], 1
                inc edx
            skip2:
            pop ecx
        loop loopy 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
