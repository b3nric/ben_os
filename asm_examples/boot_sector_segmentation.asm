mov ah, 0x0e 

mov al, [the_secret]
int 0x10 ; as we know, this won't print because the label is offset from 
         ; 0x0000 not 0x7c00 (where the boot sector is loaded)

mov bx, 0x7c0
mov ds, bx ; ds is the data segment register which is used as an offset to
           ; the data segment
           ; ds can't be set directly to 0x7c00 so we must first set bx to 
           ; 0x7c0 and when we move this into ds it will automatically be 
           ; left shifted 4 bits to 0x7c00
mov al, [the_secret]
int 0x10 ; this will print X because X is part of the data segment, which using
         ; ds, we are saying is indexed from 0x7c00

mov al, [es:the_secret] ; tell CPU to use es instead of ds for this instruction
int 0x10 ; this won't print because we haven't set anything meaningful in es

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10 ; this will print X because we are setting es and then indexing from
         ; it

jmp $

the_secret:
    db "X"

new_line:
    db 0x0a, 0x0d, 0

%include "routines/print_hex.asm"
%include "routines/print_string.asm"

; Padding and magic number.
times 510-($-$$) db 0
dw 0xaa55