;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de vocale si sa se afiseze aceasta ;valoare. Numele fisierului text este definit in segmentul de date.
bits 32
global start

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

segment data use32 class=data
nume_fisier db "abcde.txt",0
mod_acces db 'r+',0
descriptor dd -1
len equ 100
text times (len+1) db 0
format db 'fisierul are %d vocale', 0
rezultat dd 0

segment code use32 class=code 
start:
push dword mod_acces
push dword nume_fisier
call [fopen]
add esp , 8

mov [descriptor], eax
cmp eax, 0
je fin


        push dword [descriptor]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4  ;dupa apelul functiei fread EAX contine numarul de caractere citite din fisier
        
        mov esi, text
        mov ecx , 0
        
        
        looop:
        cld
        lodsb 
       
        cmp al, 'a'
        je este_vocala
        cmp al , 'e'
        je este_vocala
        cmp al , 'i'
        je este_vocala
        cmp al ,'o'
        je este_vocala
        cmp al , 'u'
        je este_vocala
        cmp al , ' '
        je looop
        cmp al ,0 
        je done
         
        
        
        este_vocala:
        inc ebx
        loop looop
        
        mov [rezultat], ebx
        done:
        
        
        push dword [rezultat]
        push dword format
        call [printf]
        add esp, 8
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
fin:


push dword 0
call[exit]
