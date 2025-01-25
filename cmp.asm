bits 32

segment code use32 public class=code
global cmpLetter

cmpLetter:
    cmp al , 'A'
    jb .final
    cmp al , 'Z'
    jbe .litera_mare
    cmp al , 'a' 
    jb .final
    cmp al, 'z'
    jbe .litera_mica
    
    .litera_mare:
        mov ecx, 1
        ret
    
    .litera_mica:
        mov ecx, 2
        ret
    
    .final:
        mov ecx, 0
        ret