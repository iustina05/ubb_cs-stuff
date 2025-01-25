;Se dau doua numere naturale a si b (a, b: dword, definite in segmentul de date). Sa se calculeze suma lor si sa se afiseze in ;urmatorul format: "<a> + <b> = <result>"
;Exemplu: "1 + 2 = 3"
;Valorile vor fi afisate in format decimal (baza 10) cu semn.
bits 32
global start 
extern scanf, printf,exit
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
a dd 0
b dd 0
format db '%d',0
rezultat dd 0 
mormatr db '%d + %d = %d ',0
segment code use32 class=code
start:
push dword a
push dword format 
call [scanf]
add esp ,8

push dword b
push dword format 
call [scanf]
add esp ,8 

mov eax, [a]
mov ebx, [b]
adc eax,ebx
mov [rezultat], eax 

push dword [rezultat]
push dword [b]
push dword [a]
push dword mormatr
call [printf]
add esp, 16

push dword 0
call [exit]
