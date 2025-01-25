;Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze a/b. Catul impartirii se va salva in memorie ;in variabila "rezultat" (definita in segmentul de date). Valorile se considera cu semn.

bits 32
global start
extern scanf,printf,exit
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
a dd 0
b dd 0
format db'%d',0
rezultat dd 0 ;catul

segment code use32 class=code
start:
mov eax,0
mov ebx,0
push dword a
push dword format
call [scanf]
add esp,8

push dword b
push dword format
call [scanf]
add esp, 8

mov eax, [a]
cdq
mov ebx, [b]
idiv ebx 
mov [rezultat],eax


push dword [rezultat]
push dword format
call [printf]
add esp, 8

push dword 0 
call [exit]