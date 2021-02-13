; BIOS (Basic Input/Output Software) is a collection of software routines loaded 
; from a chip into memory. It Performs some hardware checks then must boot the 
; OS. BIOS doesn't know how to load the OS that is the job of the boot sector.
;
; The boot sector must be the first sector of the disk and is 512 bytes long. 
; The last to bytes of the sector must be 0xAA55 as the BIOS checks this to make 
; sure the boot sector is valid.
;
; An interrupt allows CPU to halt and run some other instructions before 
; returning. Physical address 0x0 contains a table of address pointers to 
; Interrup Service Routines (ISRs).

; print 'Hello, World'
mov ah, 0x0e
mov al, 'H'
int 0x10                    
mov al, 'e'
int 0x10                    ; int10/ah=0eh interrup which sets the video ouput
                            ; to TTY and writes the character found in AL
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10
mov al, ','
int 0x10
mov al, ' '
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10
mov al, '!'
int 0x10

; infinte loop
jmp $                       

; padding and magic number
times 510-($-$$) db 0       ; $ evaluates to the assembly position at the 
                            ; beginning of the line and $$ evaliates to the 
                            ; beginning of the current section
dw 0xaa55