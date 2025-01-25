section .bss
    num resb 10       ; buffer pentru numărul citit
    max resd 1        ; pentru valoarea maximă

section .text
    global _start

_start:
    ; Inițializare - setează valoarea maximă la 0
    mov dword [max], 0

read_input:
    ; Citește un caracter de la tastatură
    mov ah, 01h        ; serviciul de citire caracter
    int 21h            ; întreruperea pentru citire
    mov al, dl         ; caracterul citit în AL

    ; Verifică dacă este 0 (terminare)
    cmp al, '0'
    je done            ; dacă este 0, încheie programul

    ; Convertește caracterul în valoare numerică
    sub al, '0'        ; convertește caracterul în valoare numerică

    ; Împinge valoarea pe numărul curent
    mov bl, [num]      ; încarcă valoarea anterioară
    imul bl, bl, 10    ; mută valoarea anterioară la stânga
    add bl, al         ; adaugă cifra curentă

    mov [num], bl      ; salvează numărul curent în buffer

    ; Compară numărul curent cu valoarea maximă
    mov eax, [num]     ; încarcă numărul curent în eax
    mov ebx, [max]     ; încarcă valoarea maximă în ebx
    cmp eax, ebx       ; compară
    jle no_update_max  ; dacă nu este mai mare, nu actualiza

    ; Dacă numărul curent este mai mare, actualizează valoarea maximă
    mov [max], eax

no_update_max:
    ; Mergi la citirea următorului număr
    jmp read_input

done:
    ; Afișează rezultatul (maximul)
    mov eax, [max]     ; încarcă valoarea maximă în eax
    call print_number  ; afișează valoarea maximă

    ; Termină programul
    mov ah, 4Ch        ; codul de terminare a programului
    int 21h            ; întreruperea pentru terminare

print_number:
    ; Afișează un număr înregistrat în eax
    ; Se presupune că eax conține numărul de afișat
    mov ebx, 10        ; divisor pentru a obține cifrele
    xor ecx, ecx       ; numărul de caractere

reverse_loop:
    xor edx, edx       ; curăță restul
    div ebx            ; împarte eax la 10
    add dl, '0'        ; convertește restul într-un caracter
    push dx            ; pune cifra pe stivă
    inc ecx            ; crește contorul de caractere
    test eax, eax      ; verifică dacă eax este 0
    jnz reverse_loop   ; continuă până când eax devine 0

print_loop:
    pop dx             ; ia cifra de pe stivă
    mov ah, 02h        ; serviciul de scriere caracter
    int 21h            ; întreruperea pentru a afișa caracterul
    loop print_loop    ; afișează toate caracterele

    ret
