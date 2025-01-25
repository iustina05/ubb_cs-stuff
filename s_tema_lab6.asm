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
;Se dau doua siruri de octeti s1 si s2. Sa se construiasca sirul de octeti d, care contine pentru fiecare octet din s2 pozitia sa in s1, sau 0 in caz contrar.
;pos: 1, 2, 3, 4, 5 
;s1: 7, 33, 55, 19, 46
;s2: 33, 21, 7, 13, 27, 19, 55, 1, 46 
;d: 2, 0, 1, 0, 0, 4, 3, 0, 5

    s1 db 7, 33, 55, 19, 46
    l1 equ $-s1 ;lungimea sirului s1
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46
    l2 equ $-s2 ;lungimea sirului s2
    d times l2 db 0 ;sirul d declarat aceeasi lungime ca s2
    
; our code starts here
segment code use32 class=code
start:
    MOV ECX,l2  ;punem in ECX lungimea sirului s2 pentru a-l parcurge
    JECXZ final
    MOV ESI, s2 ;punem in ESI offset-ul sirului s2
    MOV EBX, d  ;punem in EBX offset-ul sirului d
    CLD         ;setam directia de parcurgere spre dreapta
    incepe_cautarea:
        LODSB   ;punem in AL primul octet din s2
        PUSH ECX;pastram pe stiva valoarea din ECX
        MOV EDI, s1 ;punem in EDI offsetul sirului s1
        MOV ECX, l1 ;pune in ECX lungimea sirului s1
        caut:
            SCASB   ;compar valoarea din AL cu primul octet de la stanga din s1
            JE gasit;daca sunt egale valorile iese din loop
        LOOP caut
        gasit:
        
        ;ADD EAX, l1-ECX+1        
        MOV EAX, l1 ;calculeaza pozitia la care se afla in sir valoarea cautata
        SUB EAX, ECX
        INC EAX     ;incrementam pentru a include indexarea de la 1
                    ;pos: 1, 2, 3, 4, 5 
        
        ;COMPAR EAX CU L1 IF_EQUAL MAKE IT ZERO
        CMP EAX, (l1+1) ;adunam +1 la l1 pentru a lua in considerare si indexarea de la 1
        JNE skip    ;daca nu sunt egale trece peste
        MOV EAX, 0  ;daca sunt egale o face 0
        skip:
        
        ;PUN PE URM POZITIE DIN D POZITIA GASITA IN S1 A VALORII DIN S2
        MOV [EBX], AL
        INC EBX
        POP ECX
    LOOP incepe_cautarea
    final:
    
    ; exit(0)
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
