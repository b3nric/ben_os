;
; Read the disk beginning after the boot sector
;
; Parameters:
; - DH: number of sectors to read
; - DL: drive to read from
; - ES:BX: pointer at which to store data read from disk
;
read_disk:
    push dx ; store on the stack so we can retieve dh later as 
            ; int13/ah=02h requires dh to be set

    mov ah, 0x02 ; int13/ah=02h read sector
    mov al, dh ; number of sectors to read
    mov ch, 0x00 ; cylinder 0
    mov dh, 0x00 ; head 0
    mov cl, 0x02 ; start at the second sector (after the boot sector)
    int 0x13

    jc disk_error ; if the carry flag was set, there was an error

    pop dx
    cmp dh, al ; al is set by int13/ah=02h to the number of sectors
               ; read by the BIOS
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG: db "There was an error reading the disk.", 0