;
; Print a hexidecimal value as an ASCII string
;
; Parameters:
; - DX: 16-bit hexadecimal value
;
print_hex:
    mov cx, 0 ; i = 0

ph_start:
    cmp cx, 4
    je ph_end

    mov ax, dx ; we need a working register so we don't ruin the value in dx
               ; as we work on the hex value
    and ax, 0x000f ; mask the first three values to 0's, if ax was 0x1234 then
                   ; ax   ->  0001 0010 0011 0100 = 0x1234
                   ; mask ->  0000 0000 0000 1111 = 0x000f
                   ; and  ->  0000 0000 0000 0100 = 0x0004
    ;
    ; int  hex  ASCII
    ; 48   0x30  0
    ; 57   0x39  9
    ; 97   0x61  a
    ; 102  0x66  f
    ;
    add al, 0x30 ; convert 0x0 - 0x9 to ASCII by adding 0x30
    cmp al, 0x39 
    jle ph_setup ; if the result is larger than 0x30 we have a-f
    add al, 39  ; the result of 0xa + 0x30 = 0x3a = 58
                ; a(97) - 0x3a(58) = 39
                ; so to convert to ASCII we need to add 39

ph_setup:
    mov bx, OUT + 5 ; pointer to the end of OUT
    sub bx, cx ; subtract i
    mov [bx], al 
    shr dx, 4 ; shift right 4 bits 0x1234 -> 0x0123

    add cx, 1 ; i++
    jmp ph_start

ph_end:
    mov bx, OUT
    call print_string
    ret

OUT:
db '0x0000', 0 ; reserve enough memory for a 16-bit ascii value