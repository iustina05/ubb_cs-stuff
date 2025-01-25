;Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze produsul lor si sa se afiseze in urmatorul format: "<a> * <b> = <result>"
;Exemplu: "2 * 4 = 8"
;Valorile vor fi afisate in format decimal (baza 10) cu semn.
bits 32
global start 
extern scanf, printf,exit
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
a dw 4
b dw 3
format db '%d',0
rezultat dw 0 
mormatr db '%d * %d = %d ',0
segment code use32 class=code
start:
push dword b
push dword format
call[scanf]
add esp,8

push dword a
push dword format
call [scanf]
add esp,8

mov ebx, [b]               
mov eax, [a]                
imul ebx   
                 
mov [rezultat], eax 
push dword [rezultat]
push dword [b]
push dword [a]
push dword mormatr
call [printf]
add esp, 16 

push dword 0
call [exit]
