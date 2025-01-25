bits 32

segment code use32 public class=code
global _cmpLetter

_cmpLetter:
    push ebp
    mov ebp, esp
    sub esp, 4
    
    mov eax, [ebp+8]
    cmp eax , 'A'
    jb .final
    cmp eax , 'Z'
    jbe .litera_mare
    cmp eax , 'a' 
    jb .final
    cmp eax, 'z'
    jbe .litera_mica
    
    .final:
        mov eax, 0 
        mov esp, ebp
        pop ebp 
        ret
    
    .litera_mare:
        mov eax, 1 
        mov esp, ebp
        pop ebp 
        ret
    
    .litera_mica:
        mov eax, 2 
        mov esp, ebp
        pop ebp 
        ret