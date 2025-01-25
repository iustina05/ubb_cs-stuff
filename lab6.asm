bits 32
global start

extern exit
import exit msvcrt.dll

; segmentul de date in care se vor defini variabilele 
segment data use32 class=data

; Dandu-se un sir de octeti si un subsir al sau, sa se elimine din primul
; sir toate aparitiile subsirului. 

a db '1', '5', '3', '4', '9', '5', '3', '9', '0', '4', '7', '5', '3', '8', '5'
la equ $-a
b db '5', '3'
lb equ $-b

; segmentul de cod
segment code use32 class=code

start:
    mov esi, a
    mov ecx, la
    
    cld
    
    jecxz fin
    
    looop:
        push ecx
        push esi
        
        ; pentru urmatoarele lb caractere
        ; comparam din A cu B
        mov ecx, lb
        mov edi, b
        
        mov edx, 1      ; scadere din index pentru eliminare
        mov ebx, 0      ; scadere din lungime pentru eliminare
        
        looopSubsir:
            lodsb   ; AL <- [ESI]
            scasb   ; AL == [EDI]
 ; comparam el din a cu cele din b (el din al cu cele din edi  )         
            jne endLoop
            
            loop looopSubsir
        
        eliminareSubsir:
            mov edx, 0      ; nu mai avansam ESI initial
            mov ebx, lb     ; eliminam ce am eliminat
            sub ebx, 1
            
            mov ecx, la     ; eliminam pentru o lungime de
                            ; (lungime sir - pozitie curenta + start sir)
            sub ecx, esi
            add ecx, a
            
            ; ESI = Pozitia curenta in a
            ; EDI = ESI initial
            pop edi
            push edi
            
            looopElim: ;elimina elemente ia de pe pozitii mai mari le muta mai in fata , sterge ce  a ramas
                lodsb 
                stosb
                loop looopElim
            
            
        
        endLoop:
            pop esi
            pop ecx
        
            add esi, edx
            sub ecx, ebx
            loop looop
    
fin:    
    ; exit(0)
    push dword 0
    call [exit]