; BIOS doesn't know how to load the OS, that is the job of the boot 
; sector.
; The boot sector must be the first sector of the disk and is 512 
; bytes long. The last to bytes of the sector must be 0xAA55 as the
; BIOS checks this to make sure the boot sector is valid.

; http://www.ctyme.com/intr/rb-0106.htm
; the Int10/AH=0Eh interrupt sets the video ouput to tty mode and 
; writes the character currently in AL

mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
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

; fill the rest of the sector with zero's
; $ evaluates to the assembly position at the beginning of the line
; $$ evaliates to the beginning of the current section
; $ - $$ therefore tells us how far into the section we are
times 510-($-$$) db 0

; magic number
dw 0xaa55