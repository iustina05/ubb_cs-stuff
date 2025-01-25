;Sa se citeasca de la tastatura doua numere (in baza 10) si sa se calculeze produsul lor. Rezultatul inmultirii se va salva in ;memorie in variabila "rezultat" (definita in segmentul de date).
bits 32
global start 
extern scanf, printf,exit
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
m dd 0
n dd 0
rezultat dd 0
format0 db '%d',0
format db '%d',0
segment code use32 class=code
start:
push dword m
push dword format0
call[scanf]
add esp,8

push dword n
push dword format0
call [scanf]
add esp,8

mov ebx, [m]               
mov eax, [n]                
mul ebx   
                 
mov [rezultat], eax 
        
push dword [rezultat]       
push dword format          
call [printf]           
add esp, 8

push dword 0
call [exit]