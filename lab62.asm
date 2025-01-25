bits 32                 ; Assembling for 32-bit architecture

; Declare the EntryPoint (the first instruction of the program)
global start        

; Declare external functions needed by our program
extern exit               ; exit function is declared externally
import exit msvcrt.dll    ; exit is defined in msvcrt.dll

; Data section where the strings are defined
segment .data use32 class=data
    s db '1','2','3','4','5','6','1','2','3', 0  ; Original string
    d db '1','2','3', 0                         ; Substring to search for
    l equ $ - s                                  ; Length of the original string

; Code section where the logic resides
segment .text use32 class=code
    start:
        ; Load length of string s into ecx
        mov ecx, l        
        jecxz final          ; If the string is empty, exit

        ; Initialize esi (pointer to the start of the string s)
        mov esi, s            ; ESI points to the start of string s

        ; Initialize edi (pointer to the start of substring d)
        mov edi, d            ; EDI points to the start of substring d

        ; Set up loop variables
        mov edx, 0            ; We will use edx as an index into the string s

    loop_start:
        ; Check if the current character matches the first character of the substring
        mov al, [esi + edx]   ; Load the current character of s into al
        cmp al, [edi]         ; Compare it with the first character of d
        jne no_match          ; If not equal, continue checking the next character in s

        ; Check if the entire substring d matches from the current position in s
        push edx              ; Save current position in s
        mov ecx, 3            ; We know the length of d is 3
        mov ebx, edi          ; Load address of substring d
        mov edx, 0            ; Initialize to track position in s
        
    check_substring:
        mov al, [esi + edx]   ; Load current character of s
        cmp al, [ebx + edx]   ; Compare it with the corresponding character in d
        jne no_match          ; If not equal, break the match check
        inc edx               ; Move to the next character in s and d
        loop check_substring  ; Loop through all characters of d

        ; If we are here, the substring d was found, so skip it
        add edx, 3            ; Skip past the substring (advance edx by length of d)
        jmp loop_start        ; Continue the loop from the next position

    no_match:
        ; If no match, move the current character to the new position
        ; We need to move characters to fill the space left by the "deleted" substring
        mov al, [esi + edx]   ; Load current character of s
        mov [esi], al         ; Place it at the beginning (overwrites previous position)
        inc edx               ; Move to the next character in s
        inc esi               ; Advance esi by one to update the position
        cmp byte [esi], 0     ; Check if we reached the end of the string
        jne loop_start        ; If not, continue the loop

    final:
        ; Exit the program with a return code of 0
        push dword 0           ; Push parameter for exit (return code 0)
        call [exit]            ; Call the exit function from msvcrt.dll
