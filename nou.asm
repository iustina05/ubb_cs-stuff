bits 32 ; asamblare pentru arhitectura pe 32 de biți

; Declarăm punctul de intrare (o etichetă care definește prima instrucțiune a programului)
global start        
extern exit, scanf, printf, fprintf, fclose, fopen, fread, fscanf, fwrite, cmpLetter ; declarăm funcții externe
import exit msvcrt.dll    ; exit este o funcție care oprește procesul. Este definită în msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
import fwrite msvcrt.dll
import fscanf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
;Se citeste de la tastatura un sir de caractere (litere mici si litere mari, cifre, caractere speciale, etc). Sa se formeze un sir nou doar cu literele mici si un sir nou doar cu literele mari. Sa se afiseze cele 2 siruri rezultate pe ecran.
; Segmentul de date: folosit pentru a defini și stoca datele programului
segment data use32 class=data
    sir times 256 db 0        ; buffer pentru a stoca șirul de intrare
    format db "%s", 0         ; specificator de format pentru scanf
    sir1 times 256 db 0       ; buffer pentru a stoca literele mari
    format1 db "%c", 0        ; specificator de format pentru afișarea unui caracter
    nl db 10, 0               ; caracter pentru linie nouă
    sir2 times 256 db 0       ; buffer pentru a stoca literele mici

; Segmentul de cod: aici încep instrucțiunile programului
segment code use32 public code
    start:
        ; Citirea unui șir de caractere de la tastatură
        cld 
        push dword sir         ; adresa bufferului de intrare
        push dword format      ; specificatorul de format "%s"
        call [scanf]           ; apelăm funcția scanf
        add esp, 4*2           ; eliberăm stiva (2 argumente)
  
        mov esi, sir           ;  șirul de intrare
        mov edi, sir1          ;  litere mari
        mov ebx, sir2          ;  litere mici

       ;__________________________________________________
        looop:
        lodsb                  ; încarcă un octet din [ESI] în AL și avansează ESI
        cmp al, 0              ; verificăm dacă am ajuns la sfârșitul șirului (terminator null)
        je gata                ; sărim la 'gata' dacă terminatorul null a fost găsit

        call cmpLetter         ; apelăm funcția externă cmpLetter
                               ; cmpLetter setează ECX la 1 pentru litere mari și 2 pentru litere mici

        cmp ecx, 1             ; verificăm dacă caracterul este literă mare
        je litera_mare         ; sărim la 'litera_mare' dacă este literă mare
        cmp ecx, 2             ; verificăm dacă caracterul este literă mică
        je litera_mica         ; sărim la 'litera_mica' dacă este literă mică

        jmp looop              ; continuăm bucla pentru alte caractere
        ;__________________________________________________
        
       litera_mica:
        ; Dacă caracterul este literă mică, îl stocăm în sir2
        stosb                  ; stochează AL în [EDI] (indicând sir2)
        jmp looop              ; continuăm procesarea
         ;__________________________________________________
       litera_mare:
        ; Dacă caracterul este literă mare, îl stocăm în sir1
        xchg edi, ebx          ; schimbăm EDI (sir1) cu EBX (sir2)
        stosb                  ; stochează AL în sir1
        xchg edi, ebx          ; restaurăm EDI și EBX
        jmp looop              ; continuăm procesarea

        gata:
        ; Sfârșitul procesării șirului de intrare
        mov al, 0              
        stosb                  
        xchg edi, ebx          
        mov al, 0              
        stosb                  

        ;(șirul cu litere mari)
        push dword sir1        ; punem adresa sir1 pe stivă
        call [printf]          
        add esp, 4             

        
        push dword nl          ; punem adresa pentru newline pe stivă
        call [printf]          
        add esp, 4             

        ;(șirul cu litere mici)
        push dword sir2        ; punem adresa sir2 pe stivă
        call [printf]          
        add esp, 4             

        ; Terminarea programului
        push dword 0           ; punem parametrul pentru exit (0 înseamnă succes)
        call [exit]            ; apelăm funcția exit pentru a termina programul
