bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf, printf , fprintf, fclose, fopen, fread, fscanf, fwrite; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
import fwrite msvcrt.dll
import fscanf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
     nume_fisier db "abcde.txt", 0  ; numele fisierului care va fi creat
     mod_acces db "w", 0          ; modul de deschidere a fisierului 
                                 ; w - pentru scriere. daca fiserul nu exista, se va crea                                   
     descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
     format db '%d ', 0
     sir times 100 db 0      
     n times 100 db 0
     formata db '%[^$]', 0
     literaFlag dd 0
     locSir dd 0
     
;Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura cuvinte pana cand se citeste de la tastatura caracterul '$'. SA SE SCRIE IN FISIER DOAR CUVINTELE CARE CONTIN CEL PUTIN O LITERA MICA (LOWERCASE).
; our code starts here
segment code use32 class=code
    start:
        ;----------------------------------------
        ; apelam fopen pentru a crea fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces     
        push dword nume_fisier
        call [fopen] 
        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        add esp, 4*2                ; eliberam parametrii de pe stiva
        cmp eax, 0                  ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        je final
        
        ;----------------------------------------
        push dword n       
		push dword formata
		call [scanf]       ; apelam functia scanf pentru citire
		add esp, 4 * 2     ; eliberam parametrii de pe stiva
        
        cld
        mov edi, sir
        mov esi, n
        mov ebx, 0
        
    looop:
        mov eax, 0
        lodsb  
        stosb
        
        mov [locSir], edi
        
        cmp al, 'a' ; a=97 in ascii  
        
        jb nu_litera_mica ; jump if below , daca e mai mic de 97 
        cmp al, 'z'
        ja nu_litera_mica ; jump if above, daca e mai mic de 122
        ;-----------------------------------
        litera_mica:
        mov ebx, [literaFlag]
        OR ebx, 1
        mov [literaFlag], ebx
        ;------------------------------------
        nu_litera_mica:
        cmp al, " "
        jne nu_e_spatiu
        ;------------------------------------
        e_spatiu:
        push eax
        
        mov edi, [locSir]
        mov al, 0
        stosb
        mov [locSir], edi
        
        pop eax
        
        cmp [literaFlag], dword 1
        jne cuvant_terminat
        ;-------------------------------------
        a_avut_litera_mica:
        
        push eax
        
        ; print sir
        push dword sir
        push dword [descriptor_fis]
        call [fprintf] ; scriem sirul in fisierul abcde.txt
        add esp, 4 *2
        
        mov [literaFlag], dword 0
        
        pop eax
        ;---------------------------------------
        cuvant_terminat:
        mov [locSir], dword sir
        ;----------------------------------------
        nu_e_spatiu:
        mov edi, [locSir]
        
        cmp eax, 0 ; vedem daca caracterul introdus este ultimul
        jne looop
        ;----------------------------------------
        
        ;----------------------------------------
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        done 
      final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
