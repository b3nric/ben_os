; BIOS doesn't know how to load the OS, that is the job of the boot 
; sector.
; The boot sector must be the first sector of the disk and is 512 
; bytes long. The last to bytes of the sector must be 0xAA55 as the
; BIOS checks this to make sure the boot sector is valid.

; infinte loop (e9 fd ff)
loop:
    jmp loop

; fill the rest of the sector with zero's
; $ evaluates to the assembly position at the beginning of the line
; $$ evaliates to the beginning of the current section
; $ - $$ therefore tells us how far into the section we are
times 510-($-$$) db 0

; magic number
dw 0xaa55