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

;
; A boot sector that prints strings and hex
;
[org 0x7c00] ; tell the assembler where this code will be loaded

mov bx, HELLO_MSG ; print_string expects a pointer to a string in BX
call print_string

mov dx, 0x1234 ; print_hex expects a hex value in DX
call print_hex

mov bx, GOODBYE_MSG
call print_string

jmp $ ; hang

%include "routines/print_hex.asm"
%include "routines/print_string.asm"

; Data
HELLO_MSG:
db 'Hello, World!', 0x0a, 0x0d, 0 ; strings need to be null terminated

GOODBYE_MSG:
db 0x0a, 0x0d, 'Goodbye!', 0

; Padding and magic number.
times 510-($-$$) db 0
dw 0xaa55