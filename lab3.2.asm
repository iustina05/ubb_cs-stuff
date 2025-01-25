bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;x-(a*100+b)/(b+c-1); a-word; b-byte; c-word; x-qword var cu semn
    a dw -25          
    b db 5           
    c dw 10          
    x dq 100000      
; our code starts here
segment code use32 class=code
    start:
        ; ...

   ; Calculăm a * 100
    mov ax, [a]                     ; Încărcăm a în AX
    mov bx, 100                     ; Încărcăm valoarea 100 în BX
    imul bx                         ; Înmulțire cu semn: AX * 100 -> DX:AX (rezultatul pe 32 de biți)

    ; Mutăm rezultatul complet (DX:AX) în EAX pentru pasul următor
    mov eax, ax                     ; Copiem partea inferioară (AX) în EAX
    shl edx, 16                     ; Mutăm partea superioară (DX) pe poziția corespunzătoare în 32 de biți
    or eax, edx                     ; Combinăm DX:AX în EAX complet

    ; Adăugăm b pentru a obține a * 100 + b
    mov ebx, 0                      ; Curățăm EBX complet
    mov bl, [b]                     ; Încărcăm b în BL (partea superioară rămâne zero)
    add eax, ebx                    ; EAX = a * 100 + b

    ; Calculăm b + c - 1
    mov ecx, 0                      ; Curățăm ECX complet
    mov cl, [b]                     ; Încărcăm b în CL (doar 8 biți, partea superioară rămâne zero)
    mov edx, [c]                    ; Încărcăm c direct în EDX (c este word, deci 16 biți)
    shl edx, 16                     ; Extindem valoarea c la 32 de biți în EDX
    sar edx, 16                     ; Semnează valoarea corectă extinsă în EDX pentru aritmetica cu semn
    add ecx, edx                    ; ECX = b + c
    sub ecx, 1                      ; ECX = b + c - 1

    ; Împărțim (a * 100 + b) la (b + c - 1)
    ; EAX conține valoarea de împărțit, iar ECX conține împărțitorul
    cdq                             ; Extindem EAX la EDX:EAX pentru împărțirea cu semn
    idiv ecx                        ; Împărțire cu semn: EAX = (a * 100 + b) / (b + c - 1)

    ; Salvăm rezultatul împărțirii pentru calcule ulterioare
    mov ebx, eax                    ; Salvăm rezultatul împărțirii în EBX

    ; Încărcăm x (quadword) în EDX:EAX pentru scădere
    mov eax, dword [x]              ; Încărcăm partea inferioară a lui x în EAX
    mov edx, dword [x+4]            ; Încărcăm partea superioară a lui x în EDX

    ; Scădem rezultatul împărțirii din x
    sub eax, ebx                    ; Scădem rezultatul împărțirii din partea inferioară
    sbb edx, 0                      ; Scădem cu împrumut din partea superioară, dacă este necesar

    ; Rezultatul final este în EDX:EAX (64 de biți)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
