bits 32 ;asamblare și compilare pentru arhitectura de 32 biți
; definim punctul de intrare in programul principal
global start

; declaram functiile externe necesare programului nostru 
extern exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import exit msvcrt.dll  ; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante

; segmentul de date in care se vor defini variabilele 
segment data use32 class=data
; ... 
a dw 3
b dw 6
c dw 6
d dw 10
; segmentul de cod
segment code use32 class=code
start:
; ... 
;(d-c)+(b+b-c-a)+d
mov eax, [d]
mov ebx, [c]
sub eax, ebx ;  d-c
push eax ; salvam rex pe stiva
mov eax, [b]
mov ebx,[b]
add eax, ebx ; in eax b+b
mov ebx, [c]
sub eax, ebx ; in eax acum 2b-c
mov ebx,[a]
sub eax, ebx; 2b-c-a
mov ebx, eax
pop eax ; aducem in eax primul rez
add eax, ebx
mov ebx, [d]
add eax, ebx
    ; exit(0)
    push dword 0 ; se pune pe stiva parametrul functiei exit
    call [exit] ; apelul functiei exit pentru terminarea executiei programului
    ; asta merge