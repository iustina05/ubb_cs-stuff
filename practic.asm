;Se citeste de la tastatura un nume de fisier, un caracter special s (orice caracter in afara de litere si cifre) si un numar n reprezentat pe octet. Fisierul contine cuvinte separate prin spatiu. Sa se scrie in fisierul output.txt ultimele n caractere din fiecare cuvant. (Daca numarul de caractere al cuvantului este mai mic decat n, cuvantul se va prefixa cu caracterul special s).

;Exemplu:
;nume fisier:input.txt
;continut fisier: mere pere banane mandarine
;s: +
;n: 6
;output.txt: ++mere ++pere banana darine

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
s dd 0
n dd 0
len equ 100
text times (len+1) db 0 
descriptor_fis db -1
format db '%d', 0
mod_acces db 'r+' , 0
format_af db '%s',0
nume_fis dd 0
format_s db '%c', 0
rezultat dd 0
len_cuv db 0
rezultat1 db 0
mess_input db '>>>', 0

segment code use32 class=code 
start:
push dword s
push dword format_s
call [scanf]
add esp , 8  
mov edx, s  ; inroducem s la tastatura
;-------------------------------------------------

push dword n
push dword format
call [scanf]
add esp, 8 
mov ebx, n  ; introducem n la tastatura
;------------------------------
push dword mess_input
call [printf]
add esp,4


;-----------------
push dword nume_fis
push dword format_af
call[scanf]
add esp , 8
; citim numele fisierului



push dword mod_acces
push dword nume_fis
call [fopen]
add esp, 8  ;deschidem fisierul

mov [descriptor_fis],eax
;--------------------------------------------------
push dword [descriptor_fis]
push dword len
push dword 1
push dword text
call [fread]
add esp, 4*4 ; citim continutul fisierului
;---------------------------------------------------

mov esi, text
mov ecx, 0

verif_cuv:
    std
    lodsb
    cmp al , 'a'
    JB este_altceva ; daca e mai mic de 97 cod ascii este altceva( nu litera)
    cmp al , 'z'
    JA este_altceva ; daca este mai care 122 cod ascii este altceva (nu litera)
    
    cmp al, ' ' ; comparam sa nu fie spatiu ,daca e spatiu , inseamna ca am citit un cuv intreg 
    je adauga_s 
    cmp eax ,n 
    jb adauga_s
    ja avem_cuvant_mai_mare
    ;-------------------------------------------------
    adauga_s:
    add eax, s
    cmp eax,n
    je avem_un_cuvant_complet
    
    ;--------------------------------------------------
    cmp esi, 0
    je done ; daca nu mai sunt caractere in esi sarim la sfarsit
    
    avem_cuvant_mai_mare:
    cld
    dec eax
    cmp eax , n
    ja avem_cuvant_mai_mare
    je avem_un_cuvant_complet
    avem_un_cuvant_complet:
    mov [rezultat], eax
    push dword [rezultat]
    push dword [descriptor_fis]
    call [fprintf]
    
    loop verif_cuv ;dupa ce printam ultimul cuvant citit refacem loop
    
    este_altceva:
    jmp verif_cuv
done:    
push dword [descriptor_fis]
call [fclose]
add esp, 4

push dword 0
call [exit]





