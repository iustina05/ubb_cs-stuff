bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll

; our data is declared here (the variables needed by our program
section .data
    s2 db '123123456', 0        ; Sirul original: "123123456"
    s2_subsir db '123', 0        ; Subsirul de cautat: "123"
    destinatie db 10 , 0      ; Sirul modificat, initializat cu zero

; our code starts here
section .text
    start:
        ; Incarcam adresele pentru s2 si destinatie
        mov esi, s2              ; ESI pointeaza la inceputul sirului original (s2)
        mov edi, destinatie      ; EDI pointeaza la inceputul sirului modificat (destinatie)
        mov edx, s2_subsir       ; EDX pointeaza la inceputul subsirului "123"

        ; Setam directia de parcurgere a sirului: DF=0 (parcurgere de la adrese mici la mari)
        cld                       

    cauta_subsir:
        ; Comparăm sirul original cu subsirul
        mov al, [esi]             ; Încarcă caracterul curent din s2
        cmp al, [edx]             ; Compară cu primul caracter din subsir
        jne nu_gasit              ; Dacă nu se potrivește, continuăm cu următorul caracter

        ; Dacă găsim prima literă, verificăm restul subsirului
        inc esi
        inc edx
        mov al, [esi]             ; Încarcă al doilea caracter din s2
        cmp al, [edx]             ; Compară cu al doilea caracter din subsir
        jne nu_gasit
        inc esi
        inc edx
        mov al, [esi]             ; Încarcă al treilea caracter din s2
        cmp al, [edx]             ; Compară cu al treilea caracter din subsir
        jne nu_gasit
        
        ; Daca am gasit subsirul, sarim peste el
        add esi, 3                ; Sari peste subsirul de 3 caractere
        jmp cauta_subsir          ; Continuăm căutarea în restul sirului

    nu_gasit:
        ; Daca nu am gasit subsirul, copiem caracterul în destinatie
        mov al, [esi]             ; Încarcă caracterul curent din s2
        mov [edx], al             ; Salvează-l în destinatie
        inc esi                   ; Mergem la următorul caracter din s2
        inc edx                   ; Mergem la următoarea poziție din destinatie
        cmp byte [esi], 0         ; Verificăm dacă am ajuns la sfârșitul sirului original
        jne cauta_subsir          ; Continuăm căutarea

        ; După ce am terminat, apelăm exit pentru a termina programul
        push dword 0              ; Parametru pentru exit (cod de ieșire 0)
        call [exit]               ; Apelăm funcția exit
