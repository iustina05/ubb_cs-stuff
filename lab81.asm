bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    n dd 0
   f db '%d', 0           
   fp db '%d', 0  
   max dd 0
;Se citesc de la tastatura numere (in baza 10) pana cand se introduce cifra 0. Determinaţi şi afişaţi cel mai mare număr dintre cele citite.
     
; our code starts here
segment code use32 class=code
    start:
        ; ...
    looop:
    push dword n                  ; Salvăm valoarea actuală a lui n pe stivă
    push dword f                  ; Formatul pentru citire "%d"
    call [scanf]                  ; Apelăm scanf pentru a citi numărul
    add esp, 8                    ; Eliberăm spațiul de pe stivă
    
    
    cmp dword [n], 0                    
    je done
    
    ;comparam numarul citit cu val max
    mov ebx, [n]                   ; Copiem numărul citit în ebx
    cmp ebx, [max]                 ; Compară cu valoarea maximă
    jle no_update_max              ; Dacă nu este mai mare, sărim peste actualizare

    mov [max], ebx                 ; Actualizăm valoarea maximă
    
    no_update_max:
    ; Continuă citirea
    jmp looop

    done:
    ; Afișează rezultatul (valoarea maximă)
    push dword [max]                ; Stocăm valoarea maximă pe stivă
    push dword fp                   ; Formatul pentru afișare
    call [printf]                   ; Apelăm printf pentru a afisa rezultatul
    add esp, 8                      ; Eliberăm spațiul de pe stivă

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
