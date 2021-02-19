;
; Print a string to tty.
;
; Parameters:
; - BX: pointer to a null terminated string
;
print_string:

ps_start:
    mov al, [bx] ; move the contents of bx into al ready to be
                 ; printed

    cmp al, 0 ; check for end of the string
    je ps_end

    mov ah, 0x0e ; int10/ah=0eh -> tty
    int 0x10

    add bx, 1 ; increment and loop over
    jmp ps_start

ps_end:
    ret